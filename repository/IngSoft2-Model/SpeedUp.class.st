Class {
	#name : #SpeedUp,
	#superclass : #Field,
	#category : #'IngSoft2-Model-Board'
}

{ #category : #playing }
SpeedUp >> triggerEffectFor: aGame [
	aGame moveActualPlayerForward: 4.
]
