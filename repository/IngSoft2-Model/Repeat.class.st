Class {
	#name : #Repeat,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #comparing }
Repeat >> isPermanent [
	^false.
]

{ #category : #playing }
Repeat >> triggerEffectFor: aGame [
]

{ #category : #playing }
Repeat >> useEffectFor: aGame by: aPlayer [
	aGame repeatLastEffect.
	aGame addToDeck: self
]
