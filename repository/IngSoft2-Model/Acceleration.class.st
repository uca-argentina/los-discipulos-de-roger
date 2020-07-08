Class {
	#name : #Acceleration,
	#superclass : #PermanentCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #playing }
Acceleration >> triggerEffectFor: aGame [
	aGame moveActualPlayerForward: 1
]
