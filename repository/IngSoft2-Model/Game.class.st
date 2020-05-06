Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'dice',
		'state',
		'playerSequence',
		'length'
	],
	#category : #'IngSoft2-Model-Game'
}

{ #category : #instanceCreation }
Game class >> with: dice andFields: aNumber andPlayers: players [
	^ self new
		initializeDice: dice
		withFields: aNumber
		andPlayers: players.
]

{ #category : #instanceCreation }
Game class >> with: aDice andPlayers: players [
^self with: aDice andFields: 12 andPlayers: players
]

{ #category : #instanceCreation }
Game class >> withFields: aNumber andPlayers: players [
^self with: Die d4  andFields: aNumber andPlayers: players
]

{ #category : #instanceCreation }
Game class >> withPlayers: players [
	^self with: Die d6 andFields: 12 andPlayers: players 
]

{ #category : #results }
Game >> att: aPosition [

"This could be used to get when is a players turn or to get the positions at the end of the game"

^playerSequence att: aPosition 
]

{ #category : #StateChanging }
Game >> finishAnStartedGame [
	state := Finished new.
	playerSequence sort
]

{ #category : #accessing }
Game >> getDice [
	^dice
]

{ #category : #initialization }
Game >> initializeDice: aDice withFields: aNumber andPlayers: players [
	dice := aDice.
	playerSequence := CircularIterator cyclingOver: players.
	length := aNumber.
	state := Started new.
	"tablePosition := players."
]

{ #category : #'as yet unclassified' }
Game >> isFinished [
	^state isFinished.
]

{ #category : #checking }
Game >> isPlayedBy: aPlayer [ 
	^ playerSequence includes: aPlayer.
]

{ #category : #accessing }
Game >> length [
	^length
]

{ #category : #playing }
Game >> playNext [
	| position |
	position := playerSequence next move: self roll.
	state finish:self at: position.
]

{ #category : #playing }
Game >> playUntilFinished [
"playNext pero juega hasta que termine el juego, no sólo la próxima jugada"
	| position |
	position := playerSequence next move: self roll.
	state finishAndContinue:self at: position.
]

{ #category : #playing }
Game >> roll [
	^dice roll.
]

{ #category : #accessing }
Game >> state [
	^state
]

{ #category : #accessing }
Game >> winner [
	^state winner: self
]

{ #category : #results }
Game >> winnerWhenFinished [
	^playerSequence first.
]
