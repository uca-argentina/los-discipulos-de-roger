Class {
	#name : #Started,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Game'
}

{ #category : #StateChanging }
Started >> finish: aGame at: aPosition [
	(self isFinished: aGame at: aPosition)
		ifFalse: [ aGame finishAnStartedGame ]
]

{ #category : #'as yet unclassified' }
Started >> isFinished [
	^false
]

{ #category : #StateChanging }
Started >> isFinished: aGame at: aPosition [
	^ aGame laps > aPosition
]

{ #category : #StateChanging }
Started >> winner: aGame [
	InvalidAction signal: 'The game has not finished yet.'.
]
