Class {
	#name : #Redo,
	#superclass : #Card,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'as yet unclassified' }
Redo class >> to: aString [ 
	^self new initializeWithTarget: aString.
]

{ #category : #'as yet unclassified' }
Redo >> initializeWithTarget: aString [ 
	target := aString
]

{ #category : #'as yet unclassified' }
Redo >> triggerEffectFor: aGame [
	
]

{ #category : #'as yet unclassified' }
Redo >> useEffectFor: aGame [ 
	| aCard |
	aCard := aGame lastCard class.
	aCard := aCard to: target.
	aCard useEffectFor: aGame.
]
