Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'target',
		'cardType'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #accessing }
Card class >> createTemplate [
	^self to: NonTarget new.
]

{ #category : #accessing }
Card class >> to: aTarget [
	^self new initializeWithTarget: aTarget from: self.
]

{ #category : #accessing }
Card class >> to: aTarget from: aCardType [
	^self new initializeWithTarget: aTarget from: aCardType
]

{ #category : #comparing }
Card >> = aCard [
	^ aCard isMemberOf: self class
]

{ #category : #comparing }
Card >> cardType [
	^cardType.
]

{ #category : #initialization }
Card >> initializeWithTarget: aTarget from: aCardClass [
	target:= aTarget.
	cardType := aCardClass.
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
