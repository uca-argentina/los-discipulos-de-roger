Class {
	#name : #TargetPlayer,
	#superclass : #Target,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #initialization }
TargetPlayer >> initializePointingTo: aPlayerName [
	 
	objective := Player ofPlayerNamed: aPlayerName.
]

{ #category : #checking }
TargetPlayer >> isValid [
]
