Class {
	#name : #AtomicBomb,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Board'
}

{ #category : #'as yet unclassified' }
AtomicBomb class >> createField [
	^self new.
]

{ #category : #playing }
AtomicBomb >> triggerEffectFor: aGame [
	aGame resetAllPlayersPosition.
]
