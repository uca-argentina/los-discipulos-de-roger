Class {
	#name : #Redo,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #comparing }
Redo >> isPermanent [
	^false.
]

{ #category : #playing }
Redo >> triggerEffectFor: aGame [
	
]

{ #category : #playing }
Redo >> useEffectFor: aGame by: aPlayer [
	| aCard |
	aCard := aGame lastCard class.
	aCard := aCard to: target.
	aCard useEffectFor: aGame by: aPlayer
]
