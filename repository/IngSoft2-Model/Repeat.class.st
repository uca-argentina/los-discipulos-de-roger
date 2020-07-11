Class {
	#name : #Repeat,
	#superclass : #InstantCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #playing }
Repeat >> useEffectFor: aGame by: aPlayer [
	aGame repeatLastEffect.
	aGame addToDeck: self.
	aGame addToDiscardDeck: self.
]
