"
A Kn3DObjectBuilderTest is a test class for testing the behavior of Kn3DObjectBuilder
"
Class {
	#name : #Kn3DObjectBuilderTest,
	#superclass : #TestCase,
	#category : #'Knead3d-Tests'
}

{ #category : #private }
Kn3DObjectBuilderTest >> newBuilder [
	^ Kn3DObjectBuilder new
]

{ #category : #private }
Kn3DObjectBuilderTest >> newParam [
	^ KnViewingParameter new
		viewReferencePoint: (self newVecX: 0 y: 0 z: 0);
		viewPlaneNormal: (self newVecX: 0 y: 0 z: -1);
		viewDistance: 0;
		viewUp: (self newVecX: 0 y: 1 z: 0);
		frontDistance: nil;
		backDistance: nil;
		window: #(0 1 0 1);
		viewport: #(0 100 0 100);
		yourself
]

{ #category : #private }
Kn3DObjectBuilderTest >> newVecX: x y: y z: z [
	^ KnVec4 x: x y: y z: z
]

{ #category : #private }
Kn3DObjectBuilderTest >> newWorld [
	^ Kn3DWorld new
]

{ #category : #test }
Kn3DObjectBuilderTest >> testAddEndTo [
	| b |
	b := self newBuilder.
	self assert: b objects isEmpty.
	b
		addEndTo:
			{(self newVecX: 1 y: 2 z: 3).
			(self newVecX: 4 y: 5 z: 6)}.
	self assert: b objects size equals: 1.
	self assert: b objects first isEnd.
	self assert: b objects first points size equals: 2.
	self
		assertCollection: b objects first points
		equals:
			{(self newVecX: 1 y: 2 z: 3).
			(self newVecX: 4 y: 5 z: 6)}
]

{ #category : #test }
Kn3DObjectBuilderTest >> testAddLineTo [
	| b |
	b := self newBuilder.
	self assert: b objects isEmpty.
	b addLineTo: (self newVecX: 1 y: 2 z: 3).
	self assert: b objects size equals: 1.
	self assert: b objects first isLine.
	self
		assertCollection: b objects first points
		equals: (self newVecX: 1 y: 2 z: 3)
]

{ #category : #test }
Kn3DObjectBuilderTest >> testAddMoveTo [
	| b |
	b := self newBuilder.
	self assert: b objects isEmpty.
	b addMoveTo: (self newVecX: 1 y: 2 z: 3).
	self assert: b objects size equals: 1.
	self assert: b objects first isMove.
	self
		assertCollection: b objects first points
		equals: (self newVecX: 1 y: 2 z: 3)
]

{ #category : #test }
Kn3DObjectBuilderTest >> testAddSideTo [
	| b |
	b := self newBuilder.
	self assert: b objects isEmpty.
	b
		addSideTo:
			{(self newVecX: 1 y: 2 z: 3).
			(self newVecX: 4 y: 5 z: 6)}.
	self assert: b objects size equals: 1.
	self assert: b objects first isSide.
	self assert: b objects first points size equals: 2.
	self
		assertCollection: b objects first points
		equals:
			{(self newVecX: 1 y: 2 z: 3).
			(self newVecX: 4 y: 5 z: 6)}
]

{ #category : #test }
Kn3DObjectBuilderTest >> testAddStartTo [
	| b |
	b := self newBuilder.
	self assert: b objects isEmpty.
	b
		addStartTo:
			{(self newVecX: 1 y: 2 z: 3).
			(self newVecX: 4 y: 5 z: 6)}.
	self assert: b objects size equals: 1.
	self assert: b objects first isStart.
	self assert: b objects first points size equals: 2.
	self
		assertCollection: b objects first points
		equals:
			{(self newVecX: 1 y: 2 z: 3).
			(self newVecX: 4 y: 5 z: 6)}
]

{ #category : #test }
Kn3DObjectBuilderTest >> testArrangePoints [
	| b ret |
	b := self newBuilder.
	ret := b
		arrangePoints:
			{(self newVecX: 0 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 0)}.
	self
		assertCollection: ret
		equals:
			{(self newVecX: 0 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 0).
			(self newVecX: 0 y: 0 z: 1)}.
	b := self newBuilder.
	ret := b
		arrangePoints:
			{(self newVecX: 0 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 0).
			(self newVecX: 1 y: 0 z: 0).
			(self newVecX: 0 y: 0 z: 1)}.
	self
		assertCollection: ret
		equals:
			{(self newVecX: 0 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 0).
			(self newVecX: 0 y: 0 z: 1)}.
	b := self newBuilder.
	ret := b
		arrangePoints:
			{(self newVecX: 0 y: 0 z: 1).
			(self newVecX: 0.5 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 0.5).
			(self newVecX: 1 y: 0 z: 0).
			(self newVecX: 0 y: 0 z: 1)}.
	self
		assertCollection: ret
		equals:
			{(self newVecX: 0 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 0).
			(self newVecX: 0 y: 0 z: 1)}
]

{ #category : #test }
Kn3DObjectBuilderTest >> testBaryCenterOf [
	| b v |
	b := self newBuilder.
	v := b
		baryCenterOf:
			{(self newVecX: 1 y: 0 z: 0).
			(self newVecX: 1 y: 0 z: 1).
			(self newVecX: 0 y: 0 z: 1).
			(self newVecX: 0 y: 0 z: 0)}.
	self assert: v equals: (self newVecX: 0.5 y: 0 z: 0.5)
]

{ #category : #test }
Kn3DObjectBuilderTest >> testBuildAxesObject [
	| b w |
	b := self newBuilder.
	w := self newWorld.
	w parameter: self newParam.
	w setParallel: (self newVecX: 0 y: 0 z: 1).
	w newView.
	self assert: w displayFile isEmpty.
	b buildAxesObject: w.
	self assert: w displayFile size equals: 9
]

{ #category : #test }
Kn3DObjectBuilderTest >> testBuildObject [
	| b w |
	b := self newBuilder.
	b moveX: 1 y: 2 z: 3.
	b directionX: 1 y: 0 z: 0.
	b forward: 2.
	w := self newWorld.
	w parameter: self newParam.
	w setParallel: (self newVecX: 0 y: 0 z: 1).
	w newView.
	self assert: w displayFile isEmpty.
	b buildObject: w.
	self assert: w displayFile size equals: 3
]

{ #category : #test }
Kn3DObjectBuilderTest >> testBuildPenObject [
	| b w |
	b := self newBuilder.
	w := self newWorld.
	w parameter: self newParam.
	w setParallel: (self newVecX: 0 y: 0 z: 1).
	w newView.
	self assert: w displayFile isEmpty.
	b buildPenObject: w.
	self assert: w displayFile size equals: 2
]

{ #category : #test }
Kn3DObjectBuilderTest >> testCalcFaceTo [
	| b f |
	b := self newBuilder.
	b moveX: 0 y: 0 z: 0.
	b directionX: 0 y: 0 z: 1.
	b forward: 1.
	b rotate: 120.
	b forward: 1.
	b rotate: 120.
	b forward: 1.
	f := b calcFaceTo: (self newVecX: 0 y: 1 z: 0).
	self assert: f < 0.
	b := self newBuilder.
	b moveX: 0 y: 0 z: 0.
	b directionX: 0 y: 0 z: 1.
	b forward: 1.
	b rotate: 120.
	b forward: 1.
	b rotate: 120.
	b forward: 1.
	f := b calcFaceTo: (self newVecX: 0 y: -1 z: 0).
	self assert: f > 0
]

{ #category : #test }
Kn3DObjectBuilderTest >> testCalcNormal [
	| b n |
	b := self newBuilder.
	b moveX: 0 y: 0 z: 0.
	self assert: b calcNormal isNil.
	b directionX: 0 y: 0 z: 1.
	b forward: 1.
	self assert: b calcNormal isNil.
	b rotate: 120.
	b forward: 1.
	n := b calcNormal.
	self assert: n isZero not.
	b := self newBuilder.
	b moveX: 0 y: 0 z: 0.
	self assert: b calcNormal isNil.
	b directionX: 0 y: 0 z: 1.
	b forward: 1.
	self assert: b calcNormal isNil.
	b rotate: -120.
	b forward: 1.
	n := b calcNormal.
	self assert: n isZero not
]

{ #category : #test }
Kn3DObjectBuilderTest >> testCalcNormalOf [
	| b v |
	b := self newBuilder.
	b privAddPoint: (self newVecX: 1 y: 2 z: 3).
	b privAddPoint: (self newVecX: 1 y: 2 z: 4).
	b privAddPoint: (self newVecX: 1 y: 3 z: 3).
	v := b calcNormalOf: b points.
	self assert: v equals: (self newVecX: -1 y: 0 z: 0).
	b := self newBuilder.
	b privAddPoint: (self newVecX: 1 y: 2 z: 3).
	self assert: (b calcNormalOf: b points) isNil.
	b := self newBuilder.
	b privAddPoint: (self newVecX: 1 y: 2 z: 3).
	b privAddPoint: (self newVecX: 1 y: 2 z: 4).
	self assert: (b calcNormalOf: b points) isNil
]

{ #category : #test }
Kn3DObjectBuilderTest >> testClear [
	| b |
	b := self newBuilder.
	self assert: b pen isZero.
	self assert: b direction equals: (self newVecX: 1 y: 0 z: 0).
	self assert: b subDirection equals: (self newVecX: 0 y: 0 z: 1).
	self assert: b isPenDown.
	self assert: b points isEmpty.
	self assert: b objects isEmpty.
	self deny: b hasPolygon
]

{ #category : #test }
Kn3DObjectBuilderTest >> testClearNormal [
	| b |
	b := self newBuilder.
	self assert: b normal isNil.
	b privAddPoint: (self newVecX: 1 y: 2 z: 3).
	b privAddPoint: (self newVecX: 3 y: 4 z: 5).
	b privAddPoint: (self newVecX: 6 y: 7 z: 9).
	self assert: b normal notNil.
	b clearPoints.
	self assert: b normal isNil
]

{ #category : #test }
Kn3DObjectBuilderTest >> testClearObjects [
	| b |
	b := self newBuilder.
	self assert: b objects isEmpty.
	b addMoveTo: (self newVecX: 1 y: 2 z: 3).
	self assert: b objects notEmpty.
	b clearObjects.
	self assert: b objects isEmpty
]

{ #category : #test }
Kn3DObjectBuilderTest >> testClearPoints [
	| b |
	b := self newBuilder.
	self assert: b points isEmpty.
	b privAddPoint: (self newVecX: 1 y: 2 z: 3).
	b privAddPoint: (self newVecX: 3 y: 4 z: 5).
	b privAddPoint: (self newVecX: 6 y: 7 z: 9).
	self assert: b points notEmpty.
	b clearPoints.
	self assert: b points isEmpty
]

{ #category : #test }
Kn3DObjectBuilderTest >> testDetach [
	| b |
	b := self newBuilder.
	b privAddPoint: (self newVecX: 0 y: 0 z: 1).
	b privAddPoint: (self newVecX: 1 y: 0 z: 1).
	b privAddPoint: (self newVecX: 1 y: 0 z: 0).
	b hasPolygon: true.
	b detach.
	self assert: b points isEmpty.
	self assert: b normal isNil.
	self deny: b hasPolygon
]

{ #category : #test }
Kn3DObjectBuilderTest >> testDirection [
	| b |
	b := self newBuilder.
	b subDirection: (KnVec4 x: 0 y: 0 z: 1).
	self assert: b direction equals: (KnVec4 x: 1 y: 0 z: 0).
	b direction: (KnVec4 x: 1 y: 2 z: 3).
	self assert: b subDirection equals: (KnVec4 x: 0 y: 0 z: 1).
	self assert: b direction equals: (KnVec4 x: 1/14 sqrt y: 2/14 sqrt z: 3/14 sqrt).
	b direction: (KnVec4 x: 4 y: 5 z: 6).
	self assert: b subDirection equals: (KnVec4 x: 0 y: 0 z: 1).
	self assert: b direction equals: (KnVec4 x: 4/77 sqrt y: 5/77 sqrt z: 6/77 sqrt).
	b direction: (KnVec4 x: 1 y: 0 z: 0).
	self assert: b direction equals: (KnVec4 x: 1 y: 0 z: 0).
	self assert: b subDirection equals: (KnVec4 x: 0 y: 0 z: 1).
	b direction: (KnVec4 x: 0 y: 0 z: 1).
	self assert: b direction equals: (KnVec4 x: 0 y: 0 z: 1).
	self assert: b subDirection equals: (KnVec4 x: -1 y: 0 z: 0).
	self assert: (b direction isOrthogonalTo: b subDirection)
]

{ #category : #test }
Kn3DObjectBuilderTest >> testDirectionXYZ [
	| b |
	b := self newBuilder.
	self assert: b direction equals: (self newVecX: 1 y: 0 z: 0).
	b directionX: 1 y: 2 z: 3.
	self assert: b direction equals: (self newVecX: 1/14 sqrt y: 2/14 sqrt z: 3/14 sqrt)
]

{ #category : #test }
Kn3DObjectBuilderTest >> testForward [
	| b |
	b := self newBuilder.
	b moveX: 1 y: 2 z: 3.
	b directionX: 1 y: 0 z: 0.
	b forward: 2.
	b forward: 1.
	b forward: 3.
	b forward: 4.
	self assert: b objects size equals: 6.
	b := self newBuilder.
	b moveX: 0 y: 0 z: 0.
	b direction: (KnVec4 x: 0 y: 1 z: 1).
	b forward: 1.
	b rotate: 120.
	b forward: 1.
	b rotate: 120.
	b forward: 1.
	b rotate: 120.
	self assert: b direction closeTo: (KnVec4 x: 0 y: 1 z: 1) normalized.
	b forward: 1.
	self assert: b pen closeTo: (KnVec4 x: 0 y: 1 z: 1) normalized.
	b := self newBuilder.
	b moveX: 0 y: 0 z: 0.
	b direction: (KnVec4 x: 0 y: 0 z: 1).
	b forward: 1.
	b rotate: 120.
	b forward: 1.
	b rotate: 120.
	b forward: 1.
	b rotate: 120.
	self assert: b direction closeTo: (KnVec4 x: 0 y: 0 z: 1) normalized.
	self assert: b pen closeTo: (KnVec4 x: 0 y: 0 z: 0).
	self assert: b objects size equals: 4
]

{ #category : #test }
Kn3DObjectBuilderTest >> testHasPoints [
	| b |
	b := self newBuilder.
	self deny: b hasPoints.
	b privAddPoint: (self newVecX: 1 y: 2 z: 3).
	self assert: b hasPoints.
	b clearPoints.
	self deny: b hasPoints
]

{ #category : #test }
Kn3DObjectBuilderTest >> testHasPolygon [
	| b |
	b := self newBuilder.
	self deny: b hasPolygon.
	b privAddPoint: (self newVecX: 1 y: 2 z: 3).
	b privAddPoint: (self newVecX: 3 y: 4 z: 5).
	b privAddPoint: (self newVecX: 6 y: 7 z: 9).
	b makePolygon: (self newVecX: 0 y: 0 z: 10).
	self assert: b hasPolygon.
]

{ #category : #test }
Kn3DObjectBuilderTest >> testHeading [
	| b |
	b := self newBuilder.
	self assert: b heading equals: 0.
	b heading: 123.
	self assert: b heading equals: 123.
	b heading: 370.
	self assert: b heading equals: 10.
	b heading: -10.
	self assert: b heading equals: 350
]

{ #category : #test }
Kn3DObjectBuilderTest >> testInitialize [
	self testClear
]

{ #category : #test }
Kn3DObjectBuilderTest >> testIsCoplanarPointsWith [
	| b v |
	b := self newBuilder.
	b privAddPoint: (self newVecX: 1 y: 2 z: 3).
	b privAddPoint: (self newVecX: 2 y: 5 z: 3).
	b privAddPoint: (self newVecX: 3 y: 9 z: 3).
	v := self newVecX: -1 y: -4 z: 3.
	self assert: (b isCoplanarPointsWith: v).
	v := self newVecX: -1 y: -4 z: 4.
	self deny: (b isCoplanarPointsWith: v).
	b := self newBuilder.
	b privAddPoint: (self newVecX: 1 y: 2 z: 3).
	b privAddPoint: (self newVecX: 2 y: 4 z: 3).
	b privAddPoint: (self newVecX: 3 y: 6 z: 3).
	v := self newVecX: -1 y: -4 z: 4.
	self assert: (b isCoplanarPointsWith: v)
]

{ #category : #test }
Kn3DObjectBuilderTest >> testIsPenDown [
	| b |
	b := self newBuilder.
	self assert: b isPenDown.
	b isPenDown: false.
	self deny: b isPenDown.
	b isPenDown: true.
	self assert: b isPenDown
]

{ #category : #test }
Kn3DObjectBuilderTest >> testLastStart [
	| b ret |
	b := self newBuilder.
	b addStartTo: { (self newVecX: 1 y: 2 z: 3) }.
	b addSideTo: { (self newVecX: 1 y: 2 z: 3) }.
	b addEndTo: { (self newVecX: 1 y: 2 z: 3) }.
	b addStartTo: { (self newVecX: 4 y: 5 z: 6) }.
	b addSideTo: { (self newVecX: 4 y: 5 z: 6) }.
	self assert: b lastStart isNil.
	b := self newBuilder.
	b addStartTo: { (self newVecX: 1 y: 2 z: 3) }.
	b addSideTo: { (self newVecX: 1 y: 2 z: 3) }.
	b addEndTo: { (self newVecX: 1 y: 2 z: 3) }.
	b addStartTo: { (self newVecX: 4 y: 5 z: 6) }.
	b addMoveTo: (self newVecX: 1 y: 2 z: 3).
	b addLineTo: (self newVecX: 1 y: 2 z: 3).
	ret := b lastStart.
	self assert: (b objects indexOf: ret) equals: 4
]

{ #category : #test }
Kn3DObjectBuilderTest >> testMagnification [
	| b |
	b := self newBuilder.
	self assert: b magnification isNumber
]

{ #category : #test }
Kn3DObjectBuilderTest >> testMakePolygon [
	| b |
	b := self newBuilder.
	b privAddPoint: (self newVecX: 0 y: 0 z: 1).
	b privAddPoint: (self newVecX: 1 y: 0 z: 1).
	b privAddPoint: (self newVecX: 1 y: 0 z: 0).
	self deny: b hasPolygon.
	b makePolygon: (self newVecX: 0 y: -1 z: 0).
	self assert: b hasPolygon.
	self
		assertCollection: b points
		equals:
			{(self newVecX: 0 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 0).
			(self newVecX: 0 y: 0 z: 1)}
]

{ #category : #test }
Kn3DObjectBuilderTest >> testMold [
	| b |
	b := self newBuilder.
	b
		addStartTo:
			{(self newVecX: 0 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 0)}.
	b
		points:
			{(self newVecX: 0 y: 1 z: 1).
			(self newVecX: 1 y: 1 z: 1).
			(self newVecX: 1 y: 1 z: 0).
			(self newVecX: 0 y: 1 z: 1)}.
	b hasPolygon: true.
	b mold.
	self assert: b objects size equals: 5.
	self assert: b objects first isStart.
	self assert: b objects second isSide.
	self assert: b objects third isSide.
	self assert: b objects fourth isSide.
	self assert: b objects fifth isEnd.
	b
		points:
			{(self newVecX: 0 y: 2 z: 1).
			(self newVecX: 1 y: 2 z: 1).
			(self newVecX: 1 y: 2 z: 0).
			(self newVecX: 0 y: 2 z: 0).
			(self newVecX: 0 y: 2 z: 1)}.
	b mold.
	self assert: b objects size equals: 9
]

{ #category : #test }
Kn3DObjectBuilderTest >> testNewVecXYZ [
	| b v |
	b := self newBuilder.
	v := b newVecX: 1 y: 2 z: 3.
	self assert: v equals: (self newVecX: 1 y: 2 z: 3)
]

{ #category : #test }
Kn3DObjectBuilderTest >> testNormal [
	| b |
	b := self newBuilder.
	self assert: b normal isNil.
	b normal: (KnVec4 x: 1 y: 2 z: 3).
	self assert: b normal equals: (KnVec4 x: 1/14 sqrt y: 2/14 sqrt z: 3/14 sqrt).
	b normal: (KnVec4 x: 4 y: 5 z: 6).
	self assert: b normal equals: (KnVec4 x: 4/77 sqrt y: 5/77 sqrt z: 6/77 sqrt)
]

{ #category : #test }
Kn3DObjectBuilderTest >> testObjects [
	| b |
	b := self newBuilder.
	self assert: b objects isCollection.
	self assert: b objects isEmpty.
	b addMoveTo: (self newVecX: 1 y: 2 z: 3).
	self assert: b objects size equals: 1
]

{ #category : #test }
Kn3DObjectBuilderTest >> testPen [
	| b |
	b := self newBuilder.
	self assert: b pen isZero.
	b pen: (KnVec4 x: 1 y: 2 z: 3).
	self assert: b pen equals: (KnVec4 x: 1 y: 2 z: 3).
	b pen: (KnVec4 x: 4 y: 5 z: 6).
	self assert: b pen equals: (KnVec4 x: 4 y: 5 z: 6)
]

{ #category : #test }
Kn3DObjectBuilderTest >> testPenDirection [
	| b v |
	b := self newBuilder.
	b direction: (self newVecX: 0 y: 1 z: 1).
	b heading: 0.
	self assert: b penDirection closeTo: (self newVecX: 0 y: 1 z: 1) normalized.
	b direction: (self newVecX: 0 y: 1 z: 0).
	b heading: 0.
	self assert: b penDirection closeTo: (self newVecX: 0 y: 1 z: 0) normalized.
	b direction: (self newVecX: 1 y: 1 z: 0).
	b heading: 0.
	self assert: b penDirection closeTo: (self newVecX: 1 y: 1 z: 0) normalized.
	b direction: (self newVecX: 1 y: 1 z: 1).
	b heading: 0.
	self assert: b penDirection closeTo: (self newVecX: 1 y: 1 z: 1) normalized.
	b direction: (self newVecX: 0 y: 1 z: 0).
	b subDirection: (self newVecX: 1 y: 0 z: 1).
	b heading: 0.
	self assert: b penDirection closeTo: (self newVecX: 0 y: 1 z: 0) normalized.

	b := self newBuilder.
	b direction: (self newVecX: 0 y: 1 z: 1).
	b heading: 180.
	self assert: b penDirection closeTo: (self newVecX: 0 y: 1 z: 1) normalized negated.
	b direction: (self newVecX: 0 y: 1 z: 0).
	b heading: 180.
	self assert: b penDirection closeTo: (self newVecX: 0 y: 1 z: 0) normalized negated.
	b direction: (self newVecX: 1 y: 1 z: 0).
	b heading: 180.
	self assert: b penDirection closeTo: (self newVecX: 1 y: 1 z: 0) normalized negated.
	b direction: (self newVecX: 1 y: 1 z: 1).
	b heading: 180.
	self assert: b penDirection closeTo: (self newVecX: 1 y: 1 z: 1) normalized negated.
	b direction: (self newVecX: 0 y: 1 z: 0).
	b subDirection: (self newVecX: 1 y: 0 z: 1).
	b heading: -45.
	self assert: b penDirection closeTo: (self newVecX: -1 y: 2 sqrt z: 1) normalized.
	b := self newBuilder.
	b direction: (self newVecX: 0 y: 0 z: 1).
	b heading: 0.
	v := b penDirectionParallelToYAxis.
	self assert: v equals: (self newVecX: 0 y: 0 z: 1).
	b heading: -90.
	v := b penDirectionParallelToYAxis.
	self assert: v closeTo: (self newVecX: 1 y: 0 z: 0).
	b heading: 180.
	v := b penDirectionParallelToYAxis.
	self assert: v closeTo: (self newVecX: 0 y: 0 z: -1).
	b heading: 90.
	v := b penDirectionParallelToYAxis.
	self assert: v closeTo: (self newVecX: -1 y: 0 z: 0).
	b direction: (self newVecX: 0 y: 1 z: 1).
	b heading: 180.
	v := b penDirectionParallelToYAxis.
	self assert: v closeTo: (self newVecX: 0 y: 1 z: 1) normalized negated
]

{ #category : #test }
Kn3DObjectBuilderTest >> testPenDirectionOrthogonalToZAxis [
	| b v |
	b := self newBuilder.
	b direction: (self newVecX: 1 y: 0 z: 0).
	b heading: 0.
	v := b penDirectionOrthogonalToZAxis.
	self assert: v equals: (self newVecX: 1 y: 0 z: 0).
	b heading: 90.
	v := b penDirectionOrthogonalToZAxis.
	self assert: v closeTo: (self newVecX: 0 y: 0 z: 1).
	b heading: 180.
	v := b penDirectionOrthogonalToZAxis.
	self assert: v closeTo: (self newVecX: -1 y: 0 z: 0).
	b heading: 270.
	v := b penDirectionOrthogonalToZAxis.
	self assert: v closeTo: (self newVecX: 0 y: 0 z: -1).
	b direction: (self newVecX: 1 y: 1 z: 0).
	b heading: 180.
	v := b penDirectionOrthogonalToZAxis.
	self assert: v closeTo: (self newVecX: 1 y: 1 z: 0) normalized negated
]

{ #category : #test }
Kn3DObjectBuilderTest >> testPenDirectionParallelToYAxis [
	| b |
	b := self newBuilder.
	b direction: (self newVecX: 0 y: 1 z: 0).
	b heading: 0.
	self
		assert: b penDirectionParallelToYAxis
		closeTo: (self newVecX: 0 y: 1 z: 0) normalized.
	b direction: (self newVecX: 0 y: 1 z: 0).
	b heading: 180.
	self
		assert: b penDirectionParallelToYAxis
		closeTo: (self newVecX: 0 y: 1 z: 0) normalized negated.
	b direction: (self newVecX: 0 y: 1 z: 0).
	b subDirection: (self newVecX: 1 y: 0 z: 1).
	b heading: 0.
	self
		assert: b penDirectionParallelToYAxis
		closeTo: (self newVecX: 0 y: 1 z: 0) normalized.
	b direction: (self newVecX: 0 y: 1 z: 0).
	b subDirection: (self newVecX: 1 y: 0 z: 1).
	b heading: -45.
	self
		assert: b penDirectionParallelToYAxis
		closeTo: (self newVecX: -1 y: 2 sqrt z: 1) normalized
]

{ #category : #test }
Kn3DObjectBuilderTest >> testPoints [
	| b |
	b := self newBuilder.
	self assert: b points isEmpty.
	b
		points:
			{(self newVecX: 1 y: 2 z: 3).
			(self newVecX: 3 y: 4 z: 5)}.
	self assert: b points size equals: 2.
	self assert: b points first equals: (self newVecX: 1 y: 2 z: 3).
	self assert: b points second equals: (self newVecX: 3 y: 4 z: 5)
]

{ #category : #test }
Kn3DObjectBuilderTest >> testPrivAddPoint [
	| b |
	b := self newBuilder.
	self assert: b points isEmpty.
	b privAddPoint: (self newVecX: 1 y: 2 z: 3).
	b privAddPoint: (self newVecX: 3 y: 4 z: 5).
	self assert: b points size equals: 2.
	self assert: b points first equals: (self newVecX: 1 y: 2 z: 3).
	self assert: b points second equals: (self newVecX: 3 y: 4 z: 5)
]

{ #category : #test }
Kn3DObjectBuilderTest >> testPrivMoveTo [
	| b |
	b := self newBuilder.
	b
		points:
			{(self newVecX: 0 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 0).
			(self newVecX: 0 y: 0 z: 1)}.
	b pen: (self newVecX: 0 y: 0 z: 0).
	b privMoveTo: (self newVecX: 0 y: -1 z: 0).
	self assert: b pen equals: (self newVecX: 0 y: -1 z: 0).
	self
		assertCollection: b points
		equals:
			{(self newVecX: 0 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 0).
			(self newVecX: 0 y: 0 z: 1)}.
	b := self newBuilder.
	b
		points:
			{(self newVecX: 0 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 0).
			(self newVecX: 0 y: 0 z: 1)}.
	b pen: (self newVecX: 0 y: 0 z: 0).
	b hasPolygon: true.
	b privMoveTo: (self newVecX: 0 y: -1 z: 0).
	self assert: b pen equals: (self newVecX: 0 y: -1 z: 0).
	self
		assertCollection: b points
		equals:
			{(self newVecX: 0 y: -1 z: 1).
			(self newVecX: 1 y: -1 z: 1).
			(self newVecX: 1 y: -1 z: 0).
			(self newVecX: 0 y: -1 z: 1)}
]

{ #category : #test }
Kn3DObjectBuilderTest >> testRemoveLastEnd [
	| b |
	b := self newBuilder.
	b addStartTo: { (self newVecX: 1 y: 2 z: 3) }.
	b addSideTo: { (self newVecX: 1 y: 2 z: 3) }.
	b addEndTo: { (self newVecX: 1 y: 2 z: 3) }.
	b addStartTo: { (self newVecX: 4 y: 5 z: 6) }.
	b addSideTo: { (self newVecX: 4 y: 5 z: 6) }.
	b addEndTo: { (self newVecX: 4 y: 5 z: 6) }.
	b addSideTo: { (self newVecX: 7 y: 8 z: 9) }.
	b addSideTo: { (self newVecX: 7 y: 8 z: 9) }.
	b removeLastEnd.
	self assert: b objects size equals: 7.
	self assert: b objects third isEnd.
	self assert: b objects sixth isSide.
	self assert: b objects seventh isSide
]

{ #category : #test }
Kn3DObjectBuilderTest >> testRemoveLastStart [
	| b |
	b := self newBuilder.
	b addStartTo: { (self newVecX: 1 y: 2 z: 3) }.
	b addSideTo: { (self newVecX: 1 y: 2 z: 3) }.
	b addEndTo: { (self newVecX: 1 y: 2 z: 3) }.
	b addStartTo: { (self newVecX: 4 y: 5 z: 6) }.
	b addSideTo: { (self newVecX: 4 y: 5 z: 6) }.
	b removeLastStart.
	self assert: b objects size equals: 5.
	b := self newBuilder.
	b addStartTo: { (self newVecX: 1 y: 2 z: 3) }.
	b addSideTo: { (self newVecX: 1 y: 2 z: 3) }.
	b addEndTo: { (self newVecX: 1 y: 2 z: 3) }.
	b addStartTo: { (self newVecX: 4 y: 5 z: 6) }.
	b removeLastStart.
	self assert: b objects size equals: 3.
	self assert: b objects first isStart.
	self assert: b objects second isSide.
	self assert: b objects third isEnd
]

{ #category : #test }
Kn3DObjectBuilderTest >> testRemoveLines [
	| b |
	b := self newBuilder.
	b addStartTo: { (self newVecX: 4 y: 5 z: 6) }.
	b addSideTo: { (self newVecX: 4 y: 5 z: 6) }.
	b addEndTo: { (self newVecX: 4 y: 5 z: 6) }.
	b addMoveTo: (self newVecX: 1 y: 2 z: 3).
	b addLineTo: (self newVecX: 1 y: 2 z: 3).
	b addLineTo: (self newVecX: 1 y: 2 z: 3).
	self assert: b objects size equals: 6.
	b removeLines.
	self assert: b objects size equals: 3.
	self assert: b objects first isStart.
	self assert: b objects second isSide.
	self assert: b objects third isEnd
]

{ #category : #test }
Kn3DObjectBuilderTest >> testReversedPointsOf [
	| b ret |
	b := self newBuilder.
	b privAddPoint: (self newVecX: 1 y: 2 z: 3).
	b privAddPoint: (self newVecX: 4 y: 5 z: 6).
	b privAddPoint: (self newVecX: 7 y: 8 z: 9).
	b privAddPoint: (self newVecX: 10 y: 11 z: 15).
	b privAddPoint: (self newVecX: 1 y: 2 z: 3).
	self assert: b points first equals: (self newVecX: 1 y: 2 z: 3).
	self assert: b points second equals: (self newVecX: 4 y: 5 z: 6).
	self assert: b points third equals: (self newVecX: 7 y: 8 z: 9).
	self assert: b points fourth equals: (self newVecX: 10 y: 11 z: 15).
	self assert: b points fifth equals: (self newVecX: 1 y: 2 z: 3).
	ret := b reversedPointsOf: b points.
	self assert: ret first equals: (self newVecX: 1 y: 2 z: 3).
	self assert: ret second equals: (self newVecX: 10 y: 11 z: 15).
	self assert: ret third equals: (self newVecX: 7 y: 8 z: 9).
	self assert: ret fourth equals: (self newVecX: 4 y: 5 z: 6).
	self assert: ret fifth equals: (self newVecX: 1 y: 2 z: 3)
]

{ #category : #test }
Kn3DObjectBuilderTest >> testRotate [
	| b |
	b := self newBuilder.
	self assert: b heading equals: 0.
	b rotate: 10.
	self assert: b heading equals: 10.
	b rotate: -20.
	self assert: b heading equals: 350
]

{ #category : #test }
Kn3DObjectBuilderTest >> testStamp [
	| b |
	b := self newBuilder.
	b addStartTo: {(self newVecX: 1 y: 2 z: 3)}.
	b addSideTo: {(self newVecX: 1 y: 2 z: 3)}.
	b addEndTo: {(self newVecX: 1 y: 2 z: 3)}.
	b addStartTo: {(self newVecX: 4 y: 5 z: 6)}.
	b addSideTo: {(self newVecX: 4 y: 5 z: 6)}.
	b addEndTo: {(self newVecX: 4 y: 5 z: 6)}.
	b
		points:
			{(self newVecX: 0 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 1)}.
	b hasPolygon: true.
	b stamp.
	self assert: b objects size equals: 7.
	self assert: b objects last isStart.
	self
		assertCollection: b objects last points
		equals:
			{(self newVecX: 0 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 1)}.
	b := self newBuilder.
	b addStartTo: {(self newVecX: 1 y: 2 z: 3)}.
	b addSideTo: {(self newVecX: 1 y: 2 z: 3)}.
	b addEndTo: {(self newVecX: 1 y: 2 z: 3)}.
	b addStartTo: {(self newVecX: 4 y: 5 z: 6)}.
	b
		points:
			{(self newVecX: 0 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 1)}.
	b hasPolygon: true.
	b stamp.
	self assert: b objects size equals: 4.
	self assert: b objects last isStart.
	self
		assertCollection: b objects last points
		equals:
			{(self newVecX: 0 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 1)}
]

{ #category : #test }
Kn3DObjectBuilderTest >> testSubDirection [
	| b |
	b := self newBuilder.
	self assert: b subDirection equals: (self newVecX: 0 y: 0 z: 1).
	b subDirection: (self newVecX: 0 y: 1 z: 0).
	self assert: b subDirection equals: (self newVecX: 0 y: 1 z: 0).
	b subDirection: (self newVecX: 1 y: 0 z: 0).
	self assert: b subDirection equals: (self newVecX: 1 y: 0 z: 0)
]
