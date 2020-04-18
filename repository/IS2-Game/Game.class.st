Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'dice',
		'state',
		'playerSequence',
		'length'
	],
	#category : #'IS2-Game'
}

{ #category : #instanceCreation }
Game class >> default: players [
	^self with: Die d6 andFields: 12 andPlayers: players 
]

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

{ #category : #resultados }
Game >> att: aPosition [

"This could be used to get when is a players turn or to get the positions at the end of the game"

^playerSequence att: aPosition 
]

{ #category : #StateChanging }
Game >> finishAnStartedGame [
	state := Finished new.
	playerSequence sort
]

{ #category : #'as yet unclassified' }
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
Game >> isPlayedBy: aPlayer [ 
	^ playerSequence includes: aPlayer.
]

{ #category : #'as yet unclassified' }
Game >> length [
	^length
]

{ #category : #playing }
Game >> playNext [
	| position |
	position := playerSequence next rollingFor: self.
	state finish:self at: position.
]

{ #category : #playing }
Game >> roll [
	^dice roll.
]

{ #category : #'as yet unclassified' }
Game >> state [
	^state
]

{ #category : #'as yet unclassified' }
Game >> winner [
	^state winner: self
]

{ #category : #resultados }
Game >> winnerWhenFinished [
	^playerSequence first.
]
