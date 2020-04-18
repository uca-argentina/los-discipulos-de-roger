Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests-Game-Tests'
}

{ #category : #tests }
GameTest >> test02CreatingAGameWithAndWithoutDice [
	
	| aGame |
	aGame := Game default: #('Fran').
	self assert: (aGame getDice isMemberOf: Die) equals: true.
]

{ #category : #tests }
GameTest >> test03WithMultipleDice [

| aGame aPlayer otherPlayer |
aPlayer := Player withNameSurname: 'Fran'.
otherPlayer := Player withNameSurname: 'Manu'.
aGame := Game with: ((Die of: 6 rolling: #(4 1)) + (Die of: 8 rolling: #(7 3)) )  andPlayers: { aPlayer. otherPlayer} .
aGame carryOut.
self assert: (aGame state isMemberOf: Finished) equals: true.

]

{ #category : #tests }
GameTest >> test04AboutDefaultGameLength [

| aGame|
aGame := Game default:#('Fran').
self assert: aGame length equals: 12.
]

{ #category : #tests }
GameTest >> test05PlayGame [

| aGame aPlayer |
aPlayer := Player withNameSurname: 'Fran'.
aGame := Game with: (Die of: 6 rolling: #(4))  andPlayers: { aPlayer } .
1 to: 4 do: [ :iteration | aGame playNext]. "Hacemos una iteración en este test, en vez de llamar a carryOut, para verificar que luego de 4 tiradas de 4 el juego clasifique como terminado"
self assert: (aGame state isMemberOf: Finished) equals: true.

]

{ #category : #tests }
GameTest >> test06PlayAGameAndFranWins [

| aGame aPlayer otherPlayer |
aPlayer := Player withNameSurname: 'Fran'.
otherPlayer := Player withNameSurname: 'Manu'.
aGame := Game with: (Die of: 6 rolling: #(4 1))  andPlayers: { aPlayer. otherPlayer} .
aGame carryOut.
self assert: (aGame winner getNameSurname) equals: 'Fran'.

]

{ #category : #tests }
GameTest >> test07PlayAGameAndFranFirstAndManuSecond [

| aGame aPlayer otherPlayer |
aPlayer := Player withNameSurname: 'Fran'.
otherPlayer := Player withNameSurname: 'Manu'.
aGame := Game with: (Die of: 6 rolling: #(4 1))  andPlayers: { aPlayer. otherPlayer} .
aGame carryOut.
self assert: ((aGame att:1) getNameSurname) equals: 'Fran'.
self assert: ((aGame att:2)getNameSurname) equals: 'Manu'

]

{ #category : #tests }
GameTest >> test08CannotAskForWinnerOfAnUnfinishedGame [

| aGame aPlayer otherPlayer |
aPlayer := Player withNameSurname: 'Fran'.
otherPlayer := Player withNameSurname: 'Manu'.
aGame := Game with: (Die of: 6 rolling: #(4 1))  andPlayers: { aPlayer. otherPlayer} .
aGame playNext.
self should: [ aGame winner]
		raise:InvalidAction 
		withMessageText: 'The game has not finished yet.'.

]
