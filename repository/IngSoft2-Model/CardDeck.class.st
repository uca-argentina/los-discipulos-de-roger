Class {
	#name : #CardDeck,
	#superclass : #Object,
	#instVars : [
		'cards',
		'source'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'as yet unclassified' }
CardDeck class >> with: aCollection [
	^ 	self new
		initializeWithCardTypes: aCollection
		of: Random new.
]

{ #category : #'as yet unclassified' }
CardDeck class >> with: aCollection of: aSequence [
	^ self new
		initializeWithCardTypes: aCollection
		of: (SequentialNaturalNumberProvider providing: aSequence).
]

{ #category : #'as yet unclassified' }
CardDeck class >> withAllCards [
	| cards |
	cards:= { Overload new. Speed new. Acceleration new. Cancellation new. Redo new. Repeat new. }.
	^self with: cards.
]

{ #category : #'as yet unclassified' }
CardDeck >> draw [
	| aCard |
	aCard := (cards at: (source nextInt: cards size)).
	^ aCard copy
]

{ #category : #'as yet unclassified' }
CardDeck >> initializeWithCardTypes: aCollection of: aSource [
	cards := aCollection.
	source := aSource.
]
