Class {
	#name : #Repeat,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'as yet unclassified' }
Repeat >> triggerEffectFor: aGame [
]

{ #category : #'as yet unclassified' }
Repeat >> useEffectFor: aGame [
	aGame repeatLastEffect.
	aGame addPermanent: self.
]
