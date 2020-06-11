Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#instVars : [
		'players',
		'die',
		'aNoEffect',
		'aWormhole',
		'anAtomicBomb',
		'aSpeedUp'
	],
	#category : #'IngSoft2-Tests-Game-Tests'
}

{ #category : #'as yet unclassified' }
GameTest >> cardsOf: aPlayer in: aGame [
	^ (self whereIs: aPlayer in: aGame) cardCount 
]

{ #category : #tests }
GameTest >> finalBoard [
	| anArrayOfFields aMoonwalk |
	aMoonwalk:= Moonwalk createField:5.
	anArrayOfFields := OrderedCollection new.
	5 timesRepeat: [ anArrayOfFields add: aNoEffect ].
	anArrayOfFields add: aWormhole.
	anArrayOfFields add: aSpeedUp.
	anArrayOfFields add: aNoEffect.
	anArrayOfFields add: anAtomicBomb.
	2 timesRepeat: [ anArrayOfFields add: aNoEffect ].
	anArrayOfFields add: aMoonwalk.
	7 timesRepeat: [ anArrayOfFields add: aNoEffect ].
	^ anArrayOfFields
]

{ #category : #'as yet unclassified' }
GameTest >> lapsOf: aPlayer in: aGame [
	^ (self whereIs: aPlayer in: aGame) laps
]

{ #category : #tests }
GameTest >> noEffectBoardOf12 [
	| boardGenerator |
	boardGenerator := BoardGenerator with: 10 of: NoEffect new.
	^ boardGenerator buildOf: 12
]

{ #category : #tests }
GameTest >> positionOf: aPlayer in: aGame [
	^ (self whereIs: aPlayer in: aGame) position
]

{ #category : #running }
GameTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	players := OrderedCollection withAll: {'Fran' . 'Manu'}.
	die := Die of: 6 rolling: #(4 1).
	aNoEffect := NoEffect new.
	aWormhole := Wormhole new.
	anAtomicBomb := AtomicBomb new.
	aSpeedUp := SpeedUp new
]

{ #category : #tests }
GameTest >> testActivateCancellationOfNonPlayedCard [
	| aGame |
	aGame := Game
		with: (Die of: 6 rolling: #(4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 1
		shuffling:
			(CardDeck
				with:
					{Cancellation new.
					Acceleration new}
				of: #(1 2)).
	aGame player: 'Manu' playCard: (Cancellation to: Acceleration new).
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 2.
	self assert: (self cardsOf: 'Manu' in: aGame) equals: 1.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 4.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0
]

{ #category : #tests }
GameTest >> testCannotAskForPodiumPositionOfAPlayerThatIsNotInTheGame [
	| aGame aThirdPlayer |
	aThirdPlayer := 'Julivrone'.
	aGame := Game
		with: (Die of: 6 rolling: #(6 5 1))
		on: self noEffectBoardOf12
		playedBy: players.
	self
		should: [ aGame podiumOf: aThirdPlayer ]
		raise: InvalidAction
		withMessageText: 'El player no esta jugando.'
]

{ #category : #tests }
GameTest >> testCannotAskForWinnerOfAnUnfinishedGame [
	| aGame |
	aGame := Game
		with: (Die of: 6 rolling: #(4 1))
		on: self noEffectBoardOf12
		playedBy: players.
	aGame playTurn.
	self
		should: [ aGame winner ]
		raise: InvalidAction
		withMessageText: 'The game has not finished yet.'
]

{ #category : #tests }
GameTest >> testCannotPlayAFinishedGame [
	| aGame |
	aGame := Game
		with: (Die of: 6 rolling: #(4 1))
		on: self noEffectBoardOf12
		playedBy: players.
	aGame playUntilFinished.
	self
		should: [ aGame playTurn ]
		raise: InvalidAction
		withMessageText: 'Cannot play a finished game.'
]

{ #category : #tests }
GameTest >> testDueloDeTitanes [
	| aGame |
	aGame := Game
		with: (Die of: 6 rolling: #(4 6 1 1))
		on: (Board withFields: self finalBoard)
		playedBy: players
		withLaps: 2.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0.
	aGame playTurn.	"1p1"	"4"
	self assert: (self positionOf: 'Fran' in: aGame) equals: 4.
	aGame playTurn.	"1p2 - SpeedUp"	"6"
	self assert: (self positionOf: 'Manu' in: aGame) equals: 10.
	aGame playTurn.	"2p1"	"1"
	self assert: (self positionOf: 'Fran' in: aGame) equals: 1.
	aGame playTurn.	"2p2 - Moonwalk!"	"1"
	self assert: (self positionOf: 'Manu' in: aGame) equals: 11.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.	"3p1"	"4"
	self assert: (self positionOf: 'Fran' in: aGame) equals: 4.
	aGame playTurn.	"3p2"	"6"
	self assert: (self positionOf: 'Manu' in: aGame) equals: 17.
	aGame playTurn.	"4p1 - Wormhole!"	"1"
	self assert: (self positionOf: 'Fran' in: aGame) equals: 1.
	aGame playTurn.	"4p2"	"1"
	self assert: (self positionOf: 'Manu' in: aGame) equals: 18.
	aGame playTurn.	"5p1 - Wormhole!"	"4"
	self assert: (self positionOf: 'Fran' in: aGame) equals: 1.
	aGame playTurn.	"5p2 - Wormhole and change of lap"	"6"
	self assert: (self positionOf: 'Manu' in: aGame) equals: 1.
	self assert: (self lapsOf: 'Manu' in: aGame) equals: 1.
	aGame playTurn.	"6p1"	"1"
	self assert: (self positionOf: 'Fran' in: aGame) equals: 2.
	aGame playTurn.	"6p2"	"1"
	self assert: (self positionOf: 'Manu' in: aGame) equals: 2.
	aGame playTurn.	"7p1 - SpeedUp!"	"4"
	self assert: (self positionOf: 'Fran' in: aGame) equals: 10.
	aGame playTurn.	"7p2 - Atomic Bomb!"	"6"
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	self assert: (self lapsOf: 'Manu' in: aGame) equals: 1.
	aGame playTurn.	"8p1"	"1"
	self assert: (self positionOf: 'Fran' in: aGame) equals: 1.
	aGame playTurn.	"8p2"	"1"
	self assert: (self positionOf: 'Manu' in: aGame) equals: 1.
	aGame playTurn.	"9p1 - Wormhole"	"4"
	self assert: (self positionOf: 'Fran' in: aGame) equals: 1.
	aGame playTurn.	"9p2"	"6"
	self assert: (self positionOf: 'Manu' in: aGame) equals: 7.
	aGame playTurn.	"10p1"	"1"
	self assert: (self positionOf: 'Fran' in: aGame) equals: 2.
	aGame playTurn.	"10p2 - Atomic Bomb!"	"1"
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0.
	self assert: (self lapsOf: 'Manu' in: aGame) equals: 1.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.	"11p1"	"4"
	self assert: (self positionOf: 'Fran' in: aGame) equals: 4.
	aGame playTurn.	"11p2 - SpeedUp!"	"6"
	self assert: (self positionOf: 'Manu' in: aGame) equals: 10.
	aGame playTurn.	"12p1 - Wormhole"	"1"
	self assert: (self positionOf: 'Fran' in: aGame) equals: 1.
	aGame playTurn.	"12p2 - Moonwalk"	"1"
	self assert: (self positionOf: 'Manu' in: aGame) equals: 11.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.	"13p1"	"4"
	self assert: (self positionOf: 'Fran' in: aGame) equals: 4.
	aGame playTurn.	"13p2"	"6"
	self assert: (self positionOf: 'Manu' in: aGame) equals: 17.
	aGame playTurn.	"14p1 - Wormhole"	"1"
	self assert: (self positionOf: 'Fran' in: aGame) equals: 1.
	aGame playTurn.	"14p2"	"1"
	self assert: (self positionOf: 'Manu' in: aGame) equals: 18.
	aGame playTurn.	"15p1 - Wormhole"	"4"
	self assert: (self positionOf: 'Fran' in: aGame) equals: 1.
	aGame playTurn.	"15p2"	"6"
	self assert: (self positionOf: 'Manu' in: aGame) equals: 1.
	self assert: aGame hasFinished.
	self assert: aGame winner name equals: 'Manu'
]

{ #category : #tests }
GameTest >> testGetTwoCardsAtGameStart [
	| aGame aPlayer |
	aPlayer := 'Fran'.
	aGame := Game
		with: die
		on: self noEffectBoardOf12
		playedBy: {aPlayer}.
	self assert: aGame actualPlayer cardCount equals: 2
]

{ #category : #tests }
GameTest >> testInstanceCreationAndAccessing [
	| aGame |
	aGame := Game
		with: die
		on: (BoardGenerator ucaGameDefault buildOf: 10)
		playedBy: players
		withLaps: 9.
	self assert: aGame laps equals: 9.
	self assert: aGame dice equals: die.
	self assert: aGame length equals: 10
]

{ #category : #tests }
GameTest >> testManuMakes2LapsAndWin [
	| aGame |
	aGame := Game
		with: (Die of: 6 rolling: #(1 4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 2.
	aGame playUntilFinished.
	self assert: aGame hasFinished.
	self assert: aGame winner laps equals: 2
]

{ #category : #tests }
GameTest >> testManuTriggersAtomicBombAndLapCountDoesNotDiminishForFran [
	| aGame  anArrayOfFields  |

	anArrayOfFields := OrderedCollection new.
	anArrayOfFields add: aNoEffect.
	anArrayOfFields add: anAtomicBomb.
	4 timesRepeat: [ anArrayOfFields add: aNoEffect ].
	aGame := Game
		with: (Die of: 10 rolling: #(10 1))
		on: (Board withFields: anArrayOfFields)
		playedBy: players
		withLaps: 2.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 4.
	self assert: (self lapsOf: 'Fran' in: aGame) equals: 1.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	self assert: (self lapsOf: 'Fran' in: aGame) equals: 1
]

{ #category : #tests }
GameTest >> testManuTriggersMoonwalkAndBecomesFirstInPodium [
	| aGame anArrayOfFields aMoonwalk |
	aMoonwalk := Moonwalk createField: 10.
	anArrayOfFields := OrderedCollection new.
	anArrayOfFields add: aNoEffect.
	anArrayOfFields add: aMoonwalk.
	4 timesRepeat: [ anArrayOfFields add: aNoEffect ].
	aGame := Game
		with: (Die of: 10 rolling: #(10 1))
		on: (Board withFields: anArrayOfFields)
		playedBy: players
		withLaps: 2.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 4.
	self assert: (self lapsOf: 'Fran' in: aGame) equals: 1.
	aGame playTurn.
	self assert: (aGame podiumOf: 'Manu') equals: 1.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 1.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	self assert: (self lapsOf: 'Fran' in: aGame) equals: 0
]

{ #category : #tests }
GameTest >> testManuTriggersMoonwalkAndLapCountDiminishesForFran [
	| aGame anArrayOfFields aMoonwalk |
	aMoonwalk := Moonwalk createField: 5.
	anArrayOfFields := OrderedCollection new.
	anArrayOfFields add: aNoEffect.
	anArrayOfFields add: aMoonwalk.
	4 timesRepeat: [ anArrayOfFields add: aNoEffect ].
	aGame := Game
		with: (Die of: 10 rolling: #(10 1))
		on: (Board withFields: anArrayOfFields)
		playedBy: players
		withLaps: 2.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 4.
	self assert: (self lapsOf: 'Fran' in: aGame) equals: 1.
	aGame playTurn.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 1.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 5.
	self assert: (self lapsOf: 'Fran' in: aGame) equals: 0
]

{ #category : #tests }
GameTest >> testPlayAGameAndFranSecondAndManuFirst [
	| aGame |
	aGame := Game
		with: (Die of: 6 rolling: #(1 4))
		on: self noEffectBoardOf12
		playedBy: players.
	aGame playUntilFinished.
	self assert: (aGame atPodium: 2) name equals: 'Fran'.
	self assert: (aGame atPodium: 1) name equals: 'Manu'
]

{ #category : #tests }
GameTest >> testPlayAGameAndFranWins [
	| aGame |
	aGame := Game
		with: (Die of: 6 rolling: #(4 1))
		on: self noEffectBoardOf12
		playedBy: players.
	aGame playUntilFinished.
	self assert: aGame winner name equals: 'Fran'
]

{ #category : #tests }
GameTest >> testPlayAGameAndGetPodiumPositionOfEachPlayer [
	| aGame aThirdPlayer |
	aThirdPlayer := 'Julivrone'.
	players add: aThirdPlayer.
	aGame := Game
		with: (Die of: 6 rolling: #(5 6 1))
		on: self noEffectBoardOf12
		playedBy: players.
	3 timesRepeat: [ aGame playTurn ].
	self assert: (aGame podiumOf: 'Fran') equals: 2.
	self assert: (aGame podiumOf: 'Manu') equals: 1.
	self assert: (aGame podiumOf: aThirdPlayer) equals: 3
]

{ #category : #tests }
GameTest >> testPlayGame [
	| aGame aPlayer |
	aPlayer := 'Fran'.
	aGame := Game
		with: (Die of: 6 rolling: #(4))
		on: self noEffectBoardOf12
		playedBy: {aPlayer}.
	3 timesRepeat: [ aGame playTurn ].
	self assert: aGame hasFinished
]

{ #category : #tests }
GameTest >> testSpeedUpMakesManuGoFirst [
	| aGame anArrayOfFields |
	anArrayOfFields := OrderedCollection new.
	anArrayOfFields add: aNoEffect.
	anArrayOfFields add: aSpeedUp.
	4 timesRepeat: [ anArrayOfFields add: aNoEffect ].
	aGame := Game
		with: (Die of: 10 rolling: #(3 1))
		on: (Board withFields: anArrayOfFields)
		playedBy: players
		withLaps: 2.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 3.
	aGame playTurn.
	self assert: (aGame podiumOf: 'Manu') equals: 1.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 5
]

{ #category : #tests }
GameTest >> testTriggerAPickCard [
	| actualPlayer aGame |
	actualPlayer := 'Manu'.
	aGame := Game
		with: die
		on: ((BoardGenerator with: 10 of: PickCard new) buildOf: 10)
		playedBy: {actualPlayer}
		withLaps: 1.
	self assert: aGame actualPlayer cardCount equals: 2.
	aGame playTurn.
	self assert: aGame actualPlayer cardCount equals: 3.
]

{ #category : #tests }
GameTest >> testTriggerASpeedUp [
	| aGame actualPlayer |
	actualPlayer := 'Manu'.
	aGame := Game
		with: (Die of: 6 rolling: #(6))
		on: ((BoardGenerator with: 10 of: SpeedUp new) buildOf: 10)
		playedBy: {actualPlayer}
		withLaps: 1.
	self assert: (self positionOf: actualPlayer in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: actualPlayer in: aGame) equals: 0.
	self assert: (self lapsOf: actualPlayer in: aGame) equals: 1.
	self assert: aGame hasFinished
]

{ #category : #tests }
GameTest >> testTriggerAWormHole [
	| actualPlayer aGame |
	actualPlayer := 'Manu'.
	aGame := Game
		with: (Die of: 6 rolling: #(6))
		on: ((BoardGenerator with: 10 of: Wormhole new) buildOf: 10)
		playedBy: {actualPlayer}
		withLaps: 1.
	self assert: (self positionOf: actualPlayer in: aGame) equals: 0.
	aGame playTurn.
	self assert: aGame actualPlayer position equals: 2
]

{ #category : #tests }
GameTest >> testTriggerAaMoonWalkAndAPlayerMoves [
	| aGame boardGen |
	boardGen := BoardGenerator with: 1 of: (Moonwalk createField: 5).
	aGame := Game
		with: (Die of: 6 rolling: #(6))
		on: (boardGen buildOf: 10)
		playedBy: players
		withLaps: 1.
	2 timesRepeat: [ aGame playTurn ].
	self assert: (self positionOf: 'Fran' in: aGame) equals: 1
]

{ #category : #tests }
GameTest >> testTriggerAaMoonWalkAndAnotherPlayerStaysAtStart [
	| aGame |
	aGame := Game
		with: (Die of: 6 rolling: #(6))
		on: ((BoardGenerator with: 10 of: Moonwalk createField) buildOf: 10)
		playedBy: players
		withLaps: 1.
	aGame playTurn.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0.
	self assert: (aGame podiumOf: 'Fran') equals: 1
]

{ #category : #tests }
GameTest >> testTriggerAccelerationEffect [
	| aGame |
	aGame := Game
		with: (Die of: 6 rolling: #(4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 1
		shuffling: (CardDeck with: {Acceleration new}).
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 2.
	aGame player: 'Fran' playCard: Acceleration new.
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 1.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 5.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0.
	aGame player: 'Manu' playCard: Acceleration new.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 5.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 6
]

{ #category : #tests }
GameTest >> testTriggerAnAtomicBombAtStartDoesNothing [
	| aGame |
	aGame := Game
		with: (Die of: 6 rolling: #(6))
		on: ((BoardGenerator with: 10 of: AtomicBomb new) buildOf: 10)
		playedBy: players
		withLaps: 1.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0
]

{ #category : #tests }
GameTest >> testTriggerCancellationEffect [
	| aGame |
	aGame := Game
		with: (Die of: 6 rolling: #(4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 1
		shuffling:
			(CardDeck
				with:
					{Cancellation new.
					Acceleration new}
				of: #(1 2)).
	aGame player: 'Fran' playCard: Acceleration new.
	aGame player: 'Manu' playCard: (Cancellation to: Acceleration new).
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 1.
	self assert: (self cardsOf: 'Manu' in: aGame) equals: 1.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 4.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0
]

{ #category : #tests }
GameTest >> testTriggerOverloadEffect [
	| aGame |
	aGame := Game
		with: (Die of: 6 rolling: #(4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 1
		shuffling: (CardDeck with: {Overload new} of: #(1 2)).
	aGame player: 'Fran' playCard: (Overload to: 'Manu').
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 1.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 4.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 2
]

{ #category : #tests }
GameTest >> testTriggerRedoAcceleration [
	| aGame |
	aGame := Game
		with: (Die of: 6 rolling: #(4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 1
		shuffling: (CardDeck with: {Acceleration new. Redo new} of: #(1 2)).
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 2.
	aGame player: 'Fran' playCard: Acceleration new.
	aGame player: 'Fran' playCard: Redo new.
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 0.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 6.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0.
]

{ #category : #tests }
GameTest >> testTriggerRedoSpeed [
	| aGame |
	aGame := Game
		with: (Die of: 6 rolling: #(4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 1
		shuffling: (CardDeck with: {Speed new. Redo new} of: #(1 2)).
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 2.
	aGame player: 'Fran' playCard: (Speed to: 'Fran').
	aGame player: 'Manu' playCard: (Redo to: 'Manu').
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 1.
	self assert: (self cardsOf: 'Manu' in: aGame) equals: 1.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 5.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 5.
]

{ #category : #tests }
GameTest >> testTriggerSpeedEffect [
	| aGame |
	aGame := Game
		with: (Die of: 6 rolling: #(4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 1
		shuffling: (CardDeck with: {Speed  new} of: #(1 2)).
	aGame player: 'Fran' playCard: (Speed to: 'Fran').
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 1.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 5.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0.
]

{ #category : #tests }
GameTest >> testTriggerWormholeAndDismishTheLaps [
	| aGame actualPlayer anArrayOfFields |
	actualPlayer := 'Manu'.
	anArrayOfFields := OrderedCollection new.
	anArrayOfFields add: aNoEffect.
	anArrayOfFields add: aWormhole.
	4 timesRepeat: [ anArrayOfFields add: aNoEffect ].
	aGame := Game
		with: (Die of: 6 rolling: #(1 6))
		on: (Board withFields: anArrayOfFields)
		playedBy: {actualPlayer}
		withLaps: 2.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0.
	self assert: (self lapsOf: 'Manu' in: aGame) equals: 1.
	aGame playTurn.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 3.
	self assert: (self lapsOf: 'Manu' in: aGame) equals: 0
]

{ #category : #tests }
GameTest >> testWithMultipleDice [
	| aGame |
	aGame := Game
		with: die + (Die of: 8 rolling: #(7 3))
		on: self noEffectBoardOf12
		playedBy: players.
	aGame playUntilFinished.
	self assert: aGame hasFinished
]

{ #category : #tests }
GameTest >> testWormholeMakesManuNotFinishAGame [
	| aGame actualPlayer anArrayOfFields |
	actualPlayer := 'Manu'.
	anArrayOfFields := OrderedCollection new.
	anArrayOfFields add: aWormhole.
	5 timesRepeat: [ anArrayOfFields add: aNoEffect ].
	aGame := Game
		with: (Die of: 6 rolling: #(6))
		on: (Board withFields: anArrayOfFields)
		playedBy: {actualPlayer}
		withLaps: 1.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 2.
	self assert: (self lapsOf: 'Manu' in: aGame) equals: 0.
	self assert: aGame hasFinished not
]

{ #category : #'as yet unclassified' }
GameTest >> whereIs: aPlayer in: aGame [
	^ aGame atPodium: (aGame podiumOf: aPlayer)
]
