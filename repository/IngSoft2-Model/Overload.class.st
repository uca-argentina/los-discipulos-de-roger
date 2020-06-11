Class {
	#name : #Overload,
	#superclass : #Card,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'as yet unclassified' }
Overload class >> to: aPlayerName [
	^self new initializeWithTarget: aPlayerName
]

{ #category : #'as yet unclassified' }
Overload >> initializeWithTarget: aString [ 
	target := aString.
]

{ #category : #'as yet unclassified' }
Overload >> triggerEffectFor: aGame [ 
	
	| aPlayer |
	aPlayer := aGame player: target.
	aPlayer = aGame actualPlayer ifTrue: [ aGame moveActualPlayerBackwards: 2 ].
]

{ #category : #'as yet unclassified' }
Overload >> useEffectFor: aGame [ 
	aGame addPermanent: self
]
