Class {
	#name : #Overload,
	#superclass : #PermanentCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #accessing }
Overload class >> to: aTarget [
	(aTarget isMemberOf: TargetCard)
		ifTrue: [ InstanceCreationFailed signal: 'Target must be a player' ].
	^ self new initializeWithTarget: aTarget from: self
]

{ #category : #playing }
Overload >> triggerEffectFor: aGame [ 
	
	target objective = aGame actualPlayer ifTrue: [ aGame moveActualPlayerBackwards: 2 ].
]
