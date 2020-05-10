Class {
	#name : #Moonwalk,
	#superclass : #Object,
	#instVars : [
		'length'
	],
	#category : #'IngSoft2-Model-Board'
}

{ #category : #'as yet unclassified' }
Moonwalk >> triggerEffectFor: aGame [
	aGame moonWalk.
]
