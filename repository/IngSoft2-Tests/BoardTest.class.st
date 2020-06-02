Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests-Board-Tests'
}

{ #category : #tests }
BoardTest >> boardGeneratorStandard [
	| aBoardGenerator |
	aBoardGenerator := BoardGenerator with: 20 of: SpeedUp new.
	aBoardGenerator add: 20 of: Wormhole new.
	aBoardGenerator add: 10 of: Moonwalk new.
	aBoardGenerator add: 2 of: AtomicBomb new.
	aBoardGenerator completeFields.
	^ aBoardGenerator
]

{ #category : #tests }
BoardTest >> test03aBoardWithAStandardBoardGeneratorHas50Fields [
	| aBoard |
	aBoard := self boardGeneratorStandard buildOf: 50.
	self assert: aBoard length equals: 50
]
