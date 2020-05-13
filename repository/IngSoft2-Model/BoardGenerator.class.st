Class {
	#name : #BoardGenerator,
	#superclass : #Object,
	#instVars : [
		'fields'
	],
	#category : #'IngSoft2-Model-Board'
}

{ #category : #'as yet unclassified' }
BoardGenerator class >> default [ 
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

{ #category : #'as yet unclassified' }
BoardGenerator >> add: aNumberOfFields  of: aFieldClass [  
	aNumberOfFields timesRepeat: [ fields add: aFieldClass new ]
]

{ #category : #'as yet unclassified' }
BoardGenerator >> at: anIndex [
	^fields at: anIndex 
]

{ #category : #'as yet unclassified' }
BoardGenerator >> initializeWith: aNumberOfFields  of: aFieldClass [  
	fields := OrderedCollection new.
	self add: aNumberOfFields   of: aFieldClass 
]

{ #category : #'as yet unclassified' }
BoardGenerator >> size [ 
^fields size
]
