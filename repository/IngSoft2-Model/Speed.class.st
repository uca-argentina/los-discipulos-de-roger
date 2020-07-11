Class {
	#name : #Speed,
	#superclass : #PermanentCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #accessing }
Speed class >> to: aTarget [
	(aTarget isMemberOf: TargetCard)
		ifTrue: [ InstanceCreationFailed signal: 'Target must be a player' ].
	^ self new initializeWithTarget: aTarget from: self
]

{ #category : #playing }
Speed >> triggerEffectFor: aGame [
	target objective = aGame actualPlayer
		ifTrue: [ aGame moveActualPlayerForward: 1 ]
]
