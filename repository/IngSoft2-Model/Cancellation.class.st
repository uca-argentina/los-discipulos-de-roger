Class {
	#name : #Cancellation,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #accessing }
Cancellation class >> to: aTarget [
	(aTarget isMemberOf: TargetPlayer)
		ifTrue: [ InstanceCreationFailed signal: 'Target must be a card' ].
	^ self new initializeWithTarget: aTarget
]

{ #category : #playing }
Cancellation >> triggerEffectFor: aGame [ 

]

{ #category : #playing }
Cancellation >> useEffectFor: aGame by: aPlayer [
	target isValid.
	aGame removePermanentCard: target objective.
	aGame addToDeck: self
]
