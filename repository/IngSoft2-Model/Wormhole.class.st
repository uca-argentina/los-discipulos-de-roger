Class {
	#name : #Wormhole,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Board'
}

{ #category : #'as yet unclassified' }
Wormhole class >> createField [
	^self new.
]

{ #category : #'as yet unclassified' }
Wormhole >> triggerEffectFor: aGame [
	aGame updateActualPlayerPosition: -4.
]
