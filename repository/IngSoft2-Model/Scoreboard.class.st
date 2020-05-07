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
Scoreboard >> first [
	^rowList first
]

{ #category : #initialization }
Scoreboard >> initializeWithRows: rows [ 
	rowList := rows
]

{ #category : #accesing }
Scoreboard >> sort: aSortProtocol [
	rowList sort: aSortProtocol.
]
