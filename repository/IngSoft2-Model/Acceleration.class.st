Class {
	#name : #Acceleration,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #comparing }
Acceleration >> = aCard [
	^aCard isMemberOf: Acceleration.
]
