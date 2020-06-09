Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'playerName',
		'position',
		'laps',
		'cardDeck'
	],
	#category : #'IngSoft2-Model-Scoreboard'
}

{ #category : #instanceCreation }
Player class >> ofPlayerNamed: aNameSurname [
		aNameSurname isEmpty 
		ifTrue: [ InstanceCreationFailed
				signal: 'The player name cannot be blank' ].
		
		^self new 
		initializeWithName: aNameSurname
]

{ #category : #comparing }
Player >> != aScoreboardRaw [ 
	^ (self = aScoreboardRaw) not
]

{ #category : #comparing }
Player >> = aScoreboardRaw [  
	^ (playerName = aScoreboardRaw playerName)
]

{ #category : #comparing }
Player >> >= aPlayer [ 
	^laps > (aPlayer laps) | (laps = aPlayer laps & (position > aPlayer position))
]

{ #category : #playing }
Player >> addLap: lapsToMove andMove: aMovement [

	laps := laps + lapsToMove.
	self resetPosition.
	self move: aMovement.
	self checkLapCount.
]

{ #category : #'as yet unclassified' }
Player >> cardCount [
	^cardDeck size
]

{ #category : #playing }
Player >> checkLapCount [
	laps < 0
		ifTrue: [ self resetLapsAndPosition ]
]

{ #category : #initialization }
Player >> initializeWithName: aName [
	self initializeWithName: aName andCards: (HandGenerator withCards: 2). 
]

{ #category : #initialization }
Player >> initializeWithName: aName andCards: aCardGenerator [
	playerName := aName.
	position := 0.
	laps := 0.
	cardDeck := aCardGenerator.
]

{ #category : #accessing }
Player >> laps [
	^ laps
]

{ #category : #playing }
Player >> move: aMovement [
	position := position + aMovement.
]

{ #category : #accessing }
Player >> name [
	^playerName
]

{ #category : #accessing }
Player >> playerName [
	^ playerName
]

{ #category : #accessing }
Player >> position [
	^position
]

{ #category : #playing }
Player >> resetLapsAndPosition [
	laps := 0.
	self resetPosition
]

{ #category : #playing }
Player >> resetPosition [
	position := 0.
]
