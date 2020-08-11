Class {
	#name : #BaselineOfKnead3d,
	#superclass : #BaselineOf,
	#category : #BaselineOfKnead3d
}

{ #category : #baselines }
BaselineOfKnead3d >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'FromScratch';
				package: 'FromScratch-Tests'
					with: [ spec requires: #('FromScratch') ];
				package: 'Knead3d' with: [ spec requires: #('FromScratch') ];
				package: 'Knead3d-Tests'
					with: [ spec requires: #('FromScratch' 'Knead3d') ] ]
]

{ #category : #accessing }
BaselineOfKnead3d >> projectClass [
	^ MetacelloCypressBaselineProject
]
