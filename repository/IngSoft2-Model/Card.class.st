Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #accessing }
Card class >> to: aTarget [
	^self new initializeWithTarget: aTarget
]

{ #category : #comparing }
Card >> = aCard [
	^ aCard isMemberOf: self class
]

{ #category : #initialization }
Card >> initializeWithTarget: aTarget [
	target := aTarget
]

{ #category : #comparing }
Card >> isIdenticalTo: aCard [
	^ aCard = self & aCard target = target
]

{ #category : #comparing }
Card >> isPermanent [
	self subclassResponsibility.
]

{ #category : #accessing }
Card >> target [
	^ target
]

{ #category : #playing }
Card >> triggerEffectFor: aGame [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
Card >> useEffectFor: aGame by: anObject [
	self subclassResponsibility
]
