Class {
	#name : #PlayersTest,
	#superclass : #TestCase,
	#category : #'IS2-Players-Tests'
}

{ #category : #tests }
PlayersTest >> test01PlayerCreation [ 
	
| aPlayer aGame |
aGame := Game new.
aPlayer:= Player withNameSurname: 'FranDeGrandis' playing: aGame.
self assert: aPlayer getNameSurname equals: 'FranDeGrandis'.
self assert: aPlayer position equals: 0.
self assert: aPlayer playing equals: aGame.
]

{ #category : #tests }
PlayersTest >> test02PlayerRollsDice [
	
| aPlayer aGame d4 |
d4 := Die of: 4 rolling: { 3 }.
aGame := Game with: d4 of:1.
aPlayer:= Player withNameSurname: 'FranDeGrandis' playing: aGame.
aPlayer roll
]
