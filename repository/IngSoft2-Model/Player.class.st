Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'nameSurname',
		'position'
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
	^position <= (aPlayer position)
]

{ #category : #initialization }
Player >> initializeWithName: aNameSurname [
	nameSurname := aNameSurname.
	position := 0.
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
