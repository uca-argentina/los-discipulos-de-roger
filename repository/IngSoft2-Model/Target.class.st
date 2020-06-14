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

{ #category : #initialization }
Target >> initializePointingTo: anObjective [ 
	objective := anObjective.
]

{ #category : #checking }
Target >> isValid [
	self subclassResponsibility
]

{ #category : #accessing }
Target >> objective [
	^objective
]
