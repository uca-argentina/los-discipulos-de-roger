Class {
	#name : #Wormhole,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Board'
}

{ #category : #playing }
Wormhole >> triggerEffectFor: aGame [
	aGame moveActualPlayerBackwards: 4.
]
