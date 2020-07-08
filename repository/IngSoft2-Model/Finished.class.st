Class {
	#name : #Finished,
	#superclass : #Object,
	#category : #'IngSoft2-Model-UCAGame'
}

{ #category : #checking }
Finished >> canPlay [
	^false.
]

{ #category : #evaluation }
Finished >> hasFinished [
	^true.
]

{ #category : #accessing }
Finished >> winner: aGame [ 
	^aGame winnerWhenFinished.
]
