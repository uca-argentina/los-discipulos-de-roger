Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests-Board-Tests'
}

{ #category : #tests }
BoardTest >> test01CreateABoardWith53Fields [
	| aBoard |
	aBoard := Board withFields: 53.
	self assert: aBoard length equals:53.
]

{ #category : #tests }
BoardTest >> test02CannotCreateABoardWithZeroOrNegativeFields [
	self
		should: [ Board withFields: 0 ]
		raise: InstanceCreationFailed 
		withMessageText: 'Cannot create a board of zero or negative length'.
]

{ #category : #tests }
BoardTest >> test03BoardOf100Has48SpecialFields [
| aBoard |
	aBoard := Board withFields: 100.
	self assert: (aBoard fields count: [ :field | field isMemberOf: NoEffect ]) equals: 48.
	self assert: (aBoard fields count: [ :field | field isMemberOf: Wormhole ]) equals: 20.
	self assert: (aBoard fields count: [ :field | field isMemberOf: SpeedUp ]) equals: 20.
	self assert: (aBoard fields count: [ :field | field isMemberOf: AtomicBomb ]) equals: 2.
	self assert: (aBoard fields count: [ :field | field isMemberOf: Moonwalk ]) equals: 10.
]
