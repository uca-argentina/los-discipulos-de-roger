Class {
	#name : #CardDeck,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'as yet unclassified' }
CardDeck class >> defaultWith: anInteger [ 
	|aCardDeckGenerator|
	aCardDeckGenerator := CardDeckGenerator withAllCards.
	^aCardDeckGenerator buildOf: anInteger.
]

{ #category : #'instance creation' }
CardDeck class >> from: aCardDeckGenerator containing: aNumber [
^aCardDeckGenerator buildOf: aNumber.
]

{ #category : #'instance creation' }
CardDeck class >> with: aCollection [
	^ self new initializeWithCards: aCollection
]

{ #category : #'as yet unclassified' }
CardDeck >> add: aCard [
	cards add: aCard.
]

{ #category : #'as yet unclassified' }
CardDeck >> cardCount [
	^cards size.
]

{ #category : #'as yet unclassified' }
CardDeck >> cards [
^cards. 
]

{ #category : #'as yet unclassified' }
CardDeck >> draw [
	(cards isEmpty) ifTrue: [ InvalidAction  signal: 'Cannot draw from empty deck'].
	 ^cards removeFirst.
]

{ #category : #initialization }
CardDeck >> initializeWithCards: aCollection [
	cards := (aCollection asOrderedCollection )
]

{ #category : #'as yet unclassified' }
CardDeck >> shuffle [
	|newCards source|
	(cards isEmpty) ifTrue: [ InvalidAction signal: 'Cannot shuffle an empty deck' ].
	newCards := OrderedCollection new.
	source:= Random new.
	(cards size) timesRepeat: [ newCards add: (cards removeAt: (source nextInt: (cards size))) ].
	cards := newCards.
]
