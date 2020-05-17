Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests-Board-Tests'
}

{ #category : #tests }
BoardTest >> boardGeneratorStandard [
	| aBoardGenerator |
	aBoardGenerator := BoardGenerator with: 48 of: NoEffect.
	aBoardGenerator add: 20 of: SpeedUp.
	aBoardGenerator add: 20 of: Wormhole.
	aBoardGenerator add: 10 of: Moonwalk.
	aBoardGenerator add: 2 of: AtomicBomb.
	^ aBoardGenerator
]

{ #category : #tests }
BoardTest >> test02CannotCreateABoardWithZeroOrNegativeFields [
	self
		should: [ Board withFields: self boardGeneratorStandard picking: 0]
		raise: InstanceCreationFailed 
		withMessageText: 'Cannot create a board of zero or negative length'.
]

{ #category : #tests }
BoardTest >> test03aBoardWithAStandardBoardGeneratorHas50Fields [


| aBoard |
aBoard := Board withFields: self boardGeneratorStandard picking: 50 .
self assert: aBoard length equals: 50
]

{ #category : #tests }
BoardTest >> testBoardGeneratorGenerates100Fields [
	| aBoardGenerator |
	aBoardGenerator := self boardGeneratorStandard.
	self assert: aBoardGenerator size equals: 100
]

{ #category : #tests }
BoardTest >> testBoardGeneratorGenerates48NoEffects [


| aBoardGenerator |
aBoardGenerator := BoardGenerator with: 48 of: NoEffect.
self assert: aBoardGenerator size equals: 48.
]
