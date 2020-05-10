Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'fields'
	],
	#category : #'IngSoft2-Model-Board'
}

{ #category : #'instance creation' }
Board class >> withFields: aNumberOfFields [ 

 (aNumberOfFields >0) ifFalse:[
				InstanceCreationFailed
				signal: 'Cannot create a board of zero or negative length' ].
	^self new withFields: aNumberOfFields.
]

{ #category : #'instance creation' }
Board class >> withFields: aNumberOfFields of: aFieldClass [ 

 (aNumberOfFields >0) ifFalse:[
				InstanceCreationFailed
				signal: 'Cannot create a board of zero or negative length' ].
	^self new withFields: aNumberOfFields of: aFieldClass.
]

{ #category : #initialization }
Board >> addFields: anAmount of: fieldClass [
	anAmount  timesRepeat: [ fields add: fieldClass new. ].

]

{ #category : #accessing }
Board >> fields [
	^fields.
]

{ #category : #accessing }
Board >> length [
 ^fields size.
]

{ #category : #initialization }
Board >> shuffleFields [
	fields := fields asArray shuffle
]

{ #category : #initialization }
Board >> withFields: aNumberOfFields [
	fields := LinkedList new.
	self addFields: aNumberOfFields * 0.20 // 1 of: Wormhole.
	self addFields: aNumberOfFields * 0.20 // 1 of: SpeedUp.
	self addFields: aNumberOfFields * 0.10 // 1 of: Moonwalk.
	self addFields: aNumberOfFields * 0.02 // 1 of: AtomicBomb.
	self addFields: aNumberOfFields - fields size of: NoEffect.
	self shuffleFields
]

{ #category : #initialization }
Board >> withFields: aNumberOfFields of: aFieldClass [
	fields := LinkedList new.
	self addFields: aNumberOfFields of: aFieldClass.
]
