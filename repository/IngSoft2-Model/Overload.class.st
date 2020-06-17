Class {
	#name : #Overload,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #accessing }
Overload class >> to: aTarget [
	(aTarget isMemberOf: TargetCard)
		ifTrue: [ InstanceCreationFailed signal: 'Target must be a player' ].
	^ self new initializeWithTarget: aTarget
]

{ #category : #playing }
Overload >> triggerEffectFor: aGame [ 
	
	target objective = aGame actualPlayer ifTrue: [ aGame moveActualPlayerBackwards: 2 ].
]

{ #category : #playing }
Overload >> useEffectFor: aGame by: aPlayer [
	target isValid.
	aGame addPermanent: self by: aPlayer
]
