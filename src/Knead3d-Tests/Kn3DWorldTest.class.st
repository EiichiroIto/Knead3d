"
A Kn3DWorldTest is a test class for testing the behavior of Kn3DWorld
"
Class {
	#name : #Kn3DWorldTest,
	#superclass : #TestCase,
	#category : #'Knead3d-Tests'
}

{ #category : #private }
Kn3DWorldTest >> buildObject: aWorld [
	aWorld
		polygonAbsolute:
			{(aWorld newVecX: 0.5 y: 0.8 z: -0.2).
			(aWorld newVecX: 0.8 y: 0.5 z: -0.2).
			(aWorld newVecX: 0.8 y: 0.5 z: -0.8).
			(aWorld newVecX: 0.5 y: 0.8 z: -0.8)}.
	aWorld
		moveToAbs: (aWorld newVecX: 0.5 y: 0.8 z: -0.2);
		lineToAbs: (aWorld newVecX: 0.2 y: 0.5 z: -0.2)
]

{ #category : #private }
Kn3DWorldTest >> newDisplay [
	^ KnDummyDisplay new
]

{ #category : #private }
Kn3DWorldTest >> newParam [
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
Kn3DWorldTest >> newVecX: x y: y z: z [
	^ KnVec4 x: x y: y z: z
]

{ #category : #private }
Kn3DWorldTest >> newWorld [
	^ Kn3DWorld new
		yourself
]

{ #category : #test }
Kn3DWorldTest >> testClipping [
	| w |
	w := self newWorld.
	self assert: (w clipping isKindOf: KnClippingContext).
	w clipping: nil.
	self assert: w clipping isNil
]

{ #category : #test }
Kn3DWorldTest >> testDfPen [
	| w v |
	w := self newWorld.
	self assert: w dfPen isNil.
	v := KnVec4 x: 0 y: 1 z: 2.
	w dfPen: v.
	self assert: w dfPen equals: v
]

{ #category : #test }
Kn3DWorldTest >> testDisplayFile [
	| w |
	w := self newWorld.
	self assert: w displayFile isNil.
	w displayFile: #(1 2 3).
	self assert: w displayFile equals: #(1 2 3)
]

{ #category : #test }
Kn3DWorldTest >> testGetViewDistance [
	self testSetViewDistance
]

{ #category : #test }
Kn3DWorldTest >> testGetViewPlaneNormal [
	self testSetViewPlaneNormal
]

{ #category : #test }
Kn3DWorldTest >> testGetViewReferencePoint [
	self testSetViewReferencePoint
]

{ #category : #test }
Kn3DWorldTest >> testGetWindowCenter [
	| c |
	c := self newWorld.
	c parameter window: #(-0.5 0.5 -0.3 0.7).
	self assert: c getWindowCenter x closeTo: 0.
	self assert: c getWindowCenter y closeTo: 0.2.
	c setWindowCenter: 0 @ 0.
	self assert: c parameter window first closeTo: -0.5.
	self assert: c parameter window second closeTo: 0.5.
	self assert: c parameter window third closeTo: -0.5.
	self assert: c parameter window fourth closeTo: 0.5
]

{ #category : #test }
Kn3DWorldTest >> testLineToAbs [
	| w |
	w := self newWorld.
	w parameter: self newParam.
	w setParallel: (self newVecX: 0 y: 0 z: 1).
	w newView.
	self assert: w dfPen isNil.
	w lineToAbs: (self newVecX: 1 y: 2 z: -3).
	self assert: w dfPen x equals: 1.
	self assert: w dfPen y equals: 2.
	self assert: w dfPen z equals: -3.
	w lineToAbs: (self newVecX: 4 y: 5 z: -6).
	self assert: w dfPen x equals: 4.
	self assert: w dfPen y equals: 5.
	self assert: w dfPen z equals: -6
]

{ #category : #test }
Kn3DWorldTest >> testLineToRel [
	| w |
	w := self newWorld.
	w parameter: self newParam.
	w setParallel: (self newVecX: 0 y: 0 z: 1).
	w newView.
	self assert: w dfPen isNil.
	w lineToRel: (self newVecX: 1 y: 2 z: 3).
	self assert: w dfPen x equals: 1.
	self assert: w dfPen y equals: 2.
	self assert: w dfPen z equals: 3.
	w lineToRel: (self newVecX: 4 y: 5 z: 6).
	self assert: w dfPen x equals: 5.
	self assert: w dfPen y equals: 7.
	self assert: w dfPen z equals: 9
]

{ #category : #test }
Kn3DWorldTest >> testMoveToAbs [
	| w |
	w := self newWorld.
	w parameter: self newParam.
	w setParallel: (self newVecX: 0 y: 0 z: 1).
	w newView.
	self assert: w dfPen isNil.
	w moveToAbs: (self newVecX: 1 y: 2 z: 3).
	self assert: w dfPen x equals: 1.
	self assert: w dfPen y equals: 2.
	self assert: w dfPen z equals: 3.
	w moveToAbs: (self newVecX: 4 y: 5 z: 6).
	self assert: w dfPen x equals: 4.
	self assert: w dfPen y equals: 5.
	self assert: w dfPen z equals: 6
]

{ #category : #test }
Kn3DWorldTest >> testMoveToRel [
	| w |
	w := self newWorld.
	w parameter: self newParam.
	w setParallel: (self newVecX: 0 y: 0 z: 1).
	w newView.
	self assert: w dfPen isNil.
	w moveToRel: (self newVecX: 1 y: 2 z: 3).
	self assert: w dfPen x equals: 1.
	self assert: w dfPen y equals: 2.
	self assert: w dfPen z equals: 3.
	w moveToRel: (self newVecX: 4 y: 5 z: 6).
	self assert: w dfPen x equals: 5.
	self assert: w dfPen y equals: 7.
	self assert: w dfPen z equals: 9
]

{ #category : #test }
Kn3DWorldTest >> testNewClipping [
	| w |
	w := self newWorld.
	self assert: (w newClipping isKindOf: KnClippingContext)
]

{ #category : #test }
Kn3DWorldTest >> testNewParam [
	| w |
	w := self newWorld.
	self assert: (w newParam isKindOf: KnViewingParameter)
]

{ #category : #test }
Kn3DWorldTest >> testNewTransformation [
	| w |
	w := self newWorld.
	self assert: (w newTransformation isKindOf: KnTransformation)
]

{ #category : #test }
Kn3DWorldTest >> testNewVecXYZ [
	| w v |
	w := self newWorld.
	v := w newVecX: 1 y: 2 z: 3.
	self assert: (v isKindOf: KnVec4).
	self assert: v x equals: 1.
	self assert: v y equals: 2.
	self assert: v z equals: 3.
	self assert: v w equals: 0
]

{ #category : #test }
Kn3DWorldTest >> testParameter [
	| w p |
	w := self newWorld.
	self assert: (w parameter isKindOf: KnViewingParameter).
	p := self newParam.
	w parameter: p.
	self assert: w parameter equals: p
]

{ #category : #test }
Kn3DWorldTest >> testPolygonAbsolute [
	| w list |
	w := self newWorld.
	w parameter: self newParam.
	w setParallel: (self newVecX: 0 y: 0 z: 1).
	w newView.
	list := {(self newVecX: 1 y: 2 z: 3).
	(self newVecX: 3 y: 5 z: 6)}.
	self should: [ w polygonAbsolute: list ] raise: Error.
	w dfPen: (self newVecX: 0 y: 0 z: 0).
	self buildObject: w.
	self assert: w dfPen x closeTo: 0.2.
	self assert: w dfPen y closeTo: 0.5.
	self assert: w dfPen z closeTo: -0.2.
	self assert: w displayFile size equals: 7
]

{ #category : #test }
Kn3DWorldTest >> testPolygonRelative [
	| w list |
	w := self newWorld.
	w parameter: self newParam.
	w setParallel: (self newVecX: 0 y: 0 z: 1).
	w newView.
	list := {(self newVecX: 1 y: 2 z: 3).
	(self newVecX: 3 y: 5 z: 6)}.
	self should: [ w polygonRelative: list ] raise: Error.
	list := {(self newVecX: 1 y: 2 z: 3).
	(self newVecX: 3 y: 5 z: 6).
	(self newVecX: 7 y: 8 z: 9)}.
	w dfPen: (self newVecX: 0 y: 0 z: 0).
	w polygonRelative: list
]

{ #category : #test }
Kn3DWorldTest >> testProjection [
	| w |
	w := self newWorld.
	self assert: w projection isNil.
	w setParallel: (self newVecX: 0 y: 0 z: 1).
	self assert: (w projection isKindOf: KnParallelTransform).
	w setPerspective: (self newVecX: 0 y: 0 z: 1).
	self assert: (w projection isKindOf: KnPerspectiveTransform)
]

{ #category : #test }
Kn3DWorldTest >> testSetBackClipping [
	| w |
	w := self newWorld.
	w setBackClipping: 10.
	self assert: w parameter backDistance equals: 10.
	w setBackClipping: nil.
	self assert: w parameter backDistance isNil
]

{ #category : #test }
Kn3DWorldTest >> testSetFrontClipping [
	| w |
	w := self newWorld.
	w setFrontClipping: 10.
	self assert: w parameter frontDistance equals: 10.
	w setFrontClipping: nil.
	self assert: w parameter frontDistance isNil
]

{ #category : #test }
Kn3DWorldTest >> testSetParallel [
	| w v |
	w := self newWorld.
	v := self newVecX: 0 y: 0 z: 0.
	self should: [ w setParallel: v ] raise: Error.
	v := self newVecX: 1 y: 2 z: 3.
	w setParallel: v.
	self assert: w projection direction equals: v
]

{ #category : #test }
Kn3DWorldTest >> testSetPerspective [
	| w v |
	w := self newWorld.
	v := self newVecX: 1 y: 2 z: 3.
	w setPerspective: v.
	self assert: w projection center equals: v
]

{ #category : #test }
Kn3DWorldTest >> testSetViewDistance [
	| w |
	w := self newWorld.
	w setViewDistance: 10.
	self assert: w getViewDistance equals: 10.
	w setViewDistance: 20.
	self assert: w getViewDistance equals: 20
]

{ #category : #test }
Kn3DWorldTest >> testSetViewPlaneNormal [
	| w v |
	w := self newWorld.
	v := self newVecX: 1 y: 2 z: 3.
	w setViewPlaneNormal: v.
	self
		assert: w getViewPlaneNormal
		equals: (self newVecX: 1 / 14 sqrt y: 2 / 14 sqrt z: 3 / 14 sqrt)
]

{ #category : #test }
Kn3DWorldTest >> testSetViewReferencePoint [
	| w v |
	w := self newWorld.
	v := self newVecX: 1 y: 2 z: 3.
	w setViewReferencePoint: v.
	self
		assert: w getViewReferencePoint
		equals: (self newVecX: 1 y: 2 z: 3)
]

{ #category : #test }
Kn3DWorldTest >> testSetWindowCenter [
	self testGetWindowCenter
]

{ #category : #test }
Kn3DWorldTest >> testTransformation [
	| w |
	w := self newWorld.
	self assert: w transformation isNil.
	w transformation: w newTransformation.
	self assert: (w transformation isKindOf: KnTransformation)
]
