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

{ #category : #'as yet unclassified' }
Cancellation >> triggerEffectFor: aGame [ 

]

{ #category : #'as yet unclassified' }
Cancellation >> useEffectFor: aGame [
	target isValid
		ifFalse: [ InvalidAction signal: 'Cannot be used without a target' ].
	aGame removePermanentCard: target objective.
	aGame addPermanent: self
]
