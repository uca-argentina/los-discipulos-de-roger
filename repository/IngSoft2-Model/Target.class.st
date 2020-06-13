Class {
	#name : #Target,
	#superclass : #Object,
	#instVars : [
		'objective'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'as yet unclassified' }
Target class >> pointing: anAcceleration [
	^ self new initializePointingTo: anAcceleration
]

{ #category : #comparing }
Target >> = aTarget [
	^ (aTarget isMemberOf: aTarget class)
		ifTrue: [ objective = aTarget objective ]
		ifFalse: [ false ]
]

{ #category : #'as yet unclassified' }
Target >> initializePointingTo: anObjective [ 
	objective := anObjective.
]

{ #category : #'as yet unclassified' }
Target >> isValid [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
Target >> objective [
	^objective
]
