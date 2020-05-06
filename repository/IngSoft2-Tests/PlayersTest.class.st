Class {
	#name : #PlayersTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests-Player-Tests'
}

{ #category : #tests }
PlayersTest >> test01PlayerCreation [ 
	
| aPlayer |
aPlayer:= Player named: 'FranDeGrandis'.
self assert: aPlayer name equals: 'FranDeGrandis'.
self assert: aPlayer position equals: 0.
]

{ #category : #tests }
PlayersTest >> test02PlayerMoving5Positions [

| aPlayer |
aPlayer := Player named:'Fran'.
aPlayer move: 5.
self assert: aPlayer position equals: 5.

]

{ #category : #tests }
PlayersTest >> test03PlayerCreationFailedWithBlankName [ 

self should: [ Player named: ''. ] raise:  InstanceCreationFailed 
withMessageText: 'The player name cannot be blank'.

]
