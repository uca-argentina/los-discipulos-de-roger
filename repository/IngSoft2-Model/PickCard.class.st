Class {
	#name : #PickCard,
	#superclass : #Field,
	#category : #'IngSoft2-Model-Board'
}

{ #category : #playing }
PickCard >> triggerEffectFor: aGame [ 
	aGame pickCardForActualPlayer.
]
