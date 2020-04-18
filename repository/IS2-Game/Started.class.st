Class {
	#name : #Started,
	#superclass : #Object,
	#category : #'IS2-Game'
}

{ #category : #StateChanging }
Started >> finish: aGame at: aPosition [

	(aGame length >= aPosition) ifFalse: [ aGame finishAnStartedGame ].
=======
{ #category : #'as yet unclassified' }
Started >> add: aPlayer in: aGame [ 
	InvalidAction signal: 'A player cannot join a started game'
]
