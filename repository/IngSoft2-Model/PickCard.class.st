Class {
	#name : #PickCard,
	#superclass : #Field,
	#category : #'IngSoft2-Model-Board'
}

{ #category : #'as yet unclassified' }
PickCard >> triggerEffectFor: aGame [ 
	aGame pickCardForActualPlayer.
]
