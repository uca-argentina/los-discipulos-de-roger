Extension { #name : #TestAsserter }

{ #category : #'*IngSoft2-Tests' }
TestAsserter >> should: aBlock raise: anException withMessageText: aString [

	self
		should: aBlock
		raise: anException
		withExceptionDo: [ :error | self assert: error messageText equals: aString ]
]
