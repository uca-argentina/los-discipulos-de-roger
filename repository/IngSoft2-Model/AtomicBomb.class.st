Class {
	#name : #AtomicBomb,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Board'
}

{ #category : #playing }
AtomicBomb >> triggerEffectFor: aGame [
	aGame resetAllPlayersPosition.
]
