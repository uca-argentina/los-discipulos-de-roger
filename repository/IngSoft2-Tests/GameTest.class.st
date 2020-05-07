Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests-Game-Tests'
}

{ #category : #tests }
GameTest >> anotherPlayer [
	^ Player named: 'Fran'
]

{ #category : #tests }
GameTest >> newPlayer [
	^ Player named: 'Manu'
]

{ #category : #tests }
GameTest >> test03WithMultipleDice [

| aGame aPlayer otherPlayer |
aPlayer := Player named: 'Fran'.
otherPlayer := Player named: 'Manu'.
aGame := Game with: ((Die of: 6 rolling: #(4 1)) + (Die of: 8 rolling: #(7 3)) )  andPlayers: { aPlayer. otherPlayer} .
aGame playUntilFinished.
self assert: aGame hasFinished .

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
aPlayer := Player named: 'Fran'.
aGame := Game with: (Die of: 6 rolling: #(4))  andPlayers: { aPlayer } .
3 timesRepeat:  [aGame playATurn]. "Hacemos una iteración en este test, en vez de llamar a carryOut, para verificar que luego de 4 tiradas de 4 el juego clasifique como terminado"
self assert: (aGame hasFinished).

]

{ #category : #tests }
GameTest >> test06PlayAGameAndFranWins [

| aGame aPlayer otherPlayer |
aPlayer := self anotherPlayer.
otherPlayer := self newPlayer .
aGame := Game with: (Die of: 6 rolling: #(4 1))  andPlayers: { aPlayer. otherPlayer} .
aGame playUntilFinished.
self assert: (aGame winner name) equals: 'Fran'.

]

{ #category : #tests }
GameTest >> test07PlayAGameAndFranFirstAndManuSecond [

| aGame aPlayer otherPlayer |
aPlayer := Player named: 'Fran'.
otherPlayer := Player named: 'Manu'.
aGame := Game with: (Die of: 6 rolling: #(4 1))  andPlayers: { aPlayer. otherPlayer} .
aGame playUntilFinished.
self assert: ((aGame att:1) name) equals: 'Fran'.
self assert: ((aGame att:2)name) equals: 'Manu'

]

{ #category : #tests }
GameTest >> test08CannotAskForWinnerOfAnUnfinishedGame [
	| aGame aPlayer otherPlayer |
	aPlayer := self anotherPlayer.
	otherPlayer := self newPlayer.
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
	aPlayer := self anotherPlayer.
	otherPlayer := self newPlayer.
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
aPlayer := Player named: 'Manu'.
otherPlayer := Player named: 'Fran'.
aGame := Game with: (Die of: 6 rolling: #(1 4)) andFields: 5  andPlayers: { aPlayer. otherPlayer} andLaps: 2.
aGame playUntilFinished.
self assert: ((aGame att:1) laps) equals: 2.
]
