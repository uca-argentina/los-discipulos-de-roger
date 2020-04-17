Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'dice',
		'state',
		'playerSequence',
		'length'
	],
	#category : #'IS2-Game'
}

{ #category : #instanceCreation }
Game class >> createNew [
	^self with: Die d6 as: NotStarted new withFields: 12
]

{ #category : #instanceCreation }
Game class >> newNotValidGame [
	^ self with: Die new as: NotValid new withFields: 12
]

{ #category : #instanceCreation }
Game class >> with: dice as: anState [
^self with: dice as: anState  withFields: 12
]

{ #category : #instanceCreation }
Game class >> with: dice as: anState withFields: aNumber [
	^ self new
		initializeDice: dice
		as: anState
		withFields: aNumber
]

{ #category : #'as yet unclassified' }
Game >> add: aPlayer [.
state add: aPlayer in: self.
]

{ #category : #'as yet unclassified' }
Game >> addPlayer: aPlayer [ 
	playerSequence add:aPlayer.
]

{ #category : #StateChanging }
Game >> begin [
	state := state begin: self
]

{ #category : #'as yet unclassified' }
Game >> changePlayerSequence [
playerSequence := CircularIterator cyclingOver: playerSequence.
]

{ #category : #'as yet unclassified' }
Game >> getDice [
	^dice
]

{ #category : #initialization }
Game >> initializeDice: aDice as: anState withFields: aNumber [
	dice := aDice.
	state := anState.
	playerSequence := LinkedList new.
	length := aNumber
]

{ #category : #'as yet unclassified' }
Game >> isPlayedBy: aPlayer [ 
	^ playerSequence includes: aPlayer.
]

{ #category : #'as yet unclassified' }
Game >> length [
	^length
]

{ #category : #'as yet unclassified' }
Game >> state [
	^state
]
