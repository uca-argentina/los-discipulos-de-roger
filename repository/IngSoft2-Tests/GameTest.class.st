Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests-Game-Tests'
}

{ #category : #tests }
GameTest >> newFran [
	^ScoreboardRaw ofPlayerNamed:  'Fran'
]

{ #category : #tests }
GameTest >> newManu [
	^ ScoreboardRaw ofPlayerNamed:  'Manu'
]

{ #category : #tests }
GameTest >> test03WithMultipleDice [
	| aGame aPlayer otherPlayer |
	aPlayer := self newFran.
	otherPlayer := self newManu.
	aGame := Game
		with: (Die of: 6 rolling: #(4 1)) + (Die of: 8 rolling: #(7 3))
		andPlayers:
			{aPlayer.
			otherPlayer}
		andBoard: (Board withFields: 12 of: NoEffect).
	aGame playUntilFinished.
	self assert: aGame hasFinished
]

{ #category : #tests }
GameTest >> test04DefaultGameLengthIsTwelve [

| aGame|
aGame := Game withPlayers:#('Fran').
self assert: aGame length equals: 12.
]

{ #category : #tests }
GameTest >> test05PlayGame [
	| aGame aPlayer |
	aPlayer := self newFran.
	aGame := Game with: (Die of: 6 rolling: #(4)) andPlayers: {aPlayer}.
	3 timesRepeat: [ aGame playATurn ].
	self assert: aGame hasFinished
]

{ #category : #tests }
GameTest >> test06PlayAGameAndFranWins [

| aGame aPlayer otherPlayer |
aPlayer := self newFran.
otherPlayer := self newManu .
aGame := Game with: (Die of: 6 rolling: #(4 1))  andPlayers: { aPlayer. otherPlayer} .
aGame playUntilFinished.
self assert: (aGame winner name) equals: 'Fran'.

]

{ #category : #tests }
GameTest >> test07PlayAGameAndFranFirstAndManuSecond [
	| aGame aPlayer otherPlayer |
	aPlayer := self newFran.
	otherPlayer := self newManu.
	aGame := Game
		with: (Die of: 6 rolling: #(4 1))
		andPlayers:
			{aPlayer.
			otherPlayer}.
	aGame playUntilFinished.
	self assert: (aGame att: 1) name equals: 'Fran'.
	self assert: (aGame att: 2) name equals: 'Manu'
]

{ #category : #tests }
GameTest >> test08CannotAskForWinnerOfAnUnfinishedGame [
	| aGame aPlayer otherPlayer |
	aPlayer := self newFran.
	otherPlayer := self newManu.
	aGame := Game
		with: (Die of: 6 rolling: #(4 1))
		andPlayers:
			{aPlayer.
			otherPlayer}.
	aGame playATurn.
	self
		should: [ aGame winner ]
		raise: InvalidAction
		withMessageText: 'The game has not finished yet.'
]

{ #category : #tests }
GameTest >> test09NewGameWith9Laps [
	| aGame aPlayer otherPlayer |
	aPlayer := self newFran.
	otherPlayer := self newManu.
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
	aPlayer := self newManu.
	otherPlayer := self newFran.
	aGame := Game
		with: (Die of: 6 rolling: #(1 4))
		andFields: 5
		andPlayers:
			{aPlayer.
			otherPlayer}
		andLaps: 2.
	aGame playUntilFinished.
	self assert: (aGame att: 1) laps equals: 2
]

{ #category : #tests }
GameTest >> test11TriggerAWormHole [
	
]
