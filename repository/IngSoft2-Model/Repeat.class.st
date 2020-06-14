Class {
	#name : #Repeat,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #playing }
Repeat >> triggerEffectFor: aGame [
]

{ #category : #playing }
Repeat >> useEffectFor: aGame by: aPlayer [
	aGame repeatLastEffect.
	aGame addToDeck: self.
]
