Class {
	#name : #CardHistory,
	#superclass : #Object,
	#instVars : [
		'thrownCards'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #acccessing }
CardHistory >> add: aCard [
	thrownCards add: aCard
]

{ #category : #'as yet unclassified' }
CardHistory >> hasActivatedPermanents [
	thrownCards detect: [ :card | card isPermanent ] ifFound: [ ^true ].
	^false.
]

{ #category : #initialization }
CardHistory >> initialize [
	thrownCards := OrderedCollection new
]

{ #category : #acccessing }
CardHistory >> last [
	^ thrownCards last copy
]

{ #category : #acccessing }
CardHistory >> remove: aCard [
	| cardsIdenticalToCard cardsNotIdenticalToCard |
	cardsIdenticalToCard := self selectIdenticalTo: aCard.
	self removeFirstFrom: cardsIdenticalToCard.
	cardsNotIdenticalToCard := self selectNotIdenticalTo: aCard.
	cardsNotIdenticalToCard addAll: cardsIdenticalToCard.
	thrownCards := cardsNotIdenticalToCard
]

{ #category : #private }
CardHistory >> removeFirstFrom: cardsIdenticalToCard [
	cardsIdenticalToCard isEmpty
		ifFalse: [ cardsIdenticalToCard removeFirst ]
]

{ #category : #private }
CardHistory >> selectIdenticalTo: aCard [
	^ thrownCards select: [ :card | card isIdenticalTo: aCard ]
]

{ #category : #private }
CardHistory >> selectNotIdenticalTo: aCard [
	^ thrownCards select: [ :card | (card isIdenticalTo: aCard) not ]
]

{ #category : #playing }
CardHistory >> triggerEffectsFor: aGame [
	thrownCards do: [ :aCard | aCard triggerEffectFor: aGame ]
]
