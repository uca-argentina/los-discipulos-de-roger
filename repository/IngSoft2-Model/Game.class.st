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

{ #category : #instanceCreation }
Game class >> with: dice andBoard: aBoard andPlayers: players andLaps: laps [
	^ self new
		initializeDice: dice
		withBoard: aBoard
		andPlayers: players
		andLaps: laps.
]

{ #category : #'as yet unclassified' }
Game class >> with: aDie andPlayers: aCollection [ 
	^self with: aDie andBoard: Board default  andPlayers: aCollection andLaps: 1
]

{ #category : #'as yet unclassified' }
Game class >> with: aDice andPlayers: aCollection andBoard: aBoard [ 
	^self with: aDice andBoard: aBoard andPlayers: aCollection  andLaps: 1.
]

{ #category : #'as yet unclassified' }
Game class >> with: aDie andPlayers: aCollection ofLaps: anInteger [ 
	^self with: aDie andBoard: Board default  andPlayers:aCollection  andLaps: anInteger  .
]

{ #category : #'as yet unclassified' }
Game class >> withPlayers: aCollection [ 
	^self with: Die d6 andBoard: Board default andPlayers: aCollection  andLaps: 1
]

{ #category : #accessing }
Game >> actualPlayer [
	^playerSequence current
]

{ #category : #playing }
Game >> addLapTo: aPlayer [
	| boardLength |
	boardLength := self length.
	aPlayer position >= boardLength
		ifTrue: [ aPlayer addLapAndMove: aPlayer position % boardLength ]
]

{ #category : #results }
Game >> att: aPosition [

"This could be used to get when is a players turn or to get the positions at the end of the game"

^scoreboard  at: aPosition 
]

{ #category : #accessing }
Game >> dice [
	^dice
]

{ #category : #playing }
Game >> finishATurn [
	state finish: self.
	playerSequence next.
	self updateScoreboard
]

{ #category : #StateChanging }
Game >> finishAnStartedGame [
	state := Finished new.
]

{ #category : #results }
Game >> hasFinished [
	^state hasFinished.
]

{ #category : #initialization }
Game >> initializeDice: aDice withBoard: aBoard andPlayers: players andLaps: ammountLaps [
	dice := aDice.
	playerSequence := CircularIterator cyclingOver: players.
	board := aBoard.
	state := Started new.
	laps := ammountLaps. 
	scoreboard := Scoreboard withRows: players
]

{ #category : #accessing }
Game >> laps [
	^ laps
]

{ #category : #accessing }
Game >> length [
	^board length 
]

{ #category : #playing }
Game >> playATurn [
	self actualPlayer updateAPlayerPosition: self roll.
	self addLapTo: self actualPlayer.
	board triggerFor: self.
	self finishATurn.
]

{ #category : #playing }
Game >> playUntilFinished [
	"playNext pero juega hasta que termine el juego, no sólo la próxima jugada"

[self hasFinished] whileFalse: [ self playATurn  ]
]

{ #category : #playing }
Game >> roll [
	^dice roll.
]

{ #category : #'as yet unclassified' }
Game >> speedUp [
	self actualPlayer updateAPlayerPosition: 4.
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

{ #category : #'as yet unclassified' }
Game >> wormHole [
	self actualPlayer updateAPlayerPosition: -4.
]
