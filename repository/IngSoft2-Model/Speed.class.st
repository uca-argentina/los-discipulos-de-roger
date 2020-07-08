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

{ #category : #comparing }
Speed >> isPermanent [
	^true.
]

{ #category : #playing }
Speed >> triggerEffectFor: aGame [
	target objective = aGame actualPlayer
		ifTrue: [ aGame moveActualPlayerForward: 1 ]
]

{ #category : #playing }
Speed >> useEffectFor: aGame by: aPlayer [
	target isValid.
	aGame addPermanent: self by: aPlayer
]
