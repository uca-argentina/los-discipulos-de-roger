Class {
	#name : #HandGenerator,
	#superclass : #Object,
	#instVars : [
		'cardsAvailable',
		'cardsGenerated'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'as yet unclassified' }
HandGenerator class >> withCards: anInteger [ 
	^self new
	initializeWithCards: anInteger .
]

{ #category : #'as yet unclassified' }
HandGenerator >> initializeWithCards: anInteger [ 
	cardsAvailable := { Acceleration new. Cancellation new. Overload new. Redo new. Repeat new. Speed new }.
	cardsGenerated := OrderedCollection new.
	anInteger timesRepeat: [ cardsGenerated add: (cardsAvailable at: ((Random new) nextInt: cardsAvailable size))].
	^cardsGenerated.
	
]
