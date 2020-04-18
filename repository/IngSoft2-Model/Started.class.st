Class {
	#name : #Started,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Game'
}

{ #category : #StateChanging }
Started >> finish: aGame at: aPosition [

	(aGame length >= aPosition) ifFalse: [ aGame finishAnStartedGame ].
]

{ #category : #StateChanging }
Started >> finishAndContinue: aGame at: aPosition [.

	(aGame length >= aPosition) ifFalse: [ aGame finishAnStartedGame ] ifTrue:[aGame carryOut].
]

{ #category : #StateChanging }
Started >> winner: aGame [
	InvalidAction signal: 'The game has not finished yet.'.
]
