Class {
	#name : #Kn3DExample2,
	#superclass : #Object,
	#instVars : [
		'slider'
	],
	#category : #'Knead3d-Examples'
}

{ #category : #private }
Kn3DExample2 class >> buildObject: aWorld [
	aWorld
		polygonAbsolute:
			{(aWorld newVecX: 0.5 y: 0.8 z: -0.2).
			(aWorld newVecX: 0.8 y: 0.5 z: -0.2).
			(aWorld newVecX: 0.8 y: 0.5 z: -0.8).
			(aWorld newVecX: 0.5 y: 0.8 z: -0.8)}.
	aWorld
		polygonAbsolute:
			{(aWorld newVecX: 0.8 y: 0.5 z: -0.2).
			(aWorld newVecX: 0.8 y: 0.2 z: -0.2).
			(aWorld newVecX: 0.8 y: 0.2 z: -0.8).
			(aWorld newVecX: 0.8 y: 0.5 z: -0.8)}.
	aWorld
		polygonAbsolute:
			{(aWorld newVecX: 0.5 y: 0.8 z: -0.2).
			(aWorld newVecX: 0.2 y: 0.5 z: -0.2).
			(aWorld newVecX: 0.2 y: 0.2 z: -0.2).
			(aWorld newVecX: 0.8 y: 0.2 z: -0.2).
			(aWorld newVecX: 0.8 y: 0.5 z: -0.2)}.
	aWorld
		polygonAbsolute:
			{(aWorld newVecX: 0.5 y: 0.8 z: -0.8).
			(aWorld newVecX: 0.8 y: 0.5 z: -0.8).
			(aWorld newVecX: 0.8 y: 0.2 z: -0.8).
			(aWorld newVecX: 0.2 y: 0.2 z: -0.8).
			(aWorld newVecX: 0.2 y: 0.5 z: -0.8)}.
	aWorld
		polygonAbsolute:
			{(aWorld newVecX: 0.5 y: 0.8 z: -0.2).
			(aWorld newVecX: 0.5 y: 0.8 z: -0.8).
			(aWorld newVecX: 0.2 y: 0.5 z: -0.8).
			(aWorld newVecX: 0.2 y: 0.5 z: -0.2)}.
	aWorld
		polygonAbsolute:
			{(aWorld newVecX: 0.2 y: 0.5 z: -0.8).
			(aWorld newVecX: 0.2 y: 0.2 z: -0.8).
			(aWorld newVecX: 0.2 y: 0.2 z: -0.2).
			(aWorld newVecX: 0.2 y: 0.5 z: -0.2)}.
	aWorld
		polygonAbsolute:
			{(aWorld newVecX: 0.8 y: 0.2 z: -0.2).
			(aWorld newVecX: 0.2 y: 0.2 z: -0.2).
			(aWorld newVecX: 0.2 y: 0.2 z: -0.8).
			(aWorld newVecX: 0.8 y: 0.2 z: -0.8)}
]

{ #category : #examples }
Kn3DExample2 class >> scene1 [
	<example>

	| obj |
	obj := self new.
	obj
		setup: [ :w | w
			setParallel: (w newVecX: 0 y: 0 z: 1);
			setViewReferencePoint: (w newVecX: 0.2 y: 0.2 z: -0.2) ]
]

{ #category : #examples }
Kn3DExample2 class >> scene10 [
	<example>
	| obj |
	obj := self new.
	obj
		setup: [ :w | 
			w
				setParallel: (w newVecX: 0.5 y: 0.5 z: 1);
				setViewPlaneNormal: (w newVecX: -0.5 y: -0.5 z: -1) ]
]

{ #category : #examples }
Kn3DExample2 class >> scene11 [
	<example>
	| obj |
	obj := self new.
	obj
		setup: [ :w | 
			w
				setParallel: (w newVecX: 0.5 y: 0 z: 1);
				setViewPlaneNormal: (w newVecX: -0.5 y: 0 z: -1);
				setViewReferencePoint: (w newVecX: 0.2 y: 0.2 z: -0.2) ]
]

{ #category : #examples }
Kn3DExample2 class >> scene12 [
	<example>
	| obj |
	obj := self new.
	obj
		setup: [ :w | 
			w
				setParallel: (w newVecX: 1 y: 0 z: 0);
				setViewPlaneNormal: (w newVecX: -1 y: 0 z: 0);
				setViewReferencePoint: (w newVecX: 0.2 y: 0.2 z: -0.2) ]
]

{ #category : #examples }
Kn3DExample2 class >> scene13 [
	<example>
	| obj |
	obj := self new.
	obj
		setup: [ :w | 
			w
				setParallel: (w newVecX: 0.2 y: 0 z: 1);
				setViewDistance: 0.2 ]
]

{ #category : #examples }
Kn3DExample2 class >> scene14 [
	<example>
	| obj |
	obj := self new.
	obj
		setup: [ :w | 
			w
				setParallel: (w newVecX: 0.2 y: 0 z: 1);
				setViewDistance: -0.2 ]
]

{ #category : #examples }
Kn3DExample2 class >> scene15 [
	<example>
	| obj |
	obj := self new.
	obj
		setup: [ :w | 
			w
				setViewPlaneNormal: (w newVecX: -1 y: 0 z: 0);
				setParallel: (w newVecX: 1 y: 0 z: 0);
				setViewReferencePoint: (w newVecX: 0.8 y: 0.2 z: -0.2) ]
]

{ #category : #examples }
Kn3DExample2 class >> scene16 [
	<example>
	| obj |
	obj := self new.
	obj
		setup: [ :w | 
			w
				setParallel: (w newVecX: 0 y: 0 z: 1);
				setViewUp: (w newVecX: 1 y: 1 z: 0) ]
]

{ #category : #examples }
Kn3DExample2 class >> scene17 [
	<example>
	| obj |
	obj := self new.
	obj
		setup: [ :w | 
			w
				setParallel: (w newVecX: 0 y: 1 z: 0);
				setViewPlaneNormal: (w newVecX: 0 y: -1 z: 0);
				setViewReferencePoint: (w newVecX: 0.2 y: 0.2 z: -0.2);
				setViewUp: (w newVecX: 0 y: 0 z: -1) ]
]

{ #category : #examples }
Kn3DExample2 class >> scene18 [
	<example>
	| obj |
	obj := self new.
	obj
		setup: [ :w | 
			w
				setParallel: (w newVecX: 0 y: 1 z: 0);
				setViewPlaneNormal: (w newVecX: 0 y: -1 z: 0);
				setViewReferencePoint: (w newVecX: 0.8 y: 0.2 z: -0.2);
				setViewUp: (w newVecX: -1 y: 0 z: 0) ]
]

{ #category : #examples }
Kn3DExample2 class >> scene19 [
	<example>
	| obj |
	obj := self new.
	obj
		setup: [ :w | 
			w
				setPerspective: (w newVecX: 0.5 y: 0.5 z: 1);
				setFrontClipping: 0.3;
				setBackClipping: 0.7 ]
]

{ #category : #examples }
Kn3DExample2 class >> scene2 [
	<example>
	| obj |
	obj := self new.
	obj setup: [ :w | w setParallel: (w newVecX: 0.2 y: 0 z: 1) ]
]

{ #category : #examples }
Kn3DExample2 class >> scene20 [
	<example>
	| obj |
	obj := self new.
	obj
		setup: [ :w | 
			w
				setPerspective: (w newVecX: 0.5 y: 0.5 z: 1);
				setFrontClipping: 0.3 ]
]

{ #category : #examples }
Kn3DExample2 class >> scene21 [
	<example>
	| obj |
	obj := self new.
	obj
		setup: [ :w | 
			w
				setPerspective: (w newVecX: 0.5 y: 0.5 z: 1);
				setBackClipping: 0.7 ]
]

{ #category : #examples }
Kn3DExample2 class >> scene22 [
	<example>
	| obj |
	obj := self new.
	obj setup: [ :w | w setPerspective: (w newVecX: 0.5 y: 0.5 z: 1) ]
]

{ #category : #examples }
Kn3DExample2 class >> scene23 [
	<example>
	| obj |
	obj := self new.
	obj
		setup: [ :w | 
			w
				setPerspective: (w newVecX: 0.5 y: 0.5 z: 1);
				setViewReferencePoint: (w newVecX: 0 y: 0 z: -0.2) ]
]

{ #category : #examples }
Kn3DExample2 class >> scene3 [
	<example>

	| obj |
	obj := self new.
	obj
		setup: [ :w | w setParallel: (w newVecX: -0.2 y: 0 z: 1) ]
]

{ #category : #examples }
Kn3DExample2 class >> scene4 [
	<example>

	| obj |
	obj := self new.
	obj
		setup: [ :w | w setParallel: (w newVecX: 0 y: -0.2 z: 1) ]
]

{ #category : #examples }
Kn3DExample2 class >> scene5 [
	<example>

	| obj |
	obj := self new.
	obj
		setup: [ :w | w setParallel: (w newVecX: 0 y: 0.2 z: 1) ]
]

{ #category : #examples }
Kn3DExample2 class >> scene6 [
	<example>
	| obj |
	obj := self new.
	obj
		setup: [ :w | 
			w
				setParallel: (w newVecX: 0 y: 0 z: 1);
				setViewPlaneNormal: (w newVecX: -0.5 y: 0 z: -1) ]
]

{ #category : #examples }
Kn3DExample2 class >> scene7 [
	<example>
	| obj |
	obj := self new.
	obj
		setup: [ :w | 
			w
				setParallel: (w newVecX: 0 y: 0 z: 1);
				setViewPlaneNormal: (w newVecX: 0 y: -0.5 z: -1) ]
]

{ #category : #examples }
Kn3DExample2 class >> scene8 [
	<example>
	| obj |
	obj := self new.
	obj
		setup: [ :w | 
			w
				setParallel: (w newVecX: 0.5 y: 0 z: 1);
				setViewPlaneNormal: (w newVecX: -0.5 y: 0 z: -1) ]
]

{ #category : #examples }
Kn3DExample2 class >> scene9 [
	<example>
	| obj |
	obj := self new.
	obj
		setup: [ :w | 
			w
				setParallel: (w newVecX: 0 y: 0.5 z: 1);
				setViewPlaneNormal: (w newVecX: 0 y: -0.5 z: -1) ]
]

{ #category : #private }
Kn3DExample2 >> dragged: aMorph from: aPoint1 to: aPoint2 [
	slider := nil
]

{ #category : #private }
Kn3DExample2 >> dragging: aMorph from: aPoint1 to: aPoint2 [
	| diff |
	slider ifNil: [ ^ self ].
	diff := aPoint2 - aPoint1.
	aMorph knWorld
		setViewReferencePoint: ((slider x: slider x - diff x) y: slider y + diff y).
	aMorph updateDisplay
]

{ #category : #private }
Kn3DExample2 >> newParam: aWorld [
	^ KnViewingParameter new
		viewReferencePoint: (aWorld newVecX: 0 y: 0 z: 0);
		viewPlaneNormal: (aWorld newVecX: 0 y: 0 z: -1);
		viewDistance: 0;
		viewUp: (aWorld newVecX: 0 y: 1 z: 0);
		frontDistance: nil;
		backDistance: nil;
		window: #(0 1 0 1);
		yourself
]

{ #category : #accessing }
Kn3DExample2 >> setup: aBlock [
	| m |
	m := KnViewerMorph new.
	m color: Color white.
	m knWorld: Kn3DWorld new.
	m display: KnFormDisplay new.
	m knWorld parameter: (self newParam: m knWorld).
	m extent: 200 @ 200.
	m whenBuildObject: [ self class buildObject: m knWorld ].
	m whenStartDragDo: [ :p | self startDrag: m at: p ].
	m whenDraggingDo: [ :p1 :p2 | self dragging: m from: p1 to: p2 ].
	m whenDraggedDo: [ :p1 :p2 | self dragged: m from: p1 to: p2 ].
	aBlock cull: m knWorld.
	m updateDisplay.
	m openInWorld
]

{ #category : #private }
Kn3DExample2 >> startDrag: aMorph at: aPoint [
	slider := aMorph knWorld getViewReferencePoint
]
