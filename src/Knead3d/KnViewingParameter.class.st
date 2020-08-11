Class {
	#name : #KnViewingParameter,
	#superclass : #Object,
	#instVars : [
		'viewRefPoint',
		'viewPlaneNormal',
		'viewDistance',
		'viewUp',
		'frontDistance',
		'backDistance',
		'window',
		'viewport'
	],
	#category : #'Knead3d-Core'
}

{ #category : #accessing }
KnViewingParameter >> backDistance [
	^ backDistance
]

{ #category : #accessing }
KnViewingParameter >> backDistance: aNumber [
	(aNumber notNil
		and: [ frontDistance notNil and: [ frontDistance > aNumber ] ])
		ifTrue: [ self error: 'front plane behind back plane' ].
	backDistance := aNumber
]

{ #category : #accessing }
KnViewingParameter >> backZ [
	^ backDistance ifNotNil: [ viewDistance - backDistance ]
]

{ #category : #accessing }
KnViewingParameter >> frontDistance [
	^ frontDistance
]

{ #category : #accessing }
KnViewingParameter >> frontDistance: aNumber [
	(aNumber notNil
		and: [ backDistance notNil and: [ aNumber > backDistance ] ])
		ifTrue: [ self error: 'front plane behind back plane' ].
	frontDistance := aNumber
]

{ #category : #accessing }
KnViewingParameter >> frontZ [
	^ frontDistance ifNotNil: [ viewDistance - frontDistance ]
]

{ #category : #printing }
KnViewingParameter >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(;
		nextPutAll: self identityHash asString;
		nextPut: $)
]

{ #category : #accessing }
KnViewingParameter >> viewDistance [
	^ viewDistance ifNil: [ 0 ]
]

{ #category : #accessing }
KnViewingParameter >> viewDistance: aNumber [
	viewDistance := aNumber
]

{ #category : #accessing }
KnViewingParameter >> viewPlaneNormal [
	^ viewPlaneNormal
]

{ #category : #accessing }
KnViewingParameter >> viewPlaneNormal: vec4 [
	| d |
	d := vec4 r.
	(d closeTo: 0)
		ifTrue: [ self error: 'invalid view plane vector' ].
	viewPlaneNormal := KnVec4 x: vec4 x / d y: vec4 y / d z: vec4 z / d
]

{ #category : #accessing }
KnViewingParameter >> viewReferencePoint [
	^ viewRefPoint
]

{ #category : #accessing }
KnViewingParameter >> viewReferencePoint: vec4 [
	viewRefPoint := vec4
]

{ #category : #accessing }
KnViewingParameter >> viewUp [
	^ viewUp
]

{ #category : #accessing }
KnViewingParameter >> viewUp: vec4 [
	(vec4 r closeTo: 0)
		ifTrue: [ self error: 'invalid view up vector' ].
	(vec4 w = 0)
		ifFalse: [ self error: 'viewUp vector w must be 0' ].
	viewUp := vec4
]

{ #category : #accessing }
KnViewingParameter >> viewport [
	^ viewport
]

{ #category : #accessing }
KnViewingParameter >> viewport: anArray [
	(anArray isArray and: [ anArray size = 4 ])
		ifFalse: [ self error: 'viewport must be array with size 4' ].
	viewport := anArray
]

{ #category : #accessing }
KnViewingParameter >> window [
	^ window
]

{ #category : #accessing }
KnViewingParameter >> window: anArray [
	(anArray isArray and: [ anArray size = 4 ])
		ifFalse: [ self error: 'window must be array with size 4' ].
	window := anArray
]
