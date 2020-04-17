Class {
	#name : #Started,
	#superclass : #Object,
	#category : #'IS2-Game'
}

{ #category : #'as yet unclassified' }
Started >> add: aPlayer in: aGame [ 
	InvalidAction signal: 'A player cannot join a started game'
]

{ #category : #'as yet unclassified' }
Started >> begin: aGame [
	InvalidAction signal: 'Cannot start a game that is already started'.
	
]
