Class {
	#name : #SpeedUp,
	#superclass : #Object,
	#instVars : [
		'length'
	],
	#category : #'IngSoft2-Model-Board'
}

{ #category : #'as yet unclassified' }
SpeedUp >> triggerEffectFor: aGame [
	aGame speedUp.
]
