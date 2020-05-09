Class {
	#name : #Started,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Game'
}

{ #category : #StateChanging }
Started >> canFinish: aGame [

	^ aGame laps <= aGame actualPlayer laps.
]

{ #category : #StateChanging }
Started >> finish: aGame [
	(self canFinish: aGame)
		ifTrue: [ aGame finishAnStartedGame ]
]

{ #category : #'as yet unclassified' }
Started >> hasFinished [
	^false
]

{ #category : #StateChanging }
Started >> winner: aGame [
	InvalidAction signal: 'The game has not finished yet.'.
]
