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

{ #category : #accessing }
Moonwalk >> fieldsToGoBack [
	^ fieldsToMove
]

{ #category : #initialization }
Moonwalk >> initializeWithN: anInteger [
	fieldsToMove := anInteger * (-1).
	
]

{ #category : #playing }
Moonwalk >> triggerEffectFor: aGame [
	aGame moonWalk: fieldsToMove .
]
