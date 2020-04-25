Class {
	#name : #BaselineOfIngSoft2,
	#superclass : #BaselineOf,
	#category : #BaselineOfIngSoft2
}

{ #category : #baselines }
BaselineOfIngSoft2 >> baseline: spec [

	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'IngSoft2-Model';
				package: 'IS2-Dice-Tests';
				package: 'IngSoft2-Tests' with: [ spec requires: #('IngSoft2-Model') ].

			spec
				group: 'default' with: #('deployment');
				group: 'deployment' with: #('IngSoft2-Model');
				group: 'deployment' with: #('IS2-Dice-Tests');
				group: 'development' with: #('IngSoft2-Tests') ]
]

{ #category : #accessing }
BaselineOfIngSoft2 >> projectClass [

	^ MetacelloCypressBaselineProject
]
