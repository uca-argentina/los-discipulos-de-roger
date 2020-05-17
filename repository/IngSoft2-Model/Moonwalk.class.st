Class {
	#name : #Moonwalk,
	#superclass : #Object,
	#instVars : [
		'fieldsToMove'
	],
	#category : #'IngSoft2-Model-Board'
}

{ #category : #'as yet unclassified' }
Moonwalk class >> createField [
	^self new
				initializeWithN: ((Random new) nextInt: 5).
]

{ #category : #'as yet unclassified' }
Moonwalk >> fieldsToGoBack [
	^ fieldsToMove
]

{ #category : #'as yet unclassified' }
Moonwalk >> initializeWithN: anInteger [
	fieldsToMove := anInteger * (-1).
	
]

{ #category : #'as yet unclassified' }
Moonwalk >> triggerEffectFor: aGame [
	aGame moonWalk: fieldsToMove .
]
