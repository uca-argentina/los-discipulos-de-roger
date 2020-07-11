Class {
	#name : #UCAGameTest,
	#superclass : #TestCase,
	#instVars : [
		'players',
		'die',
		'aNoEffect',
		'aWormhole',
		'anAtomicBomb',
		'aSpeedUp',
		'anAcceleration',
		'aMoonwalk',
		'aCancellation',
		'anOverload',
		'aSpeed',
		'aRedo',
		'aRepeat',
		'targetFran',
		'targetManu',
		'nonTarget'
	],
	#category : #'IngSoft2-Tests-UCAGame-Tests'
}

{ #category : #checking }
UCAGameTest >> cardsOf: aPlayer in: aGame [
	^ (self whereIs: aPlayer in: aGame) cardDeckCount 
]

{ #category : #tests }
UCAGameTest >> finalBoard [
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

{ #category : #checking }
UCAGameTest >> lapsOf: aPlayer in: aGame [
	^ (self whereIs: aPlayer in: aGame) laps
]

{ #category : #tests }
UCAGameTest >> noEffectBoardOf12 [
	| boardGenerator |
	boardGenerator := BoardGenerator with: 10 of: NoEffect new.
	^ boardGenerator buildOf: 12
]

{ #category : #tests }
UCAGameTest >> overloadTestBoard [
	| anArrayOfFields |
	anArrayOfFields := OrderedCollection new.
	anArrayOfFields add: aNoEffect.
	anArrayOfFields add: PickCard new.
	anArrayOfFields add: aNoEffect.
	anArrayOfFields add: aWormhole.
	anArrayOfFields add: aNoEffect.
	anArrayOfFields add: aSpeedUp.
	2 timesRepeat: [ anArrayOfFields add: aNoEffect ].
	anArrayOfFields add: anAtomicBomb.
	2 timesRepeat: [ anArrayOfFields add: aNoEffect ].
	^ anArrayOfFields
]

{ #category : #tests }
UCAGameTest >> playUntilFinished: aGame [
	| iterator |
	iterator := 0.
	[ aGame hasFinished and: iterator < 1000 ]
		whileFalse: [ self some: aGame actualPlayer name playCardFor: aGame.
			aGame playTurn.
			iterator := iterator + 1 ]
]

{ #category : #'as yet unclassified' }
UCAGameTest >> playUntilFinishedWithOutCardsA: aGame [
	[ aGame hasFinished ] whileFalse: [ aGame playTurn ]
]

{ #category : #tests }
UCAGameTest >> positionOf: aPlayer in: aGame [
	^ (self whereIs: aPlayer in: aGame) position
]

{ #category : #running }
UCAGameTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	super setUp.
	players := OrderedCollection withAll: {'Fran' . 'Manu'}.
	die := Die of: 6 rolling: #(4 1).
	aNoEffect := NoEffect new.
	aWormhole := Wormhole new.
	anAtomicBomb := AtomicBomb new.
	aSpeedUp := SpeedUp new.
	anAcceleration := Acceleration to: NonTarget new.
	aCancellation := Cancellation  to: NonTarget new.
	anOverload := Overload  to: NonTarget new.
	aSpeed := Speed  to: NonTarget new.
	aRedo := Redo  to: NonTarget new.
	aRepeat := Repeat to: NonTarget new.
	targetFran := TargetPlayer pointing: 'Fran'.
	targetManu := TargetPlayer pointing: 'Manu'.
	nonTarget := NonTarget new.
]

{ #category : #'as yet unclassified' }
UCAGameTest >> some: player playCardFor: aGame [ 
		[ 
	aGame player: player playCard: (Overload to: targetManu).
	aGame player: player playCard: (Speed to: targetFran).
	aGame player: player playCard: (Acceleration to: nonTarget).
	aGame player: player playCard: (Cancellation to: anAcceleration).
	aGame player: player playCard: (Redo to: targetFran).
	aGame player: player playCard: (Repeat to: nonTarget) ]
		on: InvalidAction
		do: [  ].
]

{ #category : #tests }
UCAGameTest >> speedTestBoard [
	| anArrayOfFields |
	anArrayOfFields := OrderedCollection new.
	2 timesRepeat: [ anArrayOfFields add: aNoEffect ].
	anArrayOfFields add: PickCard new.
	anArrayOfFields add: aNoEffect.
	anArrayOfFields add: aWormhole.
	anArrayOfFields add: aSpeedUp.
	5 timesRepeat: [ anArrayOfFields add: aNoEffect ].
	anArrayOfFields add: anAtomicBomb.
	^ anArrayOfFields
]

{ #category : #tests }
UCAGameTest >> testActivateCancellationOfNonPlayedCard [
	| aGame |
	aGame := UCAGame
		with: (Die of: 6 rolling: #(4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 1
		shuffling:
			(CardDeck
				with:
					{aCancellation.
					anAcceleration.aCancellation.
					anAcceleration}
				).
	aGame player: 'Fran' playCard: anAcceleration.
	aGame player: 'Manu' playCard: (Cancellation to: (TargetCard pointing: anOverload)).
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 1.
	self assert: (self cardsOf: 'Manu' in: aGame) equals: 1.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 5.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0
]

{ #category : #tests }
UCAGameTest >> testCannotAskForPodiumPositionOfAPlayerThatIsNotInTheGame [
	| aGame aThirdPlayer |
	aThirdPlayer := 'Julivrone'.
	aGame := UCAGame
		with: (Die of: 6 rolling: #(6 5 1))
		on: self noEffectBoardOf12
		playedBy: players.
	self
		should: [ aGame podiumOf: aThirdPlayer ]
		raise: InvalidAction
		withMessageText: 'El player no esta jugando.'
]

{ #category : #tests }
UCAGameTest >> testCannotAskForWinnerOfAnUnfinishedGame [
	| aGame |
	aGame := UCAGame
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
UCAGameTest >> testCannotLayCancellationToEmptyCardDeck [
	| aGame |
	aGame := UCAGame
		with: (Die of: 6 rolling: #(4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 1
		shuffling:
			(CardDeck
				with:
					{aCancellation .
					anAcceleration.aCancellation .
					anAcceleration}).
	self should: [aGame player: 'Manu' playCard: (Cancellation to: (TargetCard pointing: anAcceleration) )]
			raise: InvalidAction 
			withMessageText: 'Invalid Card Usage'.
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 2.
	self assert: (self cardsOf: 'Manu' in: aGame) equals: 2.
	
]

{ #category : #tests }
UCAGameTest >> testCannotPlayAFinishedGame [
	| aGame |
	aGame := UCAGame
		with: (Die of: 6 rolling: #(4 1))
		on: self noEffectBoardOf12
		playedBy: players.
	self playUntilFinishedWithOutCardsA: aGame .
	self
		should: [ aGame playTurn ]
		raise: InvalidAction
		withMessageText: 'Cannot play a finished game.'
]

{ #category : #tests }
UCAGameTest >> testCannotReShuffleIfDiscardDeckIsEmpty [
	| aGame |
	aGame := UCAGame
		with: (Die of: 6 rolling: #(4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 1
		shuffling:
			(CardDeck
				with:
					{aSpeed.
					aCancellation.
					aRepeat.
					aSpeed}).
	self
		should: [ aGame reShuffle ]
		raise: InvalidAction
		withMessageText: 'Cannot shuffle an empty deck'
]

{ #category : #tests }
UCAGameTest >> testDueloDeTitanes [
	| aGame |
	aGame := UCAGame
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
UCAGameTest >> testGetTwoCardsAtGameStart [
	| aGame aPlayer |
	aPlayer := 'Fran'.
	aGame := UCAGame
		with: die
		on: self noEffectBoardOf12
		playedBy: {aPlayer}.
	self assert: aGame actualPlayer cardDeckCount equals: 2.
	self assert: aGame cardDeckCount equals: 30
]

{ #category : #tests }
UCAGameTest >> testInstanceCreationAndAccessing [
	| aGame |
	aGame := UCAGame
		with: die
		on: (BoardGenerator ucaGameDefault buildOf: 10)
		playedBy: players
		withLaps: 9.
	self assert: aGame laps equals: 9.
	self assert: aGame dice equals: die.
	self assert: aGame length equals: 10
]

{ #category : #tests }
UCAGameTest >> testManuCantPlayPermanentCardBecauseItsNotHisTurn [
	| aGame |
	aGame := UCAGame
		with: die
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 1
		shuffling: (CardDeck with: {anAcceleration.anAcceleration.anAcceleration.anAcceleration}).
	
	self should: [ aGame player: 'Manu' playCard: anAcceleration. ] raise: InvalidAction withMessageText: 'It is not the card bearers turn'.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
]

{ #category : #tests }
UCAGameTest >> testManuMakes2LapsAndWin [
	| aGame |
	aGame := UCAGame
		with: (Die of: 6 rolling: #(1 4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 2.
	self playUntilFinishedWithOutCardsA: aGame. 
	self assert: aGame hasFinished.
	self assert: aGame winner laps equals: 2
]

{ #category : #tests }
UCAGameTest >> testManuTriggersAtomicBombAndLapCountDoesNotDiminishForFran [
	| aGame anArrayOfFields |
	anArrayOfFields := OrderedCollection new.
	anArrayOfFields add: aNoEffect.
	anArrayOfFields add: anAtomicBomb.
	4 timesRepeat: [ anArrayOfFields add: aNoEffect ].
	aGame := UCAGame
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
UCAGameTest >> testManuTriggersMoonwalkAndBecomesFirstInPodium [
	| aGame anArrayOfFields aMoonwalk |
	aMoonwalk := Moonwalk createField: 10.
	anArrayOfFields := OrderedCollection new.
	anArrayOfFields add: aNoEffect.
	anArrayOfFields add: aMoonwalk.
	4 timesRepeat: [ anArrayOfFields add: aNoEffect ].
	aGame := UCAGame
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
UCAGameTest >> testManuTriggersMoonwalkAndLapCountDiminishesForFran [
	| aGame anArrayOfFields aMoonwalk |
	aMoonwalk := Moonwalk createField: 5.
	anArrayOfFields := OrderedCollection new.
	anArrayOfFields add: aNoEffect.
	anArrayOfFields add: aMoonwalk.
	4 timesRepeat: [ anArrayOfFields add: aNoEffect ].
	aGame := UCAGame
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
UCAGameTest >> testPlayAGameAndFranSecondAndManuFirst [
	| aGame |
	aGame := UCAGame
		with: (Die of: 6 rolling: #(1 4))
		on: self noEffectBoardOf12
		playedBy: players.
	self playUntilFinishedWithOutCardsA: aGame. 
	self assert: (aGame atPodium: 2) name equals: 'Fran'.
	self assert: (aGame atPodium: 1) name equals: 'Manu'
]

{ #category : #tests }
UCAGameTest >> testPlayAGameAndFranWins [
	| aGame |
	aGame := UCAGame
		with: (Die of: 6 rolling: #(4 1))
		on: self noEffectBoardOf12
		playedBy: players.
	self playUntilFinishedWithOutCardsA: aGame. 
	self assert: aGame winner name equals: 'Fran'
]

{ #category : #tests }
UCAGameTest >> testPlayAGameAndGetPodiumPositionOfEachPlayer [
	| aGame aThirdPlayer |
	aThirdPlayer := 'Julivrone'.
	players add: aThirdPlayer.
	aGame := UCAGame
		with: (Die of: 6 rolling: #(5 6 1))
		on: self noEffectBoardOf12
		playedBy: players.
	3 timesRepeat: [ aGame playTurn ].
	self assert: (aGame podiumOf: 'Fran') equals: 2.
	self assert: (aGame podiumOf: 'Manu') equals: 1.
	self assert: (aGame podiumOf: aThirdPlayer) equals: 3
]

{ #category : #tests }
UCAGameTest >> testPlayGame [
	| aGame aPlayer |
	aPlayer := 'Fran'.
	aGame := UCAGame
		with: (Die of: 6 rolling: #(4))
		on: self noEffectBoardOf12
		playedBy: {aPlayer}.
	3 timesRepeat: [ aGame playTurn ].
	self assert: aGame hasFinished
]

{ #category : #tests }
UCAGameTest >> testReShuffleCardDeck [
	| aGame |
	aGame := UCAGame
		with: (Die of: 6 rolling: #(4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 1
		shuffling: (CardDeck with: {aSpeed.aCancellation.aRepeat.aSpeed}).
	aGame player: 'Fran' playCard: (Speed to: targetFran).
	aGame player: 'Fran' playCard: (Cancellation to: (TargetCard pointing: (Speed to: (targetFran)))).
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 0.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	aGame player: 'Manu' playCard: aRepeat.
	aGame player: 'Manu' playCard: aSpeed.
	self assert: aGame cardDeck cardCount equals: 0.
	self assert: aGame discardDeck cardCount equals: 3.
	aGame reShuffle.
	self assert: aGame cardDeck cardCount equals: 3.
]

{ #category : #tests }
UCAGameTest >> testReShuffleCardDeckIfItIsEmpty [
	| aGame |
	aGame := UCAGame
		with: (Die of: 6 rolling: #(4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 1
		shuffling: (CardDeck with: {aSpeed.aCancellation.aRepeat.aSpeed}).
	aGame player: 'Fran' playCard: (Speed to: targetFran).
	aGame player: 'Fran' playCard: (Cancellation to: (TargetCard pointing: (Speed to: (targetFran)))).
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 0.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	aGame player: 'Manu' playCard: aRepeat.
	aGame player: 'Manu' playCard: aSpeed.
	self assert: aGame cardDeck cardCount equals: 0.
	aGame pickCardForActualPlayer.
	self assert: aGame discardDeck cardCount equals: 0.
	self assert: aGame cardDeck cardCount equals: 2.
]

{ #category : #tests }
UCAGameTest >> testSpeedUpMakesManuGoFirst [
	| aGame anArrayOfFields |
	anArrayOfFields := OrderedCollection new.
	anArrayOfFields add: aNoEffect.
	anArrayOfFields add: aSpeedUp.
	4 timesRepeat: [ anArrayOfFields add: aNoEffect ].
	aGame := UCAGame
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
UCAGameTest >> testTitanShowdown [
	| aGame |

	aGame := UCAGame
		with: Die d6
		on: (BoardGenerator ucaGameDefault buildOf: 20)
		playedBy: players
		withLaps: 3
		shuffling: (CardDeck defaultWith:32).
	self playUntilFinished: aGame.
	self assert: aGame hasFinished.
]

{ #category : #tests }
UCAGameTest >> testTriggerAPickCard [
	| actualPlayer aGame |
	actualPlayer := 'Manu'.
	aGame := UCAGame
		with: die
		on: ((BoardGenerator with: 10 of: PickCard new) buildOf: 10)
		playedBy: {actualPlayer}
		withLaps: 1.
	self assert: aGame actualPlayer cardDeckCount equals: 2.
	aGame playTurn.
	self assert: aGame actualPlayer cardDeckCount equals: 3.
]

{ #category : #tests }
UCAGameTest >> testTriggerASpeedUp [
	| aGame actualPlayer |
	actualPlayer := 'Manu'.
	aGame := UCAGame
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
UCAGameTest >> testTriggerAWormHole [
	| actualPlayer aGame |
	actualPlayer := 'Manu'.
	aGame := UCAGame
		with: (Die of: 6 rolling: #(6))
		on: ((BoardGenerator with: 10 of: Wormhole new) buildOf: 10)
		playedBy: {actualPlayer}
		withLaps: 1.
	self assert: (self positionOf: actualPlayer in: aGame) equals: 0.
	aGame playTurn.
	self assert: aGame actualPlayer position equals: 2
]

{ #category : #tests }
UCAGameTest >> testTriggerAaMoonWalkAndAPlayerMoves [
	| aGame boardGen |
	boardGen := BoardGenerator with: 1 of: (Moonwalk createField: 5).
	aGame := UCAGame
		with: (Die of: 6 rolling: #(6))
		on: (boardGen buildOf: 10)
		playedBy: players
		withLaps: 1.
	2 timesRepeat: [ aGame playTurn ].
	self assert: (self positionOf: 'Fran' in: aGame) equals: 1
]

{ #category : #tests }
UCAGameTest >> testTriggerAaMoonWalkAndAnotherPlayerStaysAtStart [
	| aGame |
	aGame := UCAGame
		with: (Die of: 6 rolling: #(6))
		on: ((BoardGenerator with: 10 of: Moonwalk createField) buildOf: 10)
		playedBy: players
		withLaps: 1.
	aGame playTurn.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0.
	self assert: (aGame podiumOf: 'Fran') equals: 1
]

{ #category : #tests }
UCAGameTest >> testTriggerAccelerationEffectOnceAndMultipleTimes [
	| aGame |
	aGame := UCAGame
		with: (Die of: 6 rolling: #(4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 1
		shuffling: (CardDeckGenerator with: {anAcceleration.anAcceleration.anAcceleration.anAcceleration}).
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 2.
	aGame player: 'Fran' playCard: anAcceleration.
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 1.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 5.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0.
	aGame player: 'Manu' playCard: anAcceleration.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 5.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 6
]

{ #category : #tests }
UCAGameTest >> testTriggerAnAtomicBombAtStartDoesNothing [
	| aGame |
	aGame := UCAGame
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
UCAGameTest >> testTriggerCancellationEffect [
	| aGame |
	aGame := UCAGame
		with: (Die of: 6 rolling: #(4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 1
		shuffling:
			(CardDeck
				with:
					{aCancellation .
					anAcceleration. 
					aCancellation. 
					anAcceleration }).
	aGame player: 'Fran' playCard: anAcceleration.
	aGame player: 'Manu' playCard: (Cancellation to: (TargetCard pointing: anAcceleration) ).
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 1.
	self assert: (self cardsOf: 'Manu' in: aGame) equals: 1.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 4.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0
]

{ #category : #tests }
UCAGameTest >> testTriggerCancellationEffectToAnSpecificSpeed [
	| aGame |
	aGame := UCAGame
		with: (Die of: 6 rolling: #(4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 1
		shuffling:
			(CardDeck
				with:
					{aCancellation.
					aSpeed.
					aCancellation.
					aSpeed}).
	aGame player: 'Fran' playCard: (Speed to: targetFran).
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 1.
	self assert: (self cardsOf: 'Manu' in: aGame) equals: 2.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 5.
	aGame player: 'Manu' playCard: (Speed to: (targetManu)).
	aGame player: 'Fran' playCard: (Cancellation to: (TargetCard pointing: (Speed to: (targetManu)))).
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 4
]

{ #category : #tests }
UCAGameTest >> testTriggerCancellationEffectToAnSpecificSpeedButManuHavingTwoOfThem [
	| aGame |
	aGame := UCAGame
		with: (Die of: 6 rolling: #(4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 1
		shuffling:
			(CardDeck
				with:
					{aSpeed.
					aCancellation.
					aSpeed.
					aSpeed}).
	aGame player: 'Fran' playCard: (Speed to: targetFran).
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 1.
	self assert: (self cardsOf: 'Manu' in: aGame) equals: 2.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	aGame player: 'Manu' playCard: (Speed to: targetManu).
	aGame player: 'Manu' playCard: (Speed to: targetManu).
	aGame
		player: 'Fran'
		playCard: (Cancellation to: (TargetCard pointing: (Speed to: targetManu))).
	self assert: (self positionOf: 'Fran' in: aGame) equals: 5.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 5
]

{ #category : #tests }
UCAGameTest >> testTriggerOverloadEffect [
	| aGame |
	aGame := UCAGame
		with: (Die of: 6 rolling: #(4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 1
		shuffling: (CardDeck with: {anOverload.anOverload.anOverload.anOverload}).
	aGame player: 'Fran' playCard: (Overload to: targetManu).
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 1.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 4.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 2
]

{ #category : #tests }
UCAGameTest >> testTriggerOverloadWithBoardEffects [
	| aGame actualPlayer|
	actualPlayer := 'Fran'.
	aGame := UCAGame
		with: (Die of: 7 rolling: #(3 4 7 1))
		on: (Board withFields: self overloadTestBoard)
		playedBy: {actualPlayer}
		withLaps: 1
		shuffling: (CardDeck with: {anOverload.anOverload.anOverload.anOverload}).
	aGame player: 'Fran' playCard: (Overload to: targetFran).
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 1.
	aGame playTurn.
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 2.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 1.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 9.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0
]

{ #category : #tests }
UCAGameTest >> testTriggerOverloadWithMoonwalk [
	| aGame anArrayOfFields |
	anArrayOfFields := OrderedCollection new.
	3 timesRepeat: [anArrayOfFields add: aNoEffect].
	anArrayOfFields add: (Moonwalk createField:2).
	anArrayOfFields add: aNoEffect.
	
	aGame := UCAGame
		with: (Die of: 6 rolling: #(2 5))
		on: (Board withFields: anArrayOfFields)
		playedBy: players
		withLaps: 2
		shuffling: (CardDeck with: {anOverload.anOverload.anOverload.anOverload}).
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0.
	aGame player: 'Fran' playCard: (Overload to: targetManu).
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 2.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.

]

{ #category : #tests }
UCAGameTest >> testTriggerRedoAcceleration [
	| aGame |
	aGame := UCAGame
		with: (Die of: 6 rolling: #(4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 1
		shuffling:
			(CardDeck
				with:
					{anAcceleration.
					aRedo.
					anAcceleration.
					aRedo}).
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 2.
	aGame player: 'Fran' playCard: anAcceleration.
	aGame player: 'Fran' playCard: aRedo.
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 0.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 6.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0
]

{ #category : #tests }
UCAGameTest >> testTriggerRedoCancellation [
	| aGame |
	aGame := UCAGame
		with: (Die of: 6 rolling: #(4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 1
		shuffling:
			(CardDeck
				with:
					{anAcceleration.
					aSpeed.
					aRedo.
					aCancellation}).
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 2.
	aGame player: 'Fran' playCard: (Speed to: targetFran).
	aGame player: 'Fran' playCard: anAcceleration.
	aGame
		player: 'Manu'
		playCard: (Cancellation to: (TargetCard pointing: (Speed to: targetFran))).
	aGame
		player: 'Manu'
		playCard: (Redo to: (TargetCard pointing: anAcceleration)).
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 0.
	self assert: (self cardsOf: 'Manu' in: aGame) equals: 0.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 4.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0
]

{ #category : #tests }
UCAGameTest >> testTriggerRedoRedo [
	| aGame |
	aGame := UCAGame
		with: (Die of: 6 rolling: #(1))
		on: self noEffectBoardOf12 
		playedBy: players
		withLaps: 1
		shuffling:
			(CardDeck
				with:
					{aSpeed.
					aRedo.
					aRedo.
					aRedo}).
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 2.
	self assert: (self cardsOf: 'Manu' in: aGame) equals: 2.
	aGame player: 'Fran' playCard: (Speed to: targetFran ).
	aGame player: 'Fran' playCard: (Redo to: targetFran ).
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 3.
	aGame player: 'Manu' playCard: (Redo to: targetManu ).
	aGame playTurn.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 2.
]

{ #category : #tests }
UCAGameTest >> testTriggerRedoRepeat [
	| aGame anArrayOfFields |
	anArrayOfFields := OrderedCollection new.
	anArrayOfFields add: aNoEffect.
	anArrayOfFields add: aSpeedUp.
	2 timesRepeat: [ anArrayOfFields add: aNoEffect ].
	anArrayOfFields add: aSpeedUp.
	10 timesRepeat: [ anArrayOfFields add: aNoEffect ].
	aGame := UCAGame
		with: (Die of: 6 rolling: #(4))
		on: (Board withFields: anArrayOfFields)
		playedBy: players
		withLaps: 1
		shuffling:
			(CardDeck
				with:
					{aRepeat.
					aRedo.
					aRepeat.
					aRedo}).
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 2.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 8.
	aGame player: 'Fran' playCard: aRepeat.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 12.
	aGame player: 'Fran' playCard: aRedo.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 1.
	self assert: (self lapsOf: 'Fran' in: aGame) equals: 1.
	self assert: aGame hasFinished
]

{ #category : #tests }
UCAGameTest >> testTriggerRedoSpeed [
	| aGame |
	aGame := UCAGame
		with: (Die of: 6 rolling: #(4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 1
		shuffling:
			(CardDeck
				with:
					{aSpeed.
					aSpeed.
					aCancellation.
					aRedo}).
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 2.
	aGame player: 'Fran' playCard: (Speed to: targetFran).
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 1.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	aGame player: 'Manu' playCard: (Redo to: targetManu).
	self assert: (self cardsOf: 'Manu' in: aGame) equals: 1.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 5.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 5
]

{ #category : #tests }
UCAGameTest >> testTriggerRepeat [
	| aGame anArrayOfFields |
	anArrayOfFields := OrderedCollection new.
	anArrayOfFields add: aNoEffect.
	anArrayOfFields add: aSpeedUp.
	2 timesRepeat: [ anArrayOfFields add: aNoEffect ].
	anArrayOfFields add: aSpeedUp.
	10 timesRepeat: [ anArrayOfFields add: aNoEffect ].
	aGame := UCAGame
		with: die
		on: (Board withFields: anArrayOfFields)
		playedBy: players
		withLaps: 1
		shuffling: (CardDeck with: {aRepeat.aRepeat.aRepeat.aRepeat}).
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 2.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 8.
	aGame player: 'Fran' playCard: Repeat new.
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 1.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 12.
	aGame playTurn.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 5.
	aGame player: 'Fran' playCard: Repeat new.
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 0.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 9
]

{ #category : #tests }
UCAGameTest >> testTriggerRepeatBeforeAnyTurnIsPlayed [
	| aGame  |
	
	aGame := UCAGame
		with: die
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 1
		shuffling: (CardDeckGenerator with: {aRepeat.aRepeat.aRepeat.aRepeat}).
	self should: [aGame player: 'Fran' playCard: Repeat new]
	raise: InvalidAction
	withMessageText: 'Cannot use Repeat before dice have been thrown'.
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 2.
]

{ #category : #tests }
UCAGameTest >> testTriggerSpeedAndAcceleration [
	| aGame |
	aGame := UCAGame
		with: (Die of: 6 rolling: #(4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 1
		shuffling: (CardDeckGenerator with: {aSpeed. anAcceleration} of: #(1 2)).
	aGame player: 'Fran' playCard: (Speed to: (TargetPlayer pointing: 'Fran')).
	aGame player: 'Fran' playCard: (anAcceleration ).
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 0.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 6.
]

{ #category : #tests }
UCAGameTest >> testTriggerSpeedAndOverload [
	| aGame |
	aGame := UCAGame
		with: (Die of: 6 rolling: #(4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 1
		shuffling: (CardDeckGenerator with: {aSpeed. anOverload} of: #(1 2)).
	aGame player: 'Fran' playCard: (Speed to: (TargetPlayer pointing: 'Fran')).
	aGame player: 'Fran' playCard: (Overload to: (TargetPlayer pointing: 'Fran')).
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 0.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 3.
]

{ #category : #tests }
UCAGameTest >> testTriggerSpeedEffect [
	| aGame |
	aGame := UCAGame
		with: (Die of: 6 rolling: #(4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 1
		shuffling: (CardDeckGenerator with: {aSpeed.aSpeed.aSpeed.aSpeed}).
	aGame player: 'Fran' playCard: (Speed to: (TargetPlayer pointing: 'Fran')).
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 1.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 5.
]

{ #category : #tests }
UCAGameTest >> testTriggerSpeedEffectAndOnlyAffectsTheTarget [
	| aGame |
	aGame := UCAGame
		with: (Die of: 6 rolling: #(4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 1
		shuffling: (CardDeckGenerator with: {aSpeed.aSpeed.aSpeed.aSpeed}).
	aGame player: 'Fran' playCard: (Speed to: (TargetPlayer pointing: 'Fran')).
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 1.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 5.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 5.
	self assert: (self positionOf: 'Manu' in: aGame) equals: 4.
]

{ #category : #tests }
UCAGameTest >> testTriggerSpeedEffectTwice [
	| aGame |
	aGame := UCAGame
		with: (Die of: 6 rolling: #(4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 1
		shuffling: (CardDeck with: {aSpeed.aSpeed.aSpeed.aSpeed}).
	aGame player: 'Fran' playCard: (Speed to: (TargetPlayer pointing: 'Fran')).
	aGame player: 'Fran' playCard: (Speed to: (TargetPlayer pointing: 'Fran')).
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 0.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 6.
]

{ #category : #tests }
UCAGameTest >> testTriggerSpeedWithBoardEffects [
	| aGame actualPlayer|
	actualPlayer := 'Fran'.
	aGame := UCAGame
		with: (Die of: 7 rolling: #(1 1 4 1))
		on: (Board withFields: self speedTestBoard)
		playedBy: {actualPlayer}
		withLaps: 1
		shuffling: (CardDeck with: {aSpeed.aSpeed.aSpeed.aSpeed}).
	aGame player: 'Fran' playCard: (Speed to: targetFran).
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 1.
	aGame playTurn.
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 2.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 2.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 9.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
]

{ #category : #tests }
UCAGameTest >> testTriggerWormholeMakesPlayerGoBackALap [
	| aGame actualPlayer anArrayOfFields |
	actualPlayer := 'Manu'.
	anArrayOfFields := OrderedCollection new.
	anArrayOfFields add: aNoEffect.
	anArrayOfFields add: aWormhole.
	4 timesRepeat: [ anArrayOfFields add: aNoEffect ].
	aGame := UCAGame
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
UCAGameTest >> testTriggeringCancellationToCardPutsBothInDiscardDeck [
	| aGame |
	aGame := UCAGame
		with: (Die of: 6 rolling: #(4))
		on: self noEffectBoardOf12
		playedBy: players
		withLaps: 1
		shuffling: (CardDeck with: {aSpeed.aCancellation.aSpeed.aSpeed}).
	aGame player: 'Fran' playCard: (Speed to: targetFran).
	self assert: aGame discardDeck cardCount equals: 0.
	aGame player: 'Fran' playCard: (Cancellation to: (TargetCard pointing: (Speed to: (targetFran)))).
	self assert: aGame discardDeck cardCount equals: 2.
	self assert: (self cardsOf: 'Fran' in: aGame) equals: 0.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 4.
]

{ #category : #tests }
UCAGameTest >> testTriggeringOverloadAtStart [
	| aGame actualPlayer|
	actualPlayer := 'Fran'.
	aGame := UCAGame
		with: (Die of: 6 rolling: #(1))
		on: self noEffectBoardOf12
		playedBy: { actualPlayer  }
		withLaps: 1
		shuffling: (CardDeck with: {anOverload.anOverload}).
	aGame player: 'Fran' playCard: (Overload to: targetFran).
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
]

{ #category : #tests }
UCAGameTest >> testTriggeringOverloadMakesPlayerGoBackALap [
	| aGame actualPlayer|
	actualPlayer := 'Fran'.
	aGame := UCAGame
		with: (Die of: 6 rolling: #(6 6 1))
		on: self noEffectBoardOf12
		playedBy: { actualPlayer }
		withLaps: 2
		shuffling: (CardDeck with: {anOverload.anOverload} ).
	2 timesRepeat: [ aGame playTurn ].
	self assert: (self positionOf: 'Fran' in: aGame) equals: 0.
	self assert: (self lapsOf: 'Fran' in: aGame) equals: 1.
	aGame player: 'Fran' playCard: (Overload to: targetFran).
	aGame playTurn.
	self assert: (self positionOf: 'Fran' in: aGame) equals: 11.
	self assert: (self lapsOf: 'Fran' in: aGame) equals: 0.
]

{ #category : #tests }
UCAGameTest >> testWithMultipleDice [
	| aGame |
	aGame := UCAGame
		with: die + (Die of: 8 rolling: #(7 3))
		on: self noEffectBoardOf12
		playedBy: players.
	self playUntilFinishedWithOutCardsA: aGame. 
	self assert: aGame hasFinished
]

{ #category : #tests }
UCAGameTest >> testWormholeMakesManuNotFinishAGame [
	| aGame actualPlayer anArrayOfFields |
	actualPlayer := 'Manu'.
	anArrayOfFields := OrderedCollection new.
	anArrayOfFields add: aWormhole.
	5 timesRepeat: [ anArrayOfFields add: aNoEffect ].
	aGame := UCAGame
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

{ #category : #checking }
UCAGameTest >> whereIs: aPlayer in: aGame [
	^ aGame atPodium: (aGame podiumOf: aPlayer)
]
