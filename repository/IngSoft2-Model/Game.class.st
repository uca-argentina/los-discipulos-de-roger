Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'dice',
		'state',
		'playerSequence',
		'length',
		'laps',
		'scoreboard'
	],
	#category : #'IngSoft2-Model-Game'
}

{ #category : #instanceCreation }
Game class >> with: dice andFields: aNumber andPlayers: players andLaps: laps [
	^ self new
		initializeDice: dice
		withFields: aNumber
		andPlayers: players
		andLaps: laps.
]

{ #category : #instanceCreation }
Game class >> with: aDice andPlayers: players [
^self with: aDice andFields: 12 andPlayers: players andLaps: 1
]

{ #category : #instanceCreation }
Game class >> with: aDie andPlayers: aCollection ofLaps: anInteger [ 
	^self with: aDie andFields: 16  andPlayers: aCollection andLaps: anInteger 
]

{ #category : #instanceCreation }
Game class >> withPlayers: players [
	^self with: Die d6 andFields: 12 andPlayers: players  andLaps: 1
]

{ #category : #accessing }
Game >> actualPlayer [
	^playerSequence current
]

{ #category : #playing }
Game >> addLapTo: aPlayer [ 
	aPlayer position >= length ifTrue: [ aPlayer addLapAndMove:(aPlayer position%length)].
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
Game >> initializeDice: aDice withFields: aNumber andPlayers: players andLaps: ammountLaps [
	dice := aDice.
	playerSequence := CircularIterator cyclingOver: players.
	length := aNumber.
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
	^length
]

{ #category : #playing }
Game >> playATurn [
	self actualPlayer updateAPlayerPosition: self roll.
	self addLapTo: self actualPlayer.
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
