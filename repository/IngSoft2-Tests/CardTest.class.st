Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests-Card-Tests'
}

{ #category : #tests }
CardTest >> assertAverageIsBetween16and17Of: overloadCount [
	self
		assert: ((self averagePercentOf: overloadCount) between: 16 and: 17)
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
CardTest >> testCardDeckHasUniformDistribution [
	| aCardDeck cardsDrawn overloadCount accelerationCount cancellationCount redoCount repeatCount speedCount |
	aCardDeck := CardDeck withAllCards.
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
	self assertAverageIsBetween16and17Of: overloadCount.
	self assertAverageIsBetween16and17Of: speedCount.
	self assertAverageIsBetween16and17Of: accelerationCount.
	self assertAverageIsBetween16and17Of: cancellationCount.
	self assertAverageIsBetween16and17Of: redoCount.
	self assertAverageIsBetween16and17Of: repeatCount
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
CardTest >> testOverloadCannotBeInitializeWithATargetPlayer [
	self
		should: [ Overload to: (TargetCard pointing: (Acceleration to: NonTarget new)) ]
		raise: InstanceCreationFailed
		withMessageText: 'Target must be a player'
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
