Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'dice',
		'state',
		'playerSequence',
		'laps',
		'scoreboard',
		'board'
	],
	#category : #'IngSoft2-Model-Game'
}

{ #category : #'as yet unclassified' }
Game class >> playedBy: aCollection [ 
	^self with: Die d6 on: Board ucaGameDefault playedBy: aCollection  withLaps: 1
]

{ #category : #instanceCreation }
Game class >> with: dice on: aBoard playedBy: players withLaps: laps [
	^ self new
		initializeDice: dice
		withBoard: aBoard
		andPlayers: players
		andLaps: laps.
]

{ #category : #'as yet unclassified' }
Game class >> with: aDice playedBy: aCollection on: aBoard [ 
	^self with: aDice on: aBoard playedBy: aCollection  withLaps: 1.
]

{ #category : #accessing }
Game >> actualPlayer [
	^playerSequence current
]

{ #category : #results }
Game >> atPodium: aPosition [

"This could be used to get when is a players turn or to get the positions at the end of the game"

^scoreboard  at: aPosition 
]

{ #category : #playing }
Game >> changeLapsOf: aPlayer [
	(self outOfBounds: aPlayer)
		ifTrue: [ aPlayer
				addLap: aPlayer position // self length
				andMove: aPlayer position % self length ]
]

{ #category : #accessing }
Game >> dice [
	^dice
]

{ #category : #StateChanging }
Game >> finishStartedGame [
	state := Finished new.
]

{ #category : #playing }
Game >> finishTurn [
	state finish: self.
	playerSequence next.
	self updateScoreboard
]

{ #category : #results }
Game >> hasFinished [
	^state hasFinished.
]

{ #category : #initialization }
Game >> initializeDice: aDice withBoard: aBoard andPlayers: players andLaps: ammountLaps [
	| rows |
	rows := self makePlayerRows: players. 
	dice := aDice.
	playerSequence := CircularIterator cyclingOver: (rows copy).
	board := aBoard.
	state := Started new.
	laps := ammountLaps. 
	scoreboard := Scoreboard withRows: rows.
]

{ #category : #accessing }
Game >> laps [
	^ laps
]

{ #category : #accessing }
Game >> length [
	^board length 
]

{ #category : #'as yet unclassified' }
Game >> makePlayerRows: aCollection [ 
	| rowList |
	rowList := OrderedCollection new.
	aCollection  do: [ :playerName | rowList add: (ScoreboardRaw ofPlayerNamed: playerName )].
	^rowList 
]

{ #category : #playing }
Game >> moonWalk: anInteger [
	scoreboard
		do: [ :player | 
			player != self actualPlayer
				ifTrue:
					[ self move: anInteger toThis: player ] ]
]

{ #category : #playing }
Game >> move: anInteger toThis: player [
	player move: anInteger.
	^ self changeLapsOf: player
]

{ #category : #playing }
Game >> moveActualPlayerBackwards: aMovement [
	self move: aMovement*(-1) toThis: self actualPlayer
]

{ #category : #playing }
Game >> moveActualPlayerForward: aMovement [
	self move: aMovement toThis: self actualPlayer
]

{ #category : #playing }
Game >> outOfBounds: aPlayer [
	^ aPlayer position >= self length | (aPlayer position < 0)
]

{ #category : #playing }
Game >> playTurn [
	state canPlay ifFalse:[ InvalidAction signal: 'Cannot play a finished game.'].
	self moveActualPlayerForward: self roll.
	board triggerFor: self.
	self finishTurn.
]

{ #category : #playing }
Game >> playUntilFinished [
	"playNext pero juega hasta que termine el juego, no sólo la próxima jugada"

[self hasFinished] whileFalse: [ self playTurn  ]
]

{ #category : #accessing }
Game >> podiumOf: aScoreboardRaw [ 
	^ scoreboard indexOf: aScoreboardRaw 
]

{ #category : #playing }
Game >> resetAllPlayersPosition [
	scoreboard do: [ :player | player resetPosition  ]
]

{ #category : #playing }
Game >> roll [
	^dice roll.
]

{ #category : #results }
Game >> updateScoreboard [
	scoreboard sort: [ :a :b | a>=b ]
]

{ #category : #accessing }
Game >> winner [
	^state winner: self
]

{ #category : #results }
Game >> winnerWhenFinished [
	^scoreboard first.
]
