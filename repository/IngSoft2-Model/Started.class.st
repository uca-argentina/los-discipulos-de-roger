Class {
	#name : #Started,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Game'
}

{ #category : #StateChanging }
Started >> finish: aGame at: aPosition [

	(aGame length >= aPosition) ifFalse: [ aGame finishAnStartedGame ].
]
