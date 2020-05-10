Class {
	#name : #AtomicBomb,
	#superclass : #Object,
	#instVars : [
		'length'
	],
	#category : #'IngSoft2-Model-Board'
}

{ #category : #'as yet unclassified' }
AtomicBomb >> triggerEffectFor: aGame [
	aGame atomicBomb.
]
