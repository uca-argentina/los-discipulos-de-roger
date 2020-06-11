Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'as yet unclassified' }
Card class >> playingAs: aCardPlayState [
	^self new
	initializeWithPlayState: aCardPlayState
]

{ #category : #'as yet unclassified' }
Card >> = aCard [ 
^ (aCard isMemberOf: self class) 
]

{ #category : #'as yet unclassified' }
Card >> triggerEffectFor: aGame [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
Card >> useEffectFor: aGame [
	self subclassResponsibility
]
