Class {
	#name : #Started,
	#superclass : #Object,
	#category : #'IngSoft2-Model-UCAGame'
}

{ #category : #StateChanging }
Started >> canFinish: aGame [

	^ aGame laps <= aGame actualPlayer laps.
]

{ #category : #checking }
Started >> canPlay [
	^true.
]

{ #category : #StateChanging }
Started >> finish: aGame [
	(self canFinish: aGame)
		ifTrue: [ aGame finishStartedGame ]
]

{ #category : #checking }
Started >> hasFinished [
	^false
]

{ #category : #StateChanging }
Started >> winner: aGame [
	InvalidAction signal: 'The game has not finished yet.'.
]
