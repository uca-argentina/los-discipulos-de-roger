Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'nameSurname',
		'playingGame',
		'position'
	],
	#category : #'IS2-Players'
}

{ #category : #'as yet unclassified' }
Player class >> getNameSurname [
	^nameSurname 
]

{ #category : #'as yet unclassified' }
Player class >> playing [
	^gamePlaying.
]

{ #category : #'as yet unclassified' }
Player class >> position [
	^0
]

{ #category : #instanceCreation }
Player class >> withNameSurname: aNameSurname [ 
	nameSurname := aNameSurname.
	^self
]

{ #category : #instanceCreation }
Player class >> withNameSurname: aNameSurname  playing: aGame [ 
		^self new 
		initializeWithNameSurname: aNameSurname and: aGame.
]

{ #category : #'as yet unclassified' }
Player >> getNameSurname [
	^nameSurname
]

{ #category : #initialization }
Player >> initializeWithNameSurname: aNameSurname and: aGame [ 
	nameSurname := aNameSurname.
	playingGame := aGame .
	position := 0.
]

{ #category : #'as yet unclassified' }
Player >> playing [
	^playingGame 
]

{ #category : #'as yet unclassified' }
Player >> position [
	^0
]

{ #category : #playing }
Player >> roll [
	position := position + (playingGame roll)
]
