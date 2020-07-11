Class {
	#name : #Redo,
	#superclass : #InstantCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #playing }
Redo >> useEffectFor: aGame by: aPlayer [
	| aCard |
	aCard := aGame lastCard class.
	aCard := aCard to: target from: (self class).
	aCard useEffectFor: aGame by: aPlayer
]
