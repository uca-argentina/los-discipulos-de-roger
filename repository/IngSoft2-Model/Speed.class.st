Class {
	#name : #Speed,
	#superclass : #Card,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'as yet unclassified' }
Speed class >> to: aString [ 
	^self new initializeWithTarget: aString
]

{ #category : #'as yet unclassified' }
Speed >> initializeWithTarget: aString [ 
	target := aString
]

{ #category : #'as yet unclassified' }
Speed >> isIdenticalTo: aSpeed [ 
	^ (aSpeed = self) and:( aSpeed target= target)
]

{ #category : #'as yet unclassified' }
Speed >> target [
	^ target
]

{ #category : #'as yet unclassified' }
Speed >> triggerEffectFor: aGame [ 
	((aGame player: target )= (aGame actualPlayer)) ifTrue: [ aGame moveActualPlayerForward: 1 ]
]

{ #category : #'as yet unclassified' }
Speed >> useEffectFor: aGame [ 
	aGame addPermanent: self
]
