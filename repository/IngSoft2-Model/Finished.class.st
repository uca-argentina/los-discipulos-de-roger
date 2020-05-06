Class {
	#name : #Finished,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Game'
}

{ #category : #'as yet unclassified' }
Finished >> isFinished [
	^true.
]

{ #category : #accessing }
Finished >> winner: aGame [ 
	^aGame winnerWhenFinished.
]
