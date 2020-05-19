Class {
	#name : #SpeedUp,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Board'
}

{ #category : #'as yet unclassified' }
SpeedUp class >> createField [
	^self new.
]

{ #category : #playing }
SpeedUp >> triggerEffectFor: aGame [
	aGame updateActualPlayerPosition: 4.
]
