Class {
	#name : #CardDeckGenerator,
	#superclass : #Object,
	#instVars : [
		'cards',
		'source',
		'count'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'as yet unclassified' }
CardDeckGenerator class >> with: aCollection [
	^ 	self new
		initializeWithCardTypes: aCollection
		of: Random new.
]

{ #category : #'as yet unclassified' }
CardDeckGenerator class >> with: aCollection of: aSequence [
	^ self new
		initializeWithCardTypes: aCollection
		of: (SequentialNaturalNumberProvider providing: aSequence).
]

{ #category : #'as yet unclassified' }
CardDeckGenerator class >> withAllCards [
	| cards |
	cards:= { Overload new. Speed new. Acceleration new. Cancellation new. Redo new. Repeat new. }.
	^self with: cards.
]

{ #category : #building }
CardDeckGenerator >> buildOf: aNumber [
	| cardDeck |
	cardDeck := OrderedCollection new.
	aNumber timesRepeat: [ cardDeck add: (self draw) ].
	^CardDeck with: cardDeck.
]

{ #category : #accessing }
CardDeckGenerator >> draw [
	| aCard |
	aCard := cards at: (source nextInt: cards size).
	^ aCard copy
]

{ #category : #initialization }
CardDeckGenerator >> initializeWithCardTypes: aCollection of: aSource [
	cards := aCollection.
	source := aSource
]
