Class {
	#name : #Finished,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Game'
}

{ #category : #evaluation }
Finished >> hasFinished [
	^true.
]

{ #category : #accessing }
Finished >> winner: aGame [ 
	^aGame winnerWhenFinished.
]
