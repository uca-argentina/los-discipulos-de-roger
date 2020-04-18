Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'nameSurname',
		'position'
	],
	#category : #'IS2-Players'
}

{ #category : #instanceCreation }
Player class >> withNameSurname: aNameSurname [
		aNameSurname isEmpty 
		ifTrue: [ InstanceCreationFailed
				signal: 'The player name cannot be blank' ].
		
		^self new 
		initializeWithNameSurname: aNameSurname
]

{ #category : #'as yet unclassified' }
Player >> <= aPlayer [ 
	^position <= (aPlayer position)
]

{ #category : #'as yet unclassified' }
Player >> getNameSurname [
	^nameSurname
]

{ #category : #initialization }
Player >> initializeWithNameSurname: aNameSurname [
	nameSurname := aNameSurname.
	position := 0.
]

{ #category : #'as yet unclassified' }
Player >> position [
	^position
]

{ #category : #playing }
Player >> rollingFor:aGame [ 
	^position := position + aGame roll.
]
