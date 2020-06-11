Class {
	#name : #Acceleration,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'as yet unclassified' }
Acceleration class >> to: anUndefinedObject [ 
	^self new
]

{ #category : #'as yet unclassified' }
Acceleration >> triggerEffectFor: aGame [ 
	aGame moveActualPlayerForward: 1.
]

{ #category : #'as yet unclassified' }
Acceleration >> useEffectFor: aGame [ 
	aGame addPermanent: self.
]
