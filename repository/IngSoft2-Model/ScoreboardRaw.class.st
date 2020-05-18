Class {
	#name : #ScoreboardRaw,
	#superclass : #Object,
	#instVars : [
		'playerName',
		'position',
		'laps'
	],
	#category : #'IngSoft2-Model-Scoreboard'
}

{ #category : #instanceCreation }
ScoreboardRaw class >> ofPlayerNamed: aNameSurname [
		aNameSurname isEmpty 
		ifTrue: [ InstanceCreationFailed
				signal: 'The player name cannot be blank' ].
		
		^self new 
		initializeWithName: aNameSurname
]

{ #category : #comparing }
ScoreboardRaw >> != aScoreboardRaw [ 
	^ (self = aScoreboardRaw) not
]

{ #category : #comparing }
ScoreboardRaw >> = aScoreboardRaw [ 
	^ (playerName = aScoreboardRaw playerName)
]

{ #category : #comparing }
ScoreboardRaw >> >= aPlayer [ 
	^laps > (aPlayer laps) | (laps = aPlayer laps & (position > aPlayer position))
]

{ #category : #playing }
ScoreboardRaw >> addLap: lapsToMove andMove: aMovement [

	laps := laps + lapsToMove.
	self resetPosition.
	self updateAPlayerPosition: aMovement.
	self checkLapCount.
]

{ #category : #playing }
ScoreboardRaw >> checkLapCount [
	laps < 0
		ifTrue: [ self resetLapsAndPosition ]
]

{ #category : #initialization }
ScoreboardRaw >> initializeWithName: aName [
	playerName := aName.
	position := 0.
	laps := 0.
]

{ #category : #accessing }
ScoreboardRaw >> laps [
	^ laps
]

{ #category : #accessing }
ScoreboardRaw >> name [
	^playerName
]

{ #category : #accessing }
ScoreboardRaw >> playerName [
	^ playerName
]

{ #category : #accessing }
ScoreboardRaw >> position [
	^position
]

{ #category : #playing }
ScoreboardRaw >> resetLapsAndPosition [
	laps := 0.
	self resetPosition
]

{ #category : #playing }
ScoreboardRaw >> resetPosition [
	position := 0.
]

{ #category : #playing }
ScoreboardRaw >> updateAPlayerPosition: aMovement [
	position := position + aMovement.
]
