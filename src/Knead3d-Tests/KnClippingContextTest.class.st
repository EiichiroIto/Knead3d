"
A KnClippingContextTest is a test class for testing the behavior of KnClippingContext
"
Class {
	#name : #KnClippingContextTest,
	#superclass : #TestCase,
	#category : #'Knead3d-Tests'
}

{ #category : #private }
KnClippingContextTest >> newClipping [
	^ KnClippingContext new
]

{ #category : #private }
KnClippingContextTest >> newDisplay [
	^ KnDummyDisplay new
]

{ #category : #private }
KnClippingContextTest >> newVecX: x y: y z: z [
	^ KnVec4 x: x y: y z: z
]

{ #category : #test }
KnClippingContextTest >> testClipOrigin [
	self testSetupViewport
]

{ #category : #test }
KnClippingContextTest >> testClipValueAt [
	| c |
	c := self newClipping.
	self assert: (c clipValueAt: #front) isNil.
	self assert: (c clipValueAt: #back) isNil.
	c clipValueAt: #front put: 1.
	c clipValueAt: #back put: 2.
	self assert: (c clipValueAt: #front) equals: 1.
	self assert: (c clipValueAt: #back) equals: 2
]

{ #category : #test }
KnClippingContextTest >> testClipValueAtPut [
	self testClipValueAt
]

{ #category : #test }
KnClippingContextTest >> testClipValues [
	| c |
	c := self newClipping.
	self assert: c clipValues isDictionary.
	self assert: c clipValues isEmpty
]

{ #category : #test }
KnClippingContextTest >> testClosing [
	| c |
	c := self newClipping.
	self assert: c closing isNil.
	c closing: #front.
	self assert: c closing equals: #front.
	c closing: #back.
	self assert: c closing equals: #back
	
]

{ #category : #test }
KnClippingContextTest >> testDisplayFile [
	| c |
	c := self newClipping.
	self assert: c displayFile isNil.
	c displayFile: #(1 2 3).
	self assertCollection: c displayFile equals: #(1 2 3).
	c displayFile: #(4 5 6).
	self assertCollection: c displayFile equals: #(4 5 6)
]

{ #category : #test }
KnClippingContextTest >> testFirstOpAt [
	| c |
	c := self newClipping.
	self should: [ c firstOpAt: #back ] raise: Error.
	self should: [ c firstOpAt: #front ] raise: Error.
	c firstOpAt: #back put: 1.
	c firstOpAt: #front put: 2.
	self assert: (c firstOpAt: #back) equals: 1.
	self assert: (c firstOpAt: #front) equals: 2
]

{ #category : #test }
KnClippingContextTest >> testFirstOpAtPut [
	self testFirstOpAt
]

{ #category : #test }
KnClippingContextTest >> testFirstOps [
	| c |
	c := self newClipping.
	self assert: c firstOps isDictionary.
	self assert: c firstOps isEmpty
]

{ #category : #test }
KnClippingContextTest >> testFirstVecAt [
	| c |
	c := self newClipping.
	self should: [ c firstVecAt: #back ] raise: Error.
	self should: [ c firstVecAt: #front ] raise: Error.
	c firstVecAt: #back put: (self newVecX: 1 y: 2 z: 3).
	c firstVecAt: #front put: (self newVecX: 5 y: 6 z: 7).
	self
		assert: (c firstVecAt: #back)
		equals: (self newVecX: 1 y: 2 z: 3).
	self
		assert: (c firstVecAt: #front)
		equals: (self newVecX: 5 y: 6 z: 7)
]

{ #category : #test }
KnClippingContextTest >> testFirstVecAtPut [
	self testFirstVecAt
]

{ #category : #test }
KnClippingContextTest >> testFirstVecs [
	| c |
	c := self newClipping.
	self assert: c firstVecs isDictionary.
	self assert: c firstVecs isEmpty
]

{ #category : #test }
KnClippingContextTest >> testIsClipBack [
	| c |
	c := self newClipping.
	self deny: c isClipBack.
	c clipValueAt: #back put: 123.
	self assert: c isClipBack
]

{ #category : #test }
KnClippingContextTest >> testIsClipFront [
	| c |
	c := self newClipping.
	self deny: c isClipFront.
	c clipValueAt: #front put: 123.
	self assert: c isClipFront
]

{ #category : #test }
KnClippingContextTest >> testIsClippingPolygon [
	| c |
	c := self newClipping.
	self deny: c isClippingPolygon.
	c isClippingPolygon: true.
	self assert: c isClippingPolygon.
	c isClippingPolygon: false.
	self deny: c isClippingPolygon
]

{ #category : #test }
KnClippingContextTest >> testLastVecAt [
	| c |
	c := self newClipping.
	self assert: (c lastVecAt: #back) isZero.
	self assert: (c lastVecAt: #front) isZero.
	c lastVecAt: #back put: (self newVecX: 1 y: 2 z: 3).
	c lastVecAt: #front put: (self newVecX: 5 y: 6 z: 7).
	self
		assert: (c lastVecAt: #back)
		equals: (self newVecX: 1 y: 2 z: 3).
	self
		assert: (c lastVecAt: #front)
		equals: (self newVecX: 5 y: 6 z: 7)
]

{ #category : #test }
KnClippingContextTest >> testLastVecAtPut [
	self testLastVecAt
]

{ #category : #test }
KnClippingContextTest >> testLastVecs [
	| c |
	c := self newClipping.
	self assert: c lastVecs isDictionary.
	self assert: c lastVecs notEmpty
]

{ #category : #test }
KnClippingContextTest >> testNeedFirstAt [
	| c |
	c := self newClipping.
	self deny: (c needFirstAt: #back).
	self deny: (c needFirstAt: #front).
	c needFirstAt: #back put: true.
	c needFirstAt: #front put: false.
	self assert: (c needFirstAt: #back).
	self deny: (c needFirstAt: #front)
]

{ #category : #test }
KnClippingContextTest >> testNeedFirstAtPut [
	self testNeedFirstAt
]

{ #category : #test }
KnClippingContextTest >> testNeedFirsts [
	| c |
	c := self newClipping.
	self assert: c needFirsts isDictionary.
	self assert: c needFirsts notEmpty
]

{ #category : #test }
KnClippingContextTest >> testPutInTBufferOpcode [
	| c v |
	c := self newClipping.
	v := self newVecX: 1 y: 2 z: 3.
	c resetTBuffer.
	c putInTBuffer: v opcode: 5.
	self assert: c tOps size equals: 1.
	self assert: c tVecs size equals: 1.
	self assert: c tOps first equals: 5.
	self assert: c tVecs first equals: v
]

{ #category : #test }
KnClippingContextTest >> testReset [
	| c |
	c := self newClipping.
	self assert: c firstVecs isDictionary.
	self assert: c firstVecs isEmpty.
	self assert: c lastVecs isDictionary.
	self assert: c lastVecs notEmpty.
	self assert: c firstOps isDictionary.
	self assert: c firstOps isEmpty.
	self assert: c needFirsts isDictionary.
	self assert: c needFirsts notEmpty.
	self assert: c clipValues isDictionary.
	self assert: c clipValues isEmpty.
	self deny: c isClippingPolygon.
	self assert: c closing isNil
]

{ #category : #test }
KnClippingContextTest >> testResetLasts [
	| c v |
	c := self newClipping.
	v := self newVecX: 1 y: 2 z: 3.
	#(back front left right top bottom)
		do: [ :each | 
			self assert: (c lastVecs at: each) isZero.
			self deny: (c needFirsts at: each) ].
	c resetLasts: v.
	#(back front left right top bottom)
		do: [ :each | 
			self assert: (c lastVecs at: each) equals: v.
			self assert: (c needFirsts at: each) ]
]

{ #category : #test }
KnClippingContextTest >> testResetTBuffer [
	| c |
	c := self newClipping.
	self assert: c tOps isNil.
	self assert: c tVecs isNil.
	c resetTBuffer.
	self assert: c tOps isCollection.
	self assert: c tOps isEmpty.
	self assert: c tVecs isCollection.
	self assert: c tVecs isEmpty
]

{ #category : #test }
KnClippingContextTest >> testSetupViewport [
	| c |
	c := self newClipping.
	self assert: c clipOrigin isNil.
	c window: #(0 1 0 1).
	c viewport: #(0 100 0 200).
	c setupViewport.
	self assert: c clipOrigin equals: 0 @ 0.
	self assert: c viewportPoint equals: 0 @ 0.
	self assert: c viewportExtent equals: 100 @ 200.
	c window: #(-0.5 0.5 -0.5 0.5).
	c viewport: #(0 100 0 200).
	c setupViewport.
	self assert: c clipOrigin equals: -0.5 @ -0.5.
	self assert: c viewportPoint equals: 0 @ 0.
	self assert: c viewportExtent equals: 100 @ 200
]

{ #category : #test }
KnClippingContextTest >> testTOps [
	self testResetTBuffer
]

{ #category : #test }
KnClippingContextTest >> testTVecs [
	self testResetTBuffer
]

{ #category : #test }
KnClippingContextTest >> testVecXOf [
	| c v1 v2 v |
	c := self newClipping.
	v1 := self newVecX: 2 y: 4 z: -1.
	v2 := self newVecX: -3 y: -1 z: 4.
	c lastVecAt: #left put: v1.
	c clipValueAt: #left put: -2.
	v := c vec: v2 xOf: #left.
	self assert: v equals: (self newVecX: -2 y: 0 z: 3).
	c lastVecAt: #right put: v1.
	c clipValueAt: #right put: 3.
	v := c vec: v2 xOf: #right.
	self assert: v equals: (self newVecX: 3 y: 5 z: -2)
]

{ #category : #test }
KnClippingContextTest >> testVecYOf [
	| c v1 v2 v |
	c := self newClipping.
	v1 := self newVecX: 2 y: 4 z: -1.
	v2 := self newVecX: -3 y: -1 z: 4.
	c lastVecAt: #bottom put: v1.
	c clipValueAt: #bottom put: -2.
	v := c vec: v2 yOf: #bottom.
	self assert: v equals: (self newVecX: -4 y: -2 z: 5).
	c lastVecAt: #top put: v1.
	c clipValueAt: #top put: 6.
	v := c vec: v2 yOf: #top.
	self assert: v equals: (self newVecX: 4 y: 6 z: -3)
]

{ #category : #test }
KnClippingContextTest >> testVeczOf [
	| c v1 v2 v |
	c := self newClipping.
	v1 := self newVecX: 1 y: 2 z: -4.
	v2 := self newVecX: 3 y: 6 z: -2.
	c lastVecAt: #back put: v1.
	c clipValueAt: #back put: -3.
	v := c vec: v2 zOf: #back.
	self assert: v equals: (self newVecX: 2 y: 4 z: -3).
	c lastVecAt: #front put: v1.
	c clipValueAt: #front put: -1.
	v := c vec: v2 zOf: #front.
	self assert: v equals: (self newVecX: 4 y: 8 z: -1)
]

{ #category : #test }
KnClippingContextTest >> testViewingTransformOpcode [
	| c df v |
	c := self newClipping.
	c window: #(0 1 0 1).
	c viewport: #(0 100 0 200).
	c setupViewport.
	df := OrderedCollection new.
	c displayFile: df.
	v := KnVec4 x: 0.5 y: 0.5 z: 1.
	c viewingTransform: v opcode: 1.
	self assert: df first arg equals: (KnVec4 x: 50 y: 100 z: 1).
	self assert: df first opcode equals: 1.
	c window: #(-0.5 0.5 -0.5 0.5).
	c viewport: #(0 100 0 200).
	c setupViewport.
	v := KnVec4 x: 0.5 y: 0.5 z: 1.
	c viewingTransform: v opcode: 2.
	self assert: df second arg equals: (KnVec4 x: 100 y: 200 z: 1).
	self assert: df second opcode equals: 2.
	c window: #(-0.5 0.5 -0.5 0.5).
	c viewport: #(0 100 200 0).
	c setupViewport.
	v := KnVec4 x: 0.5 y: -0.5 z: 1.
	c viewingTransform: v opcode: 1.
	self assert: df third arg equals: (KnVec4 x: 100 y: 200 z: 1).
	self assert: df third opcode equals: 1.
	c window: #(-0.5 0.5 -0.5 0.5).
	c viewport: #(0 100 200 0).
	c setupViewport.
	v := KnVec4 x: 0.5 y: 0.5 z: 1.
	c viewingTransform: v opcode: 2.
	self assert: df fourth arg equals: (KnVec4 x: 100 y: 0 z: 1).
	self assert: df fourth opcode equals: 2
]

{ #category : #test }
KnClippingContextTest >> testViewport [
	| c |
	c := self newClipping.
	c viewport: #(1 2 3 4).
	self assertCollection: (c clipValueAt: #viewport) equals: #(1 2 3 4)
]

{ #category : #test }
KnClippingContextTest >> testViewportExtent [
	self testSetupViewport
]

{ #category : #test }
KnClippingContextTest >> testViewportPoint [
	self testSetupViewport
]

{ #category : #test }
KnClippingContextTest >> testWindow [
	| c |
	c := self newClipping.
	self assert: (c clipValueAt: #left) isNil.
	self assert: (c clipValueAt: #right) isNil.
	self assert: (c clipValueAt: #bottom) isNil.
	self assert: (c clipValueAt: #top) isNil.
	c window: #(1 2 3 4).
	self assert: (c clipValueAt: #left) equals: 1.
	self assert: (c clipValueAt: #right) equals: 2.
	self assert: (c clipValueAt: #bottom) equals: 3.
	self assert: (c clipValueAt: #top) equals: 4
]
