Class {
	#name : #Acceleration,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'as yet unclassified' }
Acceleration >> isPermanent [
	^true.
]

{ #category : #playing }
Acceleration >> triggerEffectFor: aGame [
	aGame moveActualPlayerForward: 1
]

{ #category : #playing }
Acceleration >> useEffectFor: aGame by: aPlayer [
	aGame addPermanent: self by: aPlayer
]
