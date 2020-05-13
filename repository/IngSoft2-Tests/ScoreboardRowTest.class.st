Class {
	#name : #ScoreboardRowTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests-Player-Tests'
}

{ #category : #tests }
ScoreboardRowTest >> test01ScoreRowCreation [ 
	
| aPlayer |
aPlayer:= ScoreboardRaw ofPlayerNamed:  'FranDeGrandis'.
self assert: aPlayer name equals: 'FranDeGrandis'.
self assert: aPlayer position equals: 1.
]

{ #category : #tests }
ScoreboardRowTest >> test02ARowUpdateThePlayerPositionBy5 [

| aPlayer |
aPlayer := ScoreboardRaw ofPlayerNamed: 'Fran'.
aPlayer updateAPlayerPosition: 5.
self assert: aPlayer position equals: 6.

]

{ #category : #tests }
ScoreboardRowTest >> test03RowCreationFailedWithBlankName [ 

self should: [ ScoreboardRaw ofPlayerNamed: ''. ] raise:  InstanceCreationFailed 
withMessageText: 'The player name cannot be blank'.

]
