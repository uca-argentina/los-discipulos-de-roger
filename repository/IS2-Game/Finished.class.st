Class {
	#name : #Finished,
	#superclass : #Object,
	#category : #'IS2-Game'
}

{ #category : #adding }
Finished >> add: aPlayer in: aGame [ 
	InvalidAction signal: 'A player cannot join a finished game'
]

{ #category : #adding }
Finished >> begin: aGame [
	InvalidAction signal:'Cannot start a finished game'.
]
