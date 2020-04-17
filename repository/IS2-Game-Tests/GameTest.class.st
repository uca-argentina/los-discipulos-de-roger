Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IS2-Game-Tests'
}

{ #category : #tests }
GameTest >> test01NewGameCreatedAsNotStarted [
	| aGame |
	aGame := Game with: Die d4 as: NotStarted new.
	self assert: (aGame state isMemberOf: NotStarted) equals: true
]

{ #category : #tests }
GameTest >> test02StartingNotValidGames [
	| aGame |
	aGame := Game with: Die d4 as: Started new.
	self should: [ aGame begin ] raise: InvalidAction   withMessageText: 'Cannot start a game that is already started'.
	aGame:= Game with: Die d4 as: NotValid new.
	self should: [ aGame begin ] raise: InvalidAction   withMessageText: 'Cannot start without a game'.
	aGame:= Game createNew.
	self should: [ aGame begin ] raise: InstanceCreationFailed    withMessageText: 'It makes no sense to iterate in a cyclic way an empty collection'.
	aGame:= Game with: Die d4 as: Finished new.
	self should: [ aGame begin ] raise: InvalidAction   withMessageText: 'Cannot start a finished game'.
]

{ #category : #tests }
GameTest >> test03CreatingAGameWithAndWithoutDice [
	
	| aGame |
	aGame := Game createNew.
	self assert: (aGame getDice isMemberOf: Die) equals: true.
]

{ #category : #tests }
GameTest >> test04 [

| aGame |
aGame := Game createNew .
self assert: aGame length equals: 12.
]
