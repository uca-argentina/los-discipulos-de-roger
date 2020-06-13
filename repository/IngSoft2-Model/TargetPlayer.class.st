Class {
	#name : #TargetPlayer,
	#superclass : #Target,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'as yet unclassified' }
TargetPlayer >> initializePointingTo: aPlayerName [
	 
	objective := Player ofPlayerNamed: aPlayerName.
]

{ #category : #'as yet unclassified' }
TargetPlayer >> isValid [
	^true
]
