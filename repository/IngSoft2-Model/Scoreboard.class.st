Class {
	#name : #Scoreboard,
	#superclass : #Object,
	#instVars : [
		'rowList'
	],
	#category : #'IngSoft2-Model-Scoreboard'
}

{ #category : #instanceCreation }
Scoreboard class >> withRows: rows [ 
	^self new
		initializeWithRows: rows
]

{ #category : #accesing }
Scoreboard >> at: anIndex [
	^rowList at: anIndex 
]

{ #category : #accesing }
Scoreboard >> do: aBlockClosure [ 
	rowList do: aBlockClosure.
]

{ #category : #accesing }
Scoreboard >> first [
	^rowList first
]

{ #category : #accesing }
Scoreboard >> indexOf: aScoreboardRaw [
	(rowList includes: aScoreboardRaw) ifFalse: [ InvalidAction signal: 'El player no esta jugando.' ].
	^ rowList indexOf: aScoreboardRaw
]

{ #category : #initialization }
Scoreboard >> initializeWithRows: rows [ 
	rowList := rows
]

{ #category : #accesing }
Scoreboard >> sort: aSortProtocol [
	rowList sort: aSortProtocol.
]
