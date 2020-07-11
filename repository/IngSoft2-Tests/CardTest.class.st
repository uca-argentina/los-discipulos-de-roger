Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests-Card-Tests'
}

{ #category : #tests }
CardTest >> assertAverageIsBetween15and17Of: overloadCount [
	self
		assert: ((self averagePercentOf: overloadCount) between: 15 and: 17)
]

{ #category : #tests }
CardTest >> averagePercentOf: overloadCount [
	^ (overloadCount / 100000)*100
]

{ #category : #tests }
CardTest >> testCancellationCannotBeInitializeWithATargetPlayer [
	self
		should: [ Cancellation to: (TargetPlayer pointing: 'Manu') ]
		raise: InstanceCreationFailed
		withMessageText: 'Target must be a card'
]

{ #category : #tests }
CardTest >> testCannotDrawFromEmptyCardDeck [
	| aCardDeck |
	aCardDeck := CardDeck defaultWith: 2.
	self
		should: [ 3 timesRepeat: [ aCardDeck draw ] ]
		raise: InvalidAction
		withMessageText: 'Cannot draw from empty deck'
]

{ #category : #tests }
CardTest >> testCannotShuffleEmptyCardDeck [
	| aCardDeck |
	aCardDeck := CardDeck defaultWith: 1.
	aCardDeck draw.
	self
		should: [ aCardDeck shuffle ]
		raise: InvalidAction
		withMessageText: 'Cannot shuffle an empty deck'
]

{ #category : #tests }
CardTest >> testCardDeckGeneratorHasUniformDistribution [
	| aCardDeck cardsDrawn overloadCount accelerationCount cancellationCount redoCount repeatCount speedCount |
	aCardDeck := CardDeckGenerator withAllCards.
	cardsDrawn := OrderedCollection new.
	100000 timesRepeat: [ cardsDrawn add: aCardDeck draw ].
	overloadCount := cardsDrawn
		count: [ :card | card isMemberOf: Overload ].
	speedCount := cardsDrawn count: [ :card | card isMemberOf: Speed ].
	accelerationCount := cardsDrawn
		count: [ :card | card isMemberOf: Acceleration ].
	cancellationCount := cardsDrawn
		count: [ :card | card isMemberOf: Cancellation ].
	redoCount := cardsDrawn count: [ :card | card isMemberOf: Redo ].
	repeatCount := cardsDrawn count: [ :card | card isMemberOf: Repeat ].
	self assertAverageIsBetween15and17Of: overloadCount.
	self assertAverageIsBetween15and17Of: speedCount.
	self assertAverageIsBetween15and17Of: accelerationCount.
	self assertAverageIsBetween15and17Of: cancellationCount.
	self assertAverageIsBetween15and17Of: redoCount.
	self assertAverageIsBetween15and17Of: repeatCount
]

{ #category : #tests }
CardTest >> testCardsAreIdentical [
	| aSpeed aDifferentSpeed anIdenticalSpeed |
	aSpeed := Card to: (TargetPlayer pointing: 'Fran').
	aDifferentSpeed := Card to: (TargetPlayer pointing: 'Manu').
	anIdenticalSpeed := Card to: (TargetPlayer pointing: 'Fran').
	self assert: (aSpeed isIdenticalTo: anIdenticalSpeed).
	self assert: (aSpeed isIdenticalTo: aDifferentSpeed) not.
]

{ #category : #tests }
CardTest >> testDrawingCardDecreasesCardDeckSize [
	| aCardDeck |
	aCardDeck := CardDeck defaultWith: 10.
	self assert: aCardDeck cardCount equals: 10.
	aCardDeck draw.
	self assert: aCardDeck cardCount equals: 9.
	
]

{ #category : #tests }
CardTest >> testOverloadCannotBeInitializeWithATargetPlayer [
	self
		should: [ Overload to: (TargetCard pointing: (Acceleration to: NonTarget new)) ]
		raise: InstanceCreationFailed
		withMessageText: 'Target must be a player'
]

{ #category : #tests }
CardTest >> testShuffledDeckIncludesSameCards [
	| aCardDeck accelerationCount overloadCount redoCount cancellationCount cardsDrawn|
	cardsDrawn := OrderedCollection new.
	aCardDeck := CardDeck with: {Acceleration to: NonTarget new. Overload to: NonTarget new. Cancellation to: NonTarget new. Redo to: NonTarget new. Redo to: NonTarget new}.
	aCardDeck shuffle.
	5 timesRepeat: [ cardsDrawn add: aCardDeck draw ].
	overloadCount := cardsDrawn
		count: [ :card | card isMemberOf: Overload ].
	accelerationCount := cardsDrawn
		count: [ :card | card isMemberOf: Acceleration ].
	cancellationCount := cardsDrawn
		count: [ :card | card isMemberOf: Cancellation ].
	redoCount := cardsDrawn count: [ :card | card isMemberOf: Redo ].
	self assert: overloadCount equals: 1.
	self assert: accelerationCount equals: 1.
	self assert: cancellationCount equals: 1.
	self assert: redoCount equals: 2.
	self assert: overloadCount equals: 1.
	
]

{ #category : #tests }
CardTest >> testSpeedCannotBeInitializeWithATargetPlayer [
	self
		should: [ Speed to: (TargetCard pointing: (Acceleration to: NonTarget new)) ]
		raise: InstanceCreationFailed
		withMessageText: 'Target must be a player'
]

{ #category : #tests }
CardTest >> testSpeedCardsAreIdentical [
	| aSpeed aDifferentSpeed anIdenticalSpeed |
	aSpeed := Speed to: (TargetPlayer pointing: 'Fran').
	aDifferentSpeed := Speed to: (TargetPlayer pointing: 'Manu').
	anIdenticalSpeed := Speed to: (TargetPlayer pointing: 'Fran').
	self assert: (aSpeed isIdenticalTo: anIdenticalSpeed).
	self assert: (aSpeed isIdenticalTo: aDifferentSpeed) not.
]
