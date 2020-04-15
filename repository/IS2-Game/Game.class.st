Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'dice',
		'maxPlayers'
	],
	#category : #'IS2-Game'
}

{ #category : #instanceCreation }
Game class >> with: dice of: amountOfPlayers [ 
	^self new 
			initializeDice: dice andAmountOfPlayers: amountOfPlayers
]

{ #category : #initialization }
Game >> initializeDice: aDice andAmountOfPlayers: amountOfPlayers [ 
	dice := aDice.
	maxPlayers := amountOfPlayers.
	
]

{ #category : #playing }
Game >> roll [
	^dice roll 
]
