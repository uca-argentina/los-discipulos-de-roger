Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'fields'
	],
	#category : #'IngSoft2-Model-Board'
}

{ #category : #'as yet unclassified' }
Board class >> default [
	^self withFields: BoardGenerator default picking: 12. 
]

{ #category : #'as yet unclassified' }
Board class >> standardBoard [
	self shouldBeImplemented.
]

{ #category : #'instance creation' }
Board class >> withFields: aBoardGenerator picking: aNumberOfFields [

 (aNumberOfFields >0) ifFalse:[
				InstanceCreationFailed
				signal: 'Cannot create a board of zero or negative length' ].
	^self new initializeWithFields: aBoardGenerator picking: aNumberOfFields.
]

{ #category : #accessing }
Board >> fields [
	^fields.
]

{ #category : #initialization }
Board >> initializeWithFields: arrayOfFields picking: aNumberOfFields [ 
| random |
random := Random new.
fields:= OrderedCollection new.
aNumberOfFields timesRepeat: [fields add: (arrayOfFields at: (random nextInt: arrayOfFields size))].

]

{ #category : #accessing }
Board >> length [
 ^fields size.
]

{ #category : #'as yet unclassified' }
Board >> triggerFor: aGame [ 
	(fields at: (aGame actualPlayer position)+1) triggerEffectFor: aGame.
]
