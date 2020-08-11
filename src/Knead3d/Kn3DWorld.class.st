Class {
	#name : #Kn3DWorld,
	#superclass : #Object,
	#instVars : [
		'dfPen',
		'projection',
		'clipping',
		'parameter',
		'transformation'
	],
	#category : #'Knead3d-Core'
}

{ #category : #private }
Kn3DWorld >> clip: vec4 opcode: anInteger [
	clipping clip: vec4 opcode: anInteger
]

{ #category : #accessing }
Kn3DWorld >> clipping [
	^ clipping
]

{ #category : #accessing }
Kn3DWorld >> clipping: aClippingContext [
	clipping := aClippingContext
]

{ #category : #api }
Kn3DWorld >> color: aColor [
	self putOpcode: KnDisplayItem color arg: aColor
]

{ #category : #accessing }
Kn3DWorld >> dfPen [
	^ dfPen
]

{ #category : #accessing }
Kn3DWorld >> dfPen: vec4 [
	dfPen := vec4
]

{ #category : #accessing }
Kn3DWorld >> displayFile [
	^ clipping displayFile
]

{ #category : #accessing }
Kn3DWorld >> displayFile: aCollection [
	clipping displayFile: aCollection
]

{ #category : #private }
Kn3DWorld >> displayFileEnter: anInteger [
	| vec4 |
	anInteger >= KnDisplayItem cursor
		ifFalse: [ self error ].
	vec4 := self dfPen.
	vec4 := transformation transform: vec4.
	vec4 := projection transform: vec4.
	anInteger = KnDisplayItem cursor
		ifTrue: [ clipping viewingTransform: vec4 opcode: anInteger ]
		ifFalse: [ self clip: vec4 opcode: anInteger ]
]

{ #category : #api }
Kn3DWorld >> getViewDistance [
	^ self parameter viewDistance
]

{ #category : #api }
Kn3DWorld >> getViewPlaneNormal [
	^ self parameter viewPlaneNormal
]

{ #category : #api }
Kn3DWorld >> getViewReferencePoint [
	^ self parameter viewReferencePoint
]

{ #category : #api }
Kn3DWorld >> getViewUp [
	^ self parameter viewUp
]

{ #category : #api }
Kn3DWorld >> getWindowCenter [
	| window |
	window := self parameter window.
	^ ((window first + window second) / 2)
		@ ((window third + window fourth) / 2)
]

{ #category : #initialization }
Kn3DWorld >> initialize [
	clipping := self newClipping
]

{ #category : #api }
Kn3DWorld >> lineToAbs: vec4 [
	self dfPen: vec4.
	self displayFileEnter: KnDisplayItem line
]

{ #category : #api }
Kn3DWorld >> lineToRel: vec4 [
	self dfPen: (self dfPen ifNil: [ vec4 ] ifNotNil: [ :p | p + vec4 ]).
	self displayFileEnter: KnDisplayItem line
]

{ #category : #private }
Kn3DWorld >> makeViewPlaneTransformation [
	transformation := self newTransformation.
	transformation
		translate: self translateVector;
		rotateXY: parameter viewPlaneNormal;
		rotateUp: parameter viewUp.
	projection makeTransformation: transformation tMatrix
]

{ #category : #private }
Kn3DWorld >> makeWindow [
	clipping
		window: parameter window;
		viewport: parameter viewport;
		setupViewport
]

{ #category : #private }
Kn3DWorld >> makeZClipPlanes [
	clipping
		frontZ: (projection adjustZ: parameter frontZ)
		backZ: (projection adjustZ: parameter backZ)
]

{ #category : #api }
Kn3DWorld >> moveToAbs: vec4 [
	self dfPen: vec4.
	self displayFileEnter: KnDisplayItem move
]

{ #category : #api }
Kn3DWorld >> moveToRel: vec4 [
	self dfPen: (self dfPen ifNil: [ vec4 ] ifNotNil: [ :p | p + vec4 ]).
	self displayFileEnter: KnDisplayItem move
]

{ #category : #private }
Kn3DWorld >> newClipping [
	^ KnClippingContext new
]

{ #category : #private }
Kn3DWorld >> newParam [
	^ KnViewingParameter new
]

{ #category : #private }
Kn3DWorld >> newTransformation [
	^ KnTransformation new
]

{ #category : #api }
Kn3DWorld >> newVecX: x y: y z: z [
	^ KnVec4 x: x y: y z: z
]

{ #category : #api }
Kn3DWorld >> newView [
	self displayFile: OrderedCollection new.
	projection ifNil: [ ^ self ].
	self makeViewPlaneTransformation.
	self makeWindow.
	self makeZClipPlanes
]

{ #category : #accessing }
Kn3DWorld >> parameter [
	^ parameter ifNil: [ parameter := self newParam ]
]

{ #category : #accessing }
Kn3DWorld >> parameter: aKnViewingParameters [
	parameter := aKnViewingParameters
]

{ #category : #api }
Kn3DWorld >> polygonAbsolute: aCollection [
	aCollection size < 3
		ifTrue: [ self error: 'invalid size' ].
	aCollection last in: [ :v | self dfPen: v ].
	self displayFileEnter: aCollection size.
	aCollection do: [ :v | self lineToAbs: v ]
]

{ #category : #api }
Kn3DWorld >> polygonRelative: aCollection [
	| tmp |
	aCollection size < 3
		ifTrue: [ self error: 'invalid size' ].
	tmp := self dfPen + aCollection last.
	self displayFileEnter: aCollection size.
	aCollection allButFirstDo: [ :v | self lineToRel: v ].
	self lineToAbs: tmp
]

{ #category : #printing }
Kn3DWorld >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(;
		nextPutAll: self identityHash asString;
		nextPut: $)
]

{ #category : #accessing }
Kn3DWorld >> projection [
	^ projection
]

{ #category : #private }
Kn3DWorld >> putOpcode: opcode arg: anObject [
	self displayFile add: (KnDisplayItem opcode: opcode arg: anObject)
]

{ #category : #api }
Kn3DWorld >> setBackClipping: aNumberOrNil [
	self parameter backDistance: aNumberOrNil
]

{ #category : #api }
Kn3DWorld >> setFrontClipping: aNumberOrNil [
	self parameter frontDistance: aNumberOrNil
]

{ #category : #api }
Kn3DWorld >> setParallel: vec4 [
	projection := KnParallelTransform new.
	(vec4 r closeTo: 0) ifTrue: [ self error: 'No direction of projection' ].
	projection direction: vec4
]

{ #category : #api }
Kn3DWorld >> setPerspective: vec4 [
	projection := KnPerspectiveTransform new.
	projection center: vec4
]

{ #category : #api }
Kn3DWorld >> setViewDistance: aNumber [
	self parameter viewDistance: aNumber
]

{ #category : #api }
Kn3DWorld >> setViewPlaneNormal: vec4 [
	self parameter viewPlaneNormal: vec4
]

{ #category : #api }
Kn3DWorld >> setViewReferencePoint: vec4 [
	self parameter viewReferencePoint: vec4
]

{ #category : #api }
Kn3DWorld >> setViewUp: vec4 [
	self parameter viewUp: vec4
]

{ #category : #api }
Kn3DWorld >> setWindowCenter: aPoint [
	| window extent |
	window := self parameter window.
	extent := (window second - window first)
		@ (window fourth - window third).
	self parameter
		window:
			{(aPoint x - (extent x / 2)).
			(aPoint x + (extent x / 2)).
			(aPoint y - (extent y / 2)).
			(aPoint y + (extent y / 2))}
]

{ #category : #api }
Kn3DWorld >> showCursor: aVector [
	self dfPen: aVector.
	self displayFileEnter: KnDisplayItem cursor
]

{ #category : #accessing }
Kn3DWorld >> transformation [
	^ transformation
]

{ #category : #accessing }
Kn3DWorld >> transformation: aTransformation [
	transformation := aTransformation
]

{ #category : #private }
Kn3DWorld >> translateVector [
	^ (parameter viewReferencePoint
		+ (parameter viewPlaneNormal * parameter viewDistance)) negated
]
