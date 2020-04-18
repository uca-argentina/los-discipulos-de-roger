Class {
	#name : #NotValid,
	#superclass : #Object,
	#category : #'IS2-Game'
}

{ #category : #'as yet unclassified' }
NotValid >> add: aPlayer in: aGame [ 
	InvalidAction signal: 'A player cannot join an invalid game'
]

{ #category : #'as yet unclassified' }
NotValid >> begin: aGame [
	InvalidAction signal:'Cannot start without a game'.
]
