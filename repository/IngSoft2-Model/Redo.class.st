Class {
	#name : #Redo,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Card'
}

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
