Class {
	#name : #Speed,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #accessing }
Speed class >> to: aTarget [
	(aTarget isMemberOf: TargetCard)
		ifTrue: [ InstanceCreationFailed signal: 'Target must be a player' ].
	^ self new initializeWithTarget: aTarget
]

{ #category : #'as yet unclassified' }
Speed >> triggerEffectFor: aGame [ 
	((target objective )= (aGame actualPlayer)) ifTrue: [ aGame moveActualPlayerForward: 1 ]
]

{ #category : #'as yet unclassified' }
Speed >> useEffectFor: aGame [
	target isValid
		ifFalse: [ InvalidAction signal: 'Cannot be used without a target' ].
	aGame addPermanent: self
]
