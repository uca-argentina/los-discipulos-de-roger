Extension { #name : #TestAsserter }

{ #category : #'*IS2-Dice-Tests' }
TestAsserter >> should: aBlock raise: anException withMessageText: aString [

	self
		should: aBlock
		raise: anException
		withExceptionDo: [ :error | self assert: error messageText equals: aString ]
]
