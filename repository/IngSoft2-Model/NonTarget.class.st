Class {
	#name : #NonTarget,
	#superclass : #Target,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #comparing }
NonTarget >> = aTarget [
	^ (aTarget isMemberOf: NonTarget)
]

{ #category : #checking }
NonTarget >> isValid [
	InvalidAction signal: 'Cannot be used without a target'
]

{ #category : #accessing }
NonTarget >> objective [
]
