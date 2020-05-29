Class {
	#name : #BoardGeneratorTest,
	#superclass : #TestCase,
	#instVars : [
		'countNoEffects',
		'countAtomicBomb',
		'countMoonwalk',
		'countspeedUp',
		'countWormhole',
		'aBoardGenerator'
	],
	#category : #'IngSoft2-Tests-Board-Tests'
}

{ #category : #tests }
BoardGeneratorTest >> averageOf: countNoEffects [
	^ countNoEffects average asFloat rounded
]

{ #category : #tests }
BoardGeneratorTest >> count: fieldClass of: aBoard [
	^ aBoard fields
		count: [ :field | 
			field isMemberOf: fieldClass ]
]

{ #category : #running }
BoardGeneratorTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	countNoEffects := OrderedCollection new.
	countAtomicBomb := OrderedCollection new.
	countMoonwalk := OrderedCollection new.
	countspeedUp := OrderedCollection new.
	countWormhole := OrderedCollection new.
	aBoardGenerator := BoardGenerator with: 20 of: Wormhole new.
	aBoardGenerator add: 20 of: SpeedUp new.
	aBoardGenerator add: 10 of: Moonwalk createField.
	aBoardGenerator add: 2 of: AtomicBomb new.
	aBoardGenerator completeFields.
]

{ #category : #tests }
BoardGeneratorTest >> test02CannotCreateABoardWithZeroOrNegativeFields [
	self
		should: [ BoardGenerator new buildOf:0 ]
		raise: InstanceCreationFailed
		withMessageText: 'Cannot create a board of zero or negative length'
]

{ #category : #tests }
BoardGeneratorTest >> testBoardGeneratorCompletedHave100Fields [
	| aBoardGenerator |
	aBoardGenerator := BoardGenerator with: 20 of: (Wormhole new).
	self assert: (aBoardGenerator completeFields) size equals: 100
]

{ #category : #tests }
BoardGeneratorTest >> testBoardHasCorrectDistribution [

	| aBoard |
	2000
		timesRepeat: [ aBoard := aBoardGenerator buildOf: 100.
			countNoEffects add: (self count: NoEffect of: aBoard).
			countAtomicBomb add: (self count: AtomicBomb of: aBoard).
			countMoonwalk add: (self count: Moonwalk of: aBoard).
			countspeedUp add: (self count: SpeedUp  of: aBoard).
			countWormhole add: (self count: Wormhole  of: aBoard) ].
	self assert: (self averageOf: countNoEffects) equals: 48.
	self assert: (self averageOf: countAtomicBomb) equals: 2.
	self assert: (self averageOf: countWormhole) equals: 20.
	self assert: (self averageOf: countspeedUp) equals: 20.
	self assert: (self averageOf: countMoonwalk) equals: 10.
]
