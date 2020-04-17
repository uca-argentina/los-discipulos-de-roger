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
	
| aPlayer d4 |
d4 := Die of: 4 rolling: { 4 }.
aPlayer:= Player withNameSurname: 'FranDeGrandis'.
aPlayer roll: d4.
self assert: aPlayer position equals: 4
]

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

{ #category : #tests }
PlayersTest >> test05APlayerCannotJoinAnInvalidGame [

| aGame aPlayer |
aGame := Game with: Die d4 as: NotValid new.
aPlayer := Player withNameSurname: 'FranDeGrandis'.
self should: [ aPlayer join: aGame. ] raise: InvalidAction  withMessageText: 'A player cannot join an invalid game'.
aGame := Game with: Die d4 as: Started new.
self should: [ aPlayer join: aGame. ] raise: InvalidAction  withMessageText: 'A player cannot join a started game'.

]
