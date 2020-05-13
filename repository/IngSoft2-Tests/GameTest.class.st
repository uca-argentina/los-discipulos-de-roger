Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests-Game-Tests'
}

{ #category : #tests }
GameTest >> noEffectBoard [
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
		andBoard: (Board withFields: BoardGenerator default picking: 10).
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
	aGame := Game with: (Die of: 6 rolling: #(4)) andPlayers: {aPlayer} andBoard: self noEffectBoard .
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
		andBoard: self noEffectBoard.
	aGame playUntilFinished.
	self assert: aGame winner name equals: 'Fran'
]

{ #category : #tests }
GameTest >> test07PlayAGameAndFranFirstAndManuSecond [
	| aGame aPlayer otherPlayer |
	aPlayer := self playerNamed: 'Fran'.
	otherPlayer := self playerNamed: 'Manu'.
	aGame := Game
		with: (Die of: 6 rolling: #(4 1))
		andPlayers:
			{aPlayer.
			otherPlayer}
		andBoard: self noEffectBoard.
	aGame playUntilFinished.
	self assert: (aGame att: 1) name equals: 'Fran'.
	self assert: (aGame att: 2) name equals: 'Manu'
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
		andBoard: self noEffectBoard.
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
		andBoard: self noEffectBoard
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
	aGame playATurn.
	self assert: actualPlayer position equals: 3
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
	self assert: actualPlayer position equals: 11
]
