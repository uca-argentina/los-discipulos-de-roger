Class {
	#name : #CardDeck,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'as yet unclassified' }
CardDeck class >> with: aCollection [
	^self new
	initializeWithCardTypes: aCollection
]

{ #category : #'as yet unclassified' }
CardDeck class >> withAllCards [
	^self new
	initializeWithCardTypes: { Overload new. Speed new. Acceleration new. Cancellation new. Redo new. Repeat new. }.
]

{ #category : #'as yet unclassified' }
CardDeck >> draw [
	^(cards at: ((Random new) nextInt: (cards size))) copy.
]

{ #category : #'as yet unclassified' }
CardDeck >> initializeWithCardTypes: aCollection [ 
	cards := aCollection.
]
