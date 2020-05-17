Class {
	#name : #AtomicBomb,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Board'
}

{ #category : #'as yet unclassified' }
AtomicBomb class >> createField [
	^self new.
]

{ #category : #'as yet unclassified' }
AtomicBomb >> triggerEffectFor: aGame [
	aGame resetAllPlayersPosition.
]
