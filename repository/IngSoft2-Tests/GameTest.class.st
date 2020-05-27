Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests-Game-Tests'
}

{ #category : #tests }
GameTest >> noEffectBoardOf12 [
	^ Board
		withFields: (BoardGenerator with: 10 of: NoEffect)
		picking: 12
]

{ #category : #tests }
GameTest >> playerNamed: name [
	^ ScoreboardRaw ofPlayerNamed: name
]

{ #category : #tests }
GameTest >> test03WithMultipleDice [
	| aGame aPlayer otherPlayer |
	aPlayer := self playerNamed: 'Fran'.
	otherPlayer := self playerNamed: 'Manu'.
	aGame := Game
		with: (Die of: 6 rolling: #(4 1)) + (Die of: 8 rolling: #(7 3))
		andPlayers:
			{aPlayer.
			otherPlayer}
		andBoard: (self noEffectBoardOf12).
	aGame playUntilFinished.
	self assert: aGame hasFinished
]

{ #category : #tests }
GameTest >> test04DefaultGameLengthIsTwelve [
	| aGame |
	aGame := Game withPlayers: #('Fran').
	self assert: aGame length equals: 12
]

{ #category : #tests }
GameTest >> test05PlayGame [
	| aGame aPlayer |
	aPlayer := self playerNamed: 'Fran'.
	aGame := Game with: (Die of: 6 rolling: #(4)) andPlayers: {aPlayer} andBoard: self noEffectBoardOf12 .
	3 timesRepeat: [ aGame playATurn ].
	self assert: aGame hasFinished
]

{ #category : #tests }
GameTest >> test06PlayAGameAndFranWins [
	| aGame aPlayer otherPlayer |
	aPlayer := self playerNamed: 'Fran'.
	otherPlayer := self playerNamed: 'Manu'.
	aGame := Game
		with: (Die of: 6 rolling: #(4 1))
		andPlayers:
			{aPlayer.
			otherPlayer}
		andBoard: self noEffectBoardOf12.
	aGame playUntilFinished.
	self assert: aGame winner name equals: 'Fran'
]

{ #category : #tests }
GameTest >> test07PlayAGameAndFranFirstAndManuSecond [
	| aGame aPlayer otherPlayer |
	aPlayer := self playerNamed: 'Fran'.
	otherPlayer := self playerNamed: 'Manu'.
	aGame := Game
		with: (Die of: 6 rolling: #(1 4))
		andPlayers:
			{aPlayer.
			otherPlayer}
		andBoard: self noEffectBoardOf12.
	aGame playUntilFinished.
	self assert: (aGame att: 2) name equals: 'Fran'.
	self assert: (aGame att: 1) name equals: 'Manu'
]

{ #category : #tests }
GameTest >> test08CannotAskForWinnerOfAnUnfinishedGame [
	| aGame aPlayer otherPlayer |
	aPlayer := self playerNamed: 'Fran'.
	otherPlayer := self playerNamed: 'Manu'.
	aGame := Game
		with: (Die of: 6 rolling: #(4 1))
		andPlayers:
			{aPlayer.
			otherPlayer}
		andBoard: self noEffectBoardOf12.
	aGame playATurn.
	self
		should: [ aGame winner ]
		raise: InvalidAction
		withMessageText: 'The game has not finished yet.'
]

{ #category : #tests }
GameTest >> test09NewGameWith9Laps [
	| aGame aPlayer otherPlayer |
	aPlayer := self playerNamed: 'Fran'.
	otherPlayer := self playerNamed: 'Manu'.
	aGame := Game
		with: (Die of: 6 rolling: #(4 1))
		andPlayers:
			{aPlayer.
			otherPlayer}
		ofLaps: 9.
	self assert: aGame laps equals: 9.

]

{ #category : #tests }
GameTest >> test10ManuMakes2LapsAndWin [
	| aGame aPlayer otherPlayer |
	aPlayer := self playerNamed: 'Manu'.
	otherPlayer := self playerNamed: 'Fran'.
	aGame := Game
		with: (Die of: 6 rolling: #(1 4))
		andBoard: self noEffectBoardOf12
		andPlayers:
			{aPlayer.
			otherPlayer}
		andLaps: 2.
	aGame playUntilFinished.
	self assert: (aGame att: 1) laps equals: 2
]

{ #category : #tests }
GameTest >> test11TriggerAWormHole [
	| actualPlayer aGame |
	actualPlayer := self playerNamed: 'Manu'.
	aGame := Game
		with: (Die of: 6 rolling: #(6))
		andBoard: (Board withFields: (BoardGenerator with: 1 of: Wormhole) picking: 10)
		andPlayers: {actualPlayer}
		andLaps: 1.
	self assert: actualPlayer position equals: 0.
	aGame playATurn.
	self assert: actualPlayer position equals: 2.
]

{ #category : #tests }
GameTest >> test12TriggerASpeedUp [
	| actualPlayer aGame |
	actualPlayer :=self playerNamed: 'Manu'.
	aGame := Game
		with: (Die of: 6 rolling: #(6))
		andBoard: (Board withFields: (BoardGenerator with: 1 of: SpeedUp) picking: 10)
		andPlayers: {actualPlayer}
		andLaps: 1.
	aGame playATurn.
	self assert: actualPlayer position equals: 0.
	self assert: actualPlayer laps equals: 1
]

{ #category : #tests }
GameTest >> test13TriggerAaMoonWalkAndAPlayerStaysAtStart [
	| onePlayer aGame otherPlayer |
	onePlayer :=self playerNamed: 'Manu'.
	otherPlayer := self playerNamed: 'Fran'.
	aGame := Game
		with: (Die of: 6 rolling: #(6))
		andBoard: (Board withFields: (BoardGenerator with: 1 of: Moonwalk) picking: 10)
		andPlayers: {onePlayer . otherPlayer}
		andLaps: 1.
	aGame playATurn.
	self assert: otherPlayer position equals: 0
]

{ #category : #tests }
GameTest >> test14TriggerAaMoonWalkAndAPlayerMoves [
	| onePlayer aGame otherPlayer boardGen |
	onePlayer := self playerNamed: 'Manu'.
	otherPlayer := self playerNamed: 'Fran'.
	boardGen := BoardGenerator with: 1 of: Moonwalk.
	aGame := Game
		with: (Die of: 6 rolling: #(6))
		andBoard: (Board withFields: boardGen picking: 10)
		andPlayers:
			{onePlayer.
			otherPlayer}
		andLaps: 1.
	2 timesRepeat: [ aGame playATurn ].
	self assert: onePlayer position equals: (6 + (boardGen at: 1) fieldsToGoBack).
]

{ #category : #tests }
GameTest >> test15TriggerAnAtomicBomb [
	| actualPlayer aGame otherPlayer |
	actualPlayer :=self playerNamed: 'Manu'.
	otherPlayer := self playerNamed: 'Fran'.
	otherPlayer  updateAPlayerPosition: 5.
	aGame := Game
		with: (Die of: 6 rolling: #(6))
		andBoard: (Board withFields: (BoardGenerator with: 1 of: AtomicBomb) picking: 10)
		andPlayers: {actualPlayer . otherPlayer }
		andLaps: 1.
	aGame playATurn.
	self assert: actualPlayer position equals: 0
]

{ #category : #tests }
GameTest >> test16PlayAGameAndGetPodiumPositionOfEachPlayer [
	| aGame aPlayer otherPlayer aThirdPlayer |
	aPlayer := self playerNamed: 'Fran'.
	otherPlayer := self playerNamed: 'Manu'.
	aThirdPlayer := self playerNamed: 'Julivrone'.
	aGame := Game
		with: (Die of: 6 rolling: #(5 6 1))
		andPlayers:
			{aPlayer.
			otherPlayer.
			aThirdPlayer}
		andBoard: self noEffectBoardOf12.
	3 timesRepeat: [ aGame playATurn  ].
	self assert: (aGame podiumOf: aPlayer) equals: 2.
	self assert: (aGame podiumOf: otherPlayer) equals: 1.
	self assert: (aGame podiumOf: aThirdPlayer ) equals: 3.
	
]

{ #category : #tests }
GameTest >> test17CannotAskForPodiumPositionOfAPlayerThatIsNotInTheGame [
	| aGame aPlayer otherPlayer aThirdPlayer |
	aPlayer := self playerNamed: 'Fran'.
	otherPlayer := self playerNamed: 'Manu'.
	aThirdPlayer := self playerNamed: 'Julivrone'.
	aGame := Game
		with: (Die of: 6 rolling: #(6 5 1))
		andPlayers:
			{aPlayer.
			otherPlayer}
		andBoard: self noEffectBoardOf12.
	self
		should: [ aGame podiumOf: aThirdPlayer ]
		raise: InvalidAction
		withMessageText: 'El player no esta jugando.'
]
