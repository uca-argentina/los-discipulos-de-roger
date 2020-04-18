Class {
	#name : #Started,
	#superclass : #Object,
	#category : #'IS2-Game'
}

{ #category : #StateChanging }
Started >> finish: aGame at: aPosition [

	(aGame length >= aPosition) ifFalse: [ aGame finishAnStartedGame ].
]
