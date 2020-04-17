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
Player class >> position [
	^0
]

{ #category : #instanceCreation }
Player class >> withNameSurname: aNameSurname [ 
	| aGame |
	aGame := Game newNotValidGame.
	^self withNameSurname:aNameSurname playing: aGame
]

{ #category : #instanceCreation }
Player class >> withNameSurname: aNameSurname  playing: aGame [ 
	
		aNameSurname isEmpty 
		ifTrue: [ InstanceCreationFailed
				signal: 'The player name cannot be blank' ].
		
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

{ #category : #playing }
Player >> join: aGame [

playingGame := aGame.
aGame add: self.
]

{ #category : #'as yet unclassified' }
Player >> playing [
	^playingGame 
]

{ #category : #'as yet unclassified' }
Player >> position [
	^position
]

{ #category : #playing }
Player >> roll: aDie [ 
	position := position + aDie roll.
]
