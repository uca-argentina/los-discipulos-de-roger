Class {
	#name : #BoardGenerator,
	#superclass : #Object,
	#instVars : [
		'fields'
	],
	#category : #'IngSoft2-Model-BoardGenerator'
}

{ #category : #initialization }
BoardGenerator class >> createWithFields: aNumberofFields [ 
	^self withFields: aNumberofFields.
]

{ #category : #'class initialization' }
BoardGenerator class >> withFields: aNumberOfFields [ 
	^self new
		withFields: aNumberOfFields.
]

{ #category : #'as yet unclassified' }
BoardGenerator >> fields [
	^ fields
]

{ #category : #initialization }
BoardGenerator >> withFields: aNumberOfFields [ 
	fields := aNumberOfFields.
]
