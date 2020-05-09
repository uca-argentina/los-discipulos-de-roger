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
ScoreboardRaw >> >= aPlayer [ 
	^laps >= (aPlayer laps)
]

{ #category : #playing }
ScoreboardRaw >> addLapAndMove: aMovement [
	laps := laps + 1.
	self resetPosition.
	self updateAPlayerPosition: aMovement
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
ScoreboardRaw >> position [
	^position
]

{ #category : #playing }
ScoreboardRaw >> resetPosition [
	position := 0
]

{ #category : #playing }
ScoreboardRaw >> updateAPlayerPosition: aMovement [
	position := position + aMovement.
]
