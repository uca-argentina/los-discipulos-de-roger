Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests-Player-Tests'
}

{ #category : #tests }
PlayerTest >> test02ARowUpdateThePlayerPositionBy5 [
	| aPlayer |
	aPlayer := Player ofPlayerNamed: 'Fran'.
	self assert: aPlayer position equals: 0.
	aPlayer move: 5.
	self assert: aPlayer position equals: 5
]

{ #category : #tests }
PlayerTest >> test03RowCreationFailedWithBlankName [
	self
		should: [ Player ofPlayerNamed: '' ]
		raise: InstanceCreationFailed
		withMessageText: 'The player name cannot be blank'
]

{ #category : #tests }
PlayerTest >> testScoreRowCreation [
	| aPlayer |
	aPlayer := Player ofPlayerNamed: 'FranDeGrandis'.
	self assert: aPlayer name equals: 'FranDeGrandis'.
	self assert: aPlayer position equals: 0.
	self assert: aPlayer cardCount equals: 0.
]
