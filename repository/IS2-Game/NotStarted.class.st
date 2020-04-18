Class {
	#name : #NotStarted,
	#superclass : #Object,
	#category : #'IS2-Game'
}

{ #category : #adding }
NotStarted >> add: aPlayer in: aGame [
aGame addPlayer: aPlayer.
]

{ #category : #adding }
NotStarted >> begin: aGame [
aGame changePlayerSequence.
^Started new
]
