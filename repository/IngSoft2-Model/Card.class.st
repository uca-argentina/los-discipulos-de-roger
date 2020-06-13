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

{ #category : #'as yet unclassified' }
Card >> = aCard [ 
^ (aCard isMemberOf: self class) 
]

{ #category : #initialization }
Card >> initializeWithTarget: aTarget [ 
	target := aTarget.
]

{ #category : #'as yet unclassified' }
Card >> isIdenticalTo: aCard [ 
	^ (aCard = self) & aCard target= target
]

{ #category : #'as yet unclassified' }
Card >> target [
	^ target
]

{ #category : #'as yet unclassified' }
Card >> triggerEffectFor: aGame [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
Card >> useEffectFor: aGame [
	self subclassResponsibility
]
