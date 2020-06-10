Class {
	#name : #Field,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Board'
}

{ #category : #playing }
Field >> triggerEffectFor: aGame [
self subclassResponsibility.
]
