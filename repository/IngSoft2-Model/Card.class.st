Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'playState'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'as yet unclassified' }
Card class >> playingAs: aCardPlayState [
	^self new
	initializeWithPlayState: aCardPlayState
]

{ #category : #initialization }
Card >> initializeWithPlayState: aCardPlayState [
	playState := aCardPlayState.
]
