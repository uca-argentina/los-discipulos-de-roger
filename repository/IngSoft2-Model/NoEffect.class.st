Class {
	#name : #NoEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Board'
}

{ #category : #'as yet unclassified' }
NoEffect class >> createField [
	^self new.
]

{ #category : #'as yet unclassified' }
NoEffect >> isNoEffect [
	^true
]

{ #category : #'as yet unclassified' }
NoEffect >> triggerEffectFor: aGame [
]