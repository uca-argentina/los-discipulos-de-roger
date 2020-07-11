Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'playerName',
		'position',
		'laps',
		'hand'
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

{ #category : #accessing }
Player >> cardDeckCount [
	^hand size
]

{ #category : #playing }
Player >> checkLapCount [
	laps < 0
		ifTrue: [ self resetLapsAndPosition ]
]

{ #category : #accessing }
Player >> getCardAt: index [
	^ hand removeAt: index
]

{ #category : #initialization }
Player >> initializeWithName: aName [
	playerName := aName.
	position := 0.
	laps := 0.
	hand := OrderedCollection new.
]

{ #category : #accessing }
Player >> laps [
	^ laps
]

{ #category : #playing }
Player >> layCard: aCardType for: aGame [
	| index |
	index := hand indexOf: aCardType.
	index > 0
		ifFalse: [ InvalidAction signal: 'Player does not have this type of card' ].
	aCardType useEffectFor: aGame by: self.
	self getCardAt: index
]

{ #category : #playing }
Player >> move: aMovement [
	position := position + aMovement.
]

{ #category : #accessing }
Player >> name [
	^playerName
]

{ #category : #playing }
Player >> pick: anInteger from: aCardDeck [
	anInteger timesRepeat: [ hand add: aCardDeck draw  ].
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
