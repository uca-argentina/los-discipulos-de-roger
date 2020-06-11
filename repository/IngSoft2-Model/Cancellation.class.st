Class {
	#name : #Cancellation,
	#superclass : #Card,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'as yet unclassified' }
Cancellation class >> to: aClass [
	^ self new initializeWithTarget: aClass
]

{ #category : #'as yet unclassified' }
Cancellation >> initializeWithTarget: aClass [ 
	target := aClass
]

{ #category : #'as yet unclassified' }
Cancellation >> triggerEffectFor: aGame [ 

]

{ #category : #'as yet unclassified' }
Cancellation >> useEffectFor: aGame [ 
	aGame removePermanentCard: target.
	aGame addPermanent: self.
]
