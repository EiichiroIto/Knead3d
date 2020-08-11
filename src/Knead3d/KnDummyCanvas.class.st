Class {
	#name : #KnDummyCanvas,
	#superclass : #Object,
	#instVars : [
		'whenLogDo'
	],
	#category : #'Knead3d-Dummy'
}

{ #category : #api }
KnDummyCanvas >> fillColor: aColor [
	whenLogDo
		cull: [ :l | 
			l
				add:
					{#fillColor:.
					aColor} ]
]

{ #category : #api }
KnDummyCanvas >> line: aPoint1 to: aPoint2 width: anInteger color: aColor [
	whenLogDo
		cull: [ :l | 
			l
				add:
					{#line:to:width:color:.
					aPoint1.
					aPoint2.
					anInteger.
					aColor} ]
]

{ #category : #accessing }
KnDummyCanvas >> whenLogDo: aBlock [
	whenLogDo := aBlock
]
