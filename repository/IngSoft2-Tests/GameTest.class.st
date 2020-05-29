Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#instVars : [
		'players',
		'die'
	],
	#category : #'IngSoft2-Tests-Game-Tests'
}

{ #category : #tests }
GameTest >> noEffectBoardOf12 [
| boardGenerator |
boardGenerator := BoardGenerator with: 10 of: NoEffect new. 
	^ (boardGenerator buildOf:12).
]

{ #category : #tests }
GameTest >> playerNamed: name [
	^ ScoreboardRaw ofPlayerNamed: name
]

{ #category : #running }
GameTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
players := OrderedCollection withAll: { 'Fran' . 'Manu' }.
die := Die of: 6 rolling: #(4 1)
]

{ #category : #tests }
GameTest >> test03WithMultipleDice [
	| aGame |
	aGame := Game
		with: die + (Die of: 8 rolling: #(7 3))
		playedBy: players
		on: (self noEffectBoardOf12).
	aGame playUntilFinished.
	self assert: aGame hasFinished
]

{ #category : #tests }
GameTest >> test04DefaultGameLengthIsTwelve [
	| aGame |
	aGame := Game playedBy: players.
	self assert: aGame length equals: 12
]

{ #category : #tests }
GameTest >> test05PlayGame [
	| aGame aPlayer |
	aPlayer := 'Fran'.
	aGame := Game with: (Die of: 6 rolling: #(4)) playedBy: {aPlayer} on: self noEffectBoardOf12 .
	3 timesRepeat: [ aGame playTurn ].
	self assert: aGame hasFinished
]

{ #category : #tests }
GameTest >> test06PlayAGameAndFranWins [
	| aGame|
	aGame := Game
		with: (Die of: 6 rolling: #(4 1))
		playedBy: players
		on: self noEffectBoardOf12.
	aGame playUntilFinished.
	self assert: aGame winner name equals: 'Fran'
]

{ #category : #tests }
GameTest >> test07PlayAGameAndFranSecondAndManuFirst [
	| aGame|
	aGame := Game
		with: (Die of: 6 rolling: #(1 4))
		playedBy: players
		on: self noEffectBoardOf12.
	aGame playUntilFinished.
	self assert: (aGame atPodium: 2) name equals: 'Fran'.
	self assert: (aGame atPodium: 1) name equals: 'Manu'
]

{ #category : #tests }
GameTest >> test08CannotAskForWinnerOfAnUnfinishedGame [
	| aGame |
	aGame := Game
		with: (Die of: 6 rolling: #(4 1))
		playedBy: players
		on: self noEffectBoardOf12.
	aGame playTurn.
	self
		should: [ aGame winner ]
		raise: InvalidAction
		withMessageText: 'The game has not finished yet.'
]

{ #category : #tests }
GameTest >> test09NewGameWith9Laps [
	| aGame |
	aGame := Game
		with: (Die of: 6 rolling: #(4 1))
		playedBy: players
		withLaps: 9.
	self assert: aGame laps equals: 9
]

{ #category : #tests }
GameTest >> test10ManuMakes2LapsAndWin [
	| aGame |
	aGame := Game
		with: (Die of: 6 rolling: #(1 4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 2.
	aGame playUntilFinished.
	self assert: aGame hasFinished.
	self assert: (aGame winner) laps equals: 2
]

{ #category : #tests }
GameTest >> test11TriggerAWormHole [
	| actualPlayer aGame |
	actualPlayer := 'Manu'.
	aGame := Game
		with: (Die of: 6 rolling: #(6))
		on: ((BoardGenerator with: 10 of: (Wormhole new ))buildOf:10)
		playedBy: {actualPlayer}
		withLaps: 1.
	self assert: aGame actualPlayer position equals: 0.
	aGame playTurn.
	self assert: aGame actualPlayer position equals: 2
]

{ #category : #tests }
GameTest >> test12TriggerASpeedUp [
	| aGame actualPlayer |
	actualPlayer := 'Manu'.
	aGame := Game
		with: (Die of: 6 rolling: #(6))
		on: ((BoardGenerator with: 10 of: (SpeedUp new ))buildOf:10)
		playedBy: {actualPlayer}
		withLaps: 1.
	aGame playTurn.
	self assert: aGame actualPlayer position equals: 0.
	self assert: aGame actualPlayer laps equals: 1
]

{ #category : #tests }
GameTest >> test13TriggerAaMoonWalkAndAPlayerStaysAtStart [
	| aGame |
	aGame := Game
		with: (Die of: 6 rolling: #(6))
		on: ((BoardGenerator with: 10 of: (Moonwalk createField))buildOf:10)
		playedBy: players
		withLaps: 1.
	aGame playTurn.
	self assert: aGame actualPlayer position equals: 0
]

{ #category : #tests }
GameTest >> test14TriggerAaMoonWalkAndAPlayerMoves [
	| aGame boardGen |
	boardGen := BoardGenerator with: 1 of: Moonwalk createField .
	aGame := Game
		with: (Die of: 6 rolling: #(6))
		on: (boardGen buildOf: 10)
		playedBy: players
		withLaps: 1.
	2 timesRepeat: [ aGame playTurn ].
	self
		assert: aGame actualPlayer position
		equals: 6 + (boardGen at: 1) fieldsToGoBack
]

{ #category : #tests }
GameTest >> test15TriggerAnAtomicBomb [
	| aGame |
	aGame := Game
		with: (Die of: 6 rolling: #(6))
		on: (((BoardGenerator with: 10 of: (AtomicBomb  new ))buildOf:10))
		playedBy: players
		withLaps: 1.
	aGame playTurn.
	self assert: aGame actualPlayer position equals: 0
]

{ #category : #tests }
GameTest >> test16PlayAGameAndGetPodiumPositionOfEachPlayer [
	| aGame aThirdPlayer |
	aThirdPlayer :=  'Julivrone'.
	players add: aThirdPlayer.
	aGame := Game
		with: (Die of: 6 rolling: #(5 6 1))
		playedBy:
players
		on: self noEffectBoardOf12.
	3 timesRepeat: [ aGame playTurn  ].
	self assert: (aGame podiumOf: 'Fran') equals: 2.
	self assert: (aGame podiumOf: 'Manu') equals: 1.
	self assert: (aGame podiumOf: aThirdPlayer ) equals: 3.
	
]

{ #category : #tests }
GameTest >> test17CannotAskForPodiumPositionOfAPlayerThatIsNotInTheGame [
	| aGame  aThirdPlayer |
	aThirdPlayer := 'Julivrone'.
	aGame := Game
		with: (Die of: 6 rolling: #(6 5 1))
		playedBy: players
		on: self noEffectBoardOf12.
	self
		should: [ aGame podiumOf: aThirdPlayer ]
		raise: InvalidAction
		withMessageText: 'El player no esta jugando.'
]
