Class {
	#name : #BoardGeneratorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests-BoardGenerator-Tests'
}

{ #category : #tests }
BoardGeneratorTest >> test01CreateABoardWithNoSpecialFields [
	| aBoard |
	aBoard := BoardGenerator createWithFields: 12.
	self assert: aBoard fields equals:12
]
