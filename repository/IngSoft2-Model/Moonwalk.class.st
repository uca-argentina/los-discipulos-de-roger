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
	^self createField:((Random new) nextInt: 5).
]

{ #category : #'as yet unclassified' }
Moonwalk class >> createField: anInteger [
	^self new
				initializeWithN: anInteger.
]

{ #category : #initialization }
Moonwalk >> initializeWithN: anInteger [
	fieldsToMove := anInteger * (-1).
	
]

{ #category : #playing }
Moonwalk >> triggerEffectFor: aGame [
	aGame moonWalk: fieldsToMove .
]
