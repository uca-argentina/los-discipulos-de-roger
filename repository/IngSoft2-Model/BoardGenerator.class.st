Class {
	#name : #BoardGenerator,
	#superclass : #Object,
	#instVars : [
		'fields'
	],
	#category : #'IngSoft2-Model-Board'
}

{ #category : #'as yet unclassified' }
BoardGenerator class >> ucaGameDefault [ 
	| aBoardGenerator |
	aBoardGenerator := self with: 48 of: NoEffect.
	aBoardGenerator add: 20 of: SpeedUp.
	aBoardGenerator add: 20 of: Wormhole.
	aBoardGenerator add: 10 of: Moonwalk.
	aBoardGenerator add: 2 of: AtomicBomb.
	^ aBoardGenerator
]

{ #category : #'as yet unclassified' }
BoardGenerator class >> with: aNumberOfFields  of: aFieldClass [  
	^self new
		initializeWith: aNumberOfFields of: aFieldClass.
]

{ #category : #accessing }
BoardGenerator >> add: aNumberOfFields  of: aField [  
	aNumberOfFields timesRepeat: [ fields add: aField]
]

{ #category : #building }
BoardGenerator >> buildOf: aNumberOfFields [
	| random arrayOfFields |
	aNumberOfFields > 0
		ifFalse: [ InstanceCreationFailed
				signal: 'Cannot create a board of zero or negative length' ].
	random := Random new.
	arrayOfFields := OrderedCollection new.
	aNumberOfFields
		timesRepeat: [ arrayOfFields add: (fields at: (random nextInt: fields  size)) ].
	^ Board withFields: arrayOfFields
]

{ #category : #building }
BoardGenerator >> completeFields [

fields size <100 ifTrue: [ self add: (100 - fields size) of: NoEffect new  ]
]

{ #category : #initialization }
BoardGenerator >> initializeWith: aNumberOfFields  of: aFieldClass [  
	fields := OrderedCollection new.
	self add: aNumberOfFields   of: aFieldClass 
]

{ #category : #accessing }
BoardGenerator >> size [ 
^fields size
]
