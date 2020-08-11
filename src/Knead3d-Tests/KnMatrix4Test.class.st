"
A KnMatrix4Test is a test class for testing the behavior of KnMatrix4
"
Class {
	#name : #KnMatrix4Test,
	#superclass : #TestCase,
	#category : #'Knead3d-Tests'
}

{ #category : #private }
KnMatrix4Test >> newMatrix [
	^ KnMatrix4 new
]

{ #category : #private }
KnMatrix4Test >> newVecX: x y: y z: z w: w [
	^ KnVec4 x: x y: y z: z w: w
]

{ #category : #test }
KnMatrix4Test >> testArray [
	| a b |
	a := self newMatrix.
	a fromArray: (1 to: 16).
	b := self newMatrix.
	b fromArray: a array.
	b at: 1 put: 5.
	self assertCollection: a array equals: (1 to: 16) asFloatArray.
	self
		assertCollection: b array
		equals: #(5 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16) asFloatArray
]

{ #category : #test }
KnMatrix4Test >> testAt [
	| v |
	v := self newMatrix.
	self assert: (v at: 1) equals: 0.
	self assert: (v at: 5) equals: 0.
	self assert: (v at: 16) equals: 0.
	v at: 1 put: 8.
	v at: 5 put: 9.
	v at: 16 put: 10.
	self assert: (v at: 1) equals: 8.
	self assert: (v at: 5) equals: 9.
	self assert: (v at: 16) equals: 10
]

{ #category : #test }
KnMatrix4Test >> testAtPut [
	self testAt
]

{ #category : #test }
KnMatrix4Test >> testEqualsSign [
	| a b |
	a := self newMatrix.
	self assert: a equals: a.
	b := self newMatrix.
	self assert: a equals: b.
	a at: 12 put: 5.
	self deny: a = b.
	b at: 12 put: 5.
	self assert: a equals: b
]

{ #category : #test }
KnMatrix4Test >> testFromArray [
	| a |
	a := self newMatrix.
	a fromArray: (1 to: 16) * 2.
	1 to: 16 do: [ :each | self assert: (a at: each) equals: each * 2 ].
	self should: [ a fromArray: #(1 2 3) ] raise: Error.
	self should: [ a fromArray: (1 to: 17) ] raise: Error
]

{ #category : #test }
KnMatrix4Test >> testIndexOfRowCol [
	" 1  2  3  4
	  5  6  7  8
	  9 10 11 12
	 13 14 15 16"

	| m |
	m := self newMatrix.
	self assert: (m indexOfRow: 1 col: 1) equals: 1.
	self assert: (m indexOfRow: 1 col: 2) equals: 2.
	self assert: (m indexOfRow: 1 col: 3) equals: 3.
	self assert: (m indexOfRow: 1 col: 4) equals: 4.
	self assert: (m indexOfRow: 2 col: 1) equals: 5.
	self assert: (m indexOfRow: 2 col: 2) equals: 6.
	self assert: (m indexOfRow: 2 col: 3) equals: 7.
	self assert: (m indexOfRow: 2 col: 4) equals: 8.
	self assert: (m indexOfRow: 3 col: 1) equals: 9.
	self assert: (m indexOfRow: 3 col: 2) equals: 10.
	self assert: (m indexOfRow: 3 col: 3) equals: 11.
	self assert: (m indexOfRow: 3 col: 4) equals: 12.
	self assert: (m indexOfRow: 4 col: 1) equals: 13.
	self assert: (m indexOfRow: 4 col: 2) equals: 14.
	self assert: (m indexOfRow: 4 col: 3) equals: 15.
	self assert: (m indexOfRow: 4 col: 4) equals: 16
]

{ #category : #test }
KnMatrix4Test >> testInitialize [
	| m |
	m := self newMatrix.
	self assert: m privArray size equals: 16.
	self assert: (m privArray allSatisfy: [ :each | each = 0 ]).
	self assert: (m privArray isKindOf: FloatArray)
]

{ #category : #test }
KnMatrix4Test >> testMultiplyByMat4 [
	| a b c |
	a := self newMatrix.
	a fromArray: (1 to: 16).
	b := self newMatrix.
	b fromArray: #(1 0 0 0 0 2 0 0 0 0 1 0 0 0 0 1).
	c := b multiplyByMat4: a.
	self
		assertCollection: c array
		equals: #(1 4 3 4 5 12 7 8 9 20 11 12 13 28 15 16) asFloatArray.
	c := a multiplyByMat4: b.
	self
		assertCollection: c array
		equals: #(1 2 3 4 10 12 14 16 9 10 11 12 13 14 15 16) asFloatArray
]

{ #category : #test }
KnMatrix4Test >> testMultiplyByVec4 [
	| m v r |
	m := self newMatrix.
	m fromArray: (1 to: 16).
	v := self newVecX: 1 y: 2 z: 3 w: 4.
	r := m multiplyByVec4: v.
	self
		assertCollection: r array
		equals:
			{(1 * 1 + (2 * 5) + (3 * 9) + (4 * 13)).
			(1 * 2 + (2 * 6) + (3 * 10) + (4 * 14)).
			(1 * 3 + (2 * 7) + (3 * 11) + (4 * 15)).
			(1 * 4 + (2 * 8) + (3 * 12) + (4 * 16))} asFloatArray
]

{ #category : #test }
KnMatrix4Test >> testMultiplyColBy [
	| m |
	m := self newMatrix.
	m fromArray: (1 to: 16).
	self
		assert: (m multiplyCol: 1 by: #(1 2 3 4))
		equals: 1 * 1 + (2 * 5) + (3 * 9) + (4 * 13).
	self
		assert: (m multiplyCol: 2 by: #(1 2 3 4))
		equals: 1 * 2 + (2 * 6) + (3 * 10) + (4 * 14).
	self
		assert: (m multiplyCol: 3 by: #(1 2 3 4))
		equals: 1 * 3 + (2 * 7) + (3 * 11) + (4 * 15).
	self
		assert: (m multiplyCol: 4 by: #(1 2 3 4))
		equals: 1 * 4 + (2 * 8) + (3 * 12) + (4 * 16)
]

{ #category : #test }
KnMatrix4Test >> testMultiplyRowAndColOfTo [
	| a b c |
	a := self newMatrix.
	a fromArray: (1 to: 16).
	b := self newMatrix.
	b fromArray: #(1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1).
	c := self newMatrix.
	a
		multiplyRow: 2
		andCol: 3
		of: b
		to: c.
	self assert: (c at: 7) equals: 7.
	(1 to: 16) \ #(7) do: [ :each | self assert: (c at: each) equals: 0 ]
]

{ #category : #test }
KnMatrix4Test >> testPrivArray [
	| m |
	m := self newMatrix.
	self assert: m privArray size equals: 16.
	self assert: (m privArray allSatisfy: [ :each | each = 0 ]).
	self assert: (m privArray isKindOf: FloatArray).
	m privArray: #(1 2 3 4).
	self assertCollection: m privArray equals: #(1 2 3 4)
]

{ #category : #test }
KnMatrix4Test >> testRotateAxis [
	| m m2 |
	m := self newMatrix.
	m rotate: 30 axis: (self newVecX: 1 y: 0 z: 0 w: 0).
	m2 := KnMatrix4 identity.
	m2 rotateX: 30.
	self assertCollection: m privArray equals: m2 privArray.
	m := self newMatrix.
	m rotate: 30 axis: (self newVecX: 0 y: 1 z: 0 w: 0).
	m2 := KnMatrix4 identity.
	m2 rotateY: 30.
	self assertCollection: m privArray equals: m2 privArray.
	m := self newMatrix.
	m rotate: 30 axis: (self newVecX: 0 y: 0 z: 1 w: 0).
	m2 := KnMatrix4 identity.
	m2 rotateZ: 30.
	self assertCollection: m privArray equals: m2 privArray
]

{ #category : #test }
KnMatrix4Test >> testRotateX [
	| m a c |
	m := KnMatrix4 identity.
	m rotateX: 30.
	"
1  0  0  0
0  c  s  0
0 -s  c  0
0  0  0  1
"
	c := 3 sqrt / 2.
	a := {1. 0. 0. 0. 0. c. 0.5. 0. 0. -0.5. c. 0. 0. 0. 0. 1}.
	self assertCollection: m privArray equals: a asFloatArray
]

{ #category : #test }
KnMatrix4Test >> testRotateXSinCos [
	| m a b c |
	m := self newMatrix.
	m fromArray: (1 to: 16).
	m rotateXSin: 10 cos: 100.
"
 1  2  3  4   1  0  0  0
 5  6  7  8   0  c  s  0
 9 10 11 12   0 -s  c  0
13 14 15 16   0  0  0  1
"
	a := self newMatrix.
	a fromArray: (1 to: 16).
	b := self newMatrix.
	b fromArray: #(1 0 0 0 0 100 10 0 0 -10 100 0 0 0 0 1).
	c := a * b.
	self assertCollection: m privArray equals: c privArray
]

{ #category : #test }
KnMatrix4Test >> testRotateY [
	| m a c |
	m := KnMatrix4 identity.
	m rotateY: 30.
"
c  0 -s  0
0  1  0  0
s  0  c  0
0  0  0  1
"
	c := 3 sqrt / 2.
	a := {c. 0. -0.5. 0. 0. 1. 0. 0. 0.5. 0. c. 0. 0. 0. 0. 1}.
	self assertCollection: m privArray equals: a asFloatArray
]

{ #category : #test }
KnMatrix4Test >> testRotateYSinCos [
	| m a b c |
	m := self newMatrix.
	m fromArray: (1 to: 16).
	m rotateYSin: 10 cos: 100.
"
 1  2  3  4   c  0 -s  0
 5  6  7  8   0  1  0  0
 9 10 11 12   s  0  c  0
13 14 15 16   0  0  0  1
"
	a := self newMatrix.
	a fromArray: (1 to: 16).
	b := self newMatrix.
	b fromArray: #(100 0 -10 0 0 1 0 0 10 0 100 0 0 0 0 1).
	c := a * b.
	self assertCollection: m privArray equals: c privArray
]

{ #category : #test }
KnMatrix4Test >> testRotateZ [
	| m a c |
	m := KnMatrix4 identity.
	m rotateZ: 30.
"
 c  s  0  0
-s  c  0  0
 0  0  1  0
 0  0  0  1
"
	c := 3 sqrt / 2.
	a := {c. 0.5. 0. 0. -0.5. c. 0. 0. 0. 0. 1. 0. 0. 0. 0. 1}.
	self assertCollection: m privArray equals: a asFloatArray
]

{ #category : #test }
KnMatrix4Test >> testRotateZSinCos [
	| m a b c |
	m := self newMatrix.
	m fromArray: (1 to: 16).
	m rotateZSin: 10 cos: 100.
"
 1  2  3  4   c  s  0  0
 5  6  7  8  -s  c  0  0
 9 10 11 12   0  0  1  0
13 14 15 16   0  0  0  1
"
	a := self newMatrix.
	a fromArray: (1 to: 16).
	b := self newMatrix.
	b fromArray: #(100 10 0 0 -10 100 0 0 0 0 1 0 0 0 0 1).
	c := a * b.
	self assertCollection: m privArray equals: c privArray
]

{ #category : #test }
KnMatrix4Test >> testRowCol [
	| m |
	m := self newMatrix.
	m fromArray: (1 to: 16).
	self assert: (m row: 1 col: 1) equals: 1.
	self assert: (m row: 1 col: 2) equals: 2.
	self assert: (m row: 1 col: 3) equals: 3.
	self assert: (m row: 1 col: 4) equals: 4.
	self assert: (m row: 2 col: 1) equals: 5.
	self assert: (m row: 2 col: 2) equals: 6.
	self assert: (m row: 2 col: 3) equals: 7.
	self assert: (m row: 2 col: 4) equals: 8.
	self assert: (m row: 3 col: 1) equals: 9.
	self assert: (m row: 3 col: 2) equals: 10.
	self assert: (m row: 3 col: 3) equals: 11.
	self assert: (m row: 3 col: 4) equals: 12.
	self assert: (m row: 4 col: 1) equals: 13.
	self assert: (m row: 4 col: 2) equals: 14.
	self assert: (m row: 4 col: 3) equals: 15.
	self assert: (m row: 4 col: 4) equals: 16
]

{ #category : #test }
KnMatrix4Test >> testSetTransformation [
	"1  2  3  4
   5  6  7  8
   9 10 11 12
  13 14 15 16"

	| v |
	v := self newMatrix.
	v setTransformation.
	#(1 6 11 16) do: [ :each | self assert: (v at: each) equals: 1 ].
	(1 to: 16) \ #(1 6 11 16)
		do: [ :each | self assert: (v at: each) equals: 0 ]
]

{ #category : #test }
KnMatrix4Test >> testStar [
	| a b c |
	a := self newMatrix.
	a fromArray: (1 to: 16).
	b := self newMatrix.
	b fromArray: #(1 0 0 0 0 2 0 0 0 0 1 0 0 0 0 1).
	c := a * b.
	self
		assertCollection: c array
		equals: #(1 4 3 4 5 12 7 8 9 20 11 12 13 28 15 16) asFloatArray.
	c := b * a.
	self
		assertCollection: c array
		equals: #(1 2 3 4 10 12 14 16 9 10 11 12 13 14 15 16) asFloatArray
]

{ #category : #test }
KnMatrix4Test >> testTranslate [
	"1  2  3  4
   5  6  7  8
   9 10 11 12
  13 14 15 16"

	| m v |
	m := self newMatrix.
	self assert: (m at: 13) equals: 0.
	self assert: (m at: 14) equals: 0.
	self assert: (m at: 15) equals: 0.
	v := KnVec4 x: 1 y: 2 z: 3.
	m translate: v.
	self assert: (m at: 13) equals: 1.
	self assert: (m at: 14) equals: 2.
	self assert: (m at: 15) equals: 3.
	v := KnVec4 x: 2 y: 2 z: 2.
	m translate: v.
	self assert: (m at: 13) equals: 3.
	self assert: (m at: 14) equals: 4.
	self assert: (m at: 15) equals: 5.
	(1 to: 16) \ #(13 14 15)
		do: [ :each | self assert: (m at: each) equals: 0 ]
]
