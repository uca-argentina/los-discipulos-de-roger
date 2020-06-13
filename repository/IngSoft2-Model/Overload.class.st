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

{ #category : #'as yet unclassified' }
Overload >> triggerEffectFor: aGame [ 
	
	target objective = aGame actualPlayer ifTrue: [ aGame moveActualPlayerBackwards: 2 ].
]

{ #category : #'as yet unclassified' }
Overload >> useEffectFor: aGame [
	target isValid
		ifFalse: [ InvalidAction signal: 'Cannot be used without a target' ].
	aGame addPermanent: self
]
