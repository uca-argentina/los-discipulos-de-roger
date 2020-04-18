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
Player class >> withNameSurname: aNameSurname [
		aNameSurname isEmpty 
		ifTrue: [ InstanceCreationFailed
				signal: 'The player name cannot be blank' ].
		
		^self new 
		initializeWithNameSurname: aNameSurname
]

{ #category : #comparing }
Player >> <= aPlayer [ 
	^position <= (aPlayer position)
]

{ #category : #accessing }
Player >> getNameSurname [
	^nameSurname
]

{ #category : #initialization }
Player >> initializeWithNameSurname: aNameSurname [
	nameSurname := aNameSurname.
	position := 0.
]

{ #category : #accessing }
Player >> position [
	^position
]

{ #category : #playing }
Player >> rollingFor:aGame [ 
	^position := position + aGame roll.
]
