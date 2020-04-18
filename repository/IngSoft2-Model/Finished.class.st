Class {
	#name : #Finished,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Game'
}

{ #category : #accessing }
Finished >> winner: aGame [ 
	^aGame winnerWhenFinished.
]
