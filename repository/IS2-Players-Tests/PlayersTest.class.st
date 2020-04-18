Class {
	#name : #PlayersTest,
	#superclass : #TestCase,
	#category : #'IS2-Players-Tests'
}

{ #category : #tests }
PlayersTest >> test01PlayerCreation [ 
	
| aPlayer |
aPlayer:= Player withNameSurname: 'FranDeGrandis'.
self assert: aPlayer getNameSurname equals: 'FranDeGrandis'.
self assert: aPlayer position equals: 0.
]

{ #category : #tests }
PlayersTest >> test02PlayerRollsDice [
	
| aPlayer aGame d4|
d4:= Die of: 4 rolling: { 4 }.
aGame := Game with: d4  andPlayers:  #(aPlayer).
aPlayer:= Player withNameSurname: 'FranDeGrandis'.
aPlayer rollFor: aGame.

{ #category : #tests }
PlayersTest >> test03PlayerCreationFailedWithBlankName [ 

self should: [ Player withNameSurname: ''. ] raise:  InstanceCreationFailed 
withMessageText: 'The player name cannot be blank'.
]

{ #category : #tests }
PlayersTest >> test04APlayerJoinsAValidGame [

| aGame aPlayer |
aGame := Game with: Die d4 as: NotStarted new.
aPlayer := Player withNameSurname: 'FranDeGrandis'.
aPlayer join: aGame.
self assert: (aGame isPlayedBy:aPlayer ) equals: true.


]
