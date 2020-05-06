Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'nameSurname',
		'position',
		'laps'
	],
	#category : #'IngSoft2-Model-Players'
}

{ #category : #instanceCreation }
Player class >> named: aNameSurname [
		aNameSurname isEmpty 
		ifTrue: [ InstanceCreationFailed
				signal: 'The player name cannot be blank' ].
		
		^self new 
		initializeWithName: aNameSurname
]

{ #category : #comparing }
Player >> <= aPlayer [ 
	^position >= (aPlayer position)
]

{ #category : #'as yet unclassified' }
Player >> addLap: anInteger [ 
	laps := laps+1.
	position:= 0.
	self move: anInteger.
]

{ #category : #initialization }
Player >> initializeWithName: aNameSurname [
	nameSurname := aNameSurname.
	position := 0.
	laps := 0.
]

{ #category : #'as yet unclassified' }
Player >> laps [
	^ laps
]

{ #category : #playing }
Player >> move: aMovement [
	^position := position + aMovement.
]

{ #category : #accessing }
Player >> name [
	^nameSurname
]

{ #category : #accessing }
Player >> position [
	^position
]
