Class {
	#name : #SpeedUp,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Board'
}

{ #category : #playing }
SpeedUp >> triggerEffectFor: aGame [
	aGame moveActualPlayerForward: 4.
]
