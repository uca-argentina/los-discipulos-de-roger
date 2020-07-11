Class {
	#name : #Cancellation,
	#superclass : #InstantCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #accessing }
Cancellation class >> to: aTarget [
	(aTarget isMemberOf: TargetPlayer)
		ifTrue: [ InstanceCreationFailed signal: 'Target must be a card' ].
	^ self new initializeWithTarget: aTarget from: self
]

{ #category : #playing }
Cancellation >> useEffectFor: aGame by: aPlayer [
	((target isValid) and: (aGame hasActivatedPermanents)) ifFalse: [InvalidAction signal: 'Invalid Card Usage'].
	aGame removePermanentCard: target objective.
	aGame addToDeck: self.
	aGame addToDiscardDeck: self.
]
