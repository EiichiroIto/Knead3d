"
A KnVec4Test is a test class for testing the behavior of KnVec4
"
Class {
	#name : #KnVec4Test,
	#superclass : #TestCase,
	#category : #'Knead3d-Tests'
}

{ #category : #private }
KnVec4Test >> basicNewVec [
	^ KnVec4 basicNew
]

{ #category : #private }
KnVec4Test >> newVec [
	^ KnVec4 x: 0 y: 0 z: 0
]

{ #category : #private }
KnVec4Test >> newVecX: x y: y z: z [
	^ KnVec4 x: x y: y z: z
]

{ #category : #private }
KnVec4Test >> newVecX: x y: y z: z w: w [
	^ KnVec4 x: x y: y z: z w: w
]

{ #category : #test }
KnVec4Test >> testArray [
	| a x |
	a := self newVecX: 1 y: 2 z: 3.
	x := a array.
	x at: 1 put: 5.
	x at: 2 put: 5.
	x at: 3 put: 5.
	x at: 4 put: 5.
	self assert: a x equals: 1.
	self assert: a y equals: 2.
	self assert: a z equals: 3.
	self assert: a w equals: 0
]

{ #category : #test }
KnVec4Test >> testAt [
	| v |
	v := self newVec.
	self assert: (v at: 1) equals: 0.0.
	self assert: (v at: 2) equals: 0.0.
	self assert: (v at: 3) equals: 0.0.
	self assert: (v at: 4) equals: 0.0.
	v := self newVecX: 5 y: 6 z: 7 w: 8.
	self assert: (v at: 1) equals: 5.0.
	self assert: (v at: 2) equals: 6.0.
	self assert: (v at: 3) equals: 7.0.
	self assert: (v at: 4) equals: 8.0
]

{ #category : #test }
KnVec4Test >> testDotProduct [
	| v1 v2 |
	v1 := self newVecX: 1 y: 2 z: 3.
	v2 := self newVecX: 3 y: 4 z: 5.
	self assert: (v1 dotProduct: v2) equals: 1 * 3 + (2 * 4) + (3 * 5)
]

{ #category : #test }
KnVec4Test >> testEpsilon [
	self assert: (KnVec4 epsilon between: 0 and: 0.0001)
]

{ #category : #test }
KnVec4Test >> testInitialize [
	| v |
	v := self newVec.
	self assert: (v at: 1) equals: 0.0.
	self assert: (v at: 2) equals: 0.0.
	self assert: (v at: 3) equals: 0.0.
	self assert: (v at: 4) equals: 0.0
]

{ #category : #test }
KnVec4Test >> testIsOrthogonalTo [
	| v |
	v := self newVecX: 1 y: 0 z: 0.
	self assert: (v isOrthogonalTo: (self newVecX: 0 y: 0 z: 1)).
	self assert: (v isOrthogonalTo: (self newVecX: 0 y: 1 z: 0)).
	self assert: (v isOrthogonalTo: (self newVecX: 0 y: 1 z: 1)).
	self deny: (v isOrthogonalTo: (self newVecX: 1 y: 0 z: 1)).
	self deny: (v isOrthogonalTo: (self newVecX: 5 y: 0 z: 0))
]

{ #category : #test }
KnVec4Test >> testIsParallelTo [
	| v |
	v := self newVecX: 1 y: 0 z: 0.
	self deny: (v isParallelTo: (self newVecX: 0 y: 0 z: 1)).
	self deny: (v isParallelTo: (self newVecX: 0 y: 1 z: 0)).
	self deny: (v isParallelTo: (self newVecX: 0 y: 1 z: 1)).
	self deny: (v isParallelTo: (self newVecX: 1 y: 0 z: 1)).
	self assert: (v isParallelTo: (self newVecX: 5 y: 0 z: 0))
]

{ #category : #test }
KnVec4Test >> testIsZero [
	| v |
	v := self newVecX: 0 y: 0 z: 0 w: 0.
	self assert: v isZero.
	v := self newVecX: 1 y: 0 z: 0 w: 0.
	self deny: v isZero.
	v := self newVecX: 0 y: 1 z: 0 w: 0.
	self deny: v isZero.
	v := self newVecX: 0 y: 0 z: 1 w: 0.
	self deny: v isZero.
	v := self newVecX: 0 y: 0 z: 0 w: 1.
	self deny: v isZero
]

{ #category : #test }
KnVec4Test >> testLengthOfYZ [
	| v |
	v := self newVecX: 1 y: 2 z: 3.
	self assert: v lengthOfYZ equals: 13 sqrt
]

{ #category : #test }
KnVec4Test >> testNearTo [
	| v epsiron |
	epsiron := KnVec4 epsilon.
	v := self newVecX: 1 y: 2 z: 3.
	self assert: (v nearTo: (self newVecX: 1 y: 2 z: 3)).
	self
		assert: (v nearTo: (self newVecX: 1 + epsiron y: 2 z: 3)).
	self
		assert: (v nearTo: (self newVecX: 1 y: 2 + epsiron z: 3)).
	self
		assert: (v nearTo: (self newVecX: 1 y: 2 z: 3 + epsiron)).
	self
		deny:
			(v
				nearTo:
					(self
						newVecX: 1 + epsiron
						y: 2 + epsiron
						z: 3 + epsiron))
]

{ #category : #test }
KnVec4Test >> testNegated [
	| v |
	v := self newVecX: 1 y: 2 z: 3 w: 4.
	v := v negated.
	self assert: v x equals: -1.
	self assert: v y equals: -2.
	self assert: v z equals: -3.
	self assert: v w equals: -4
]

{ #category : #test }
KnVec4Test >> testNewArray [
	| v a |
	v := self basicNewVec.
	a := v newArray.
	self assert: (a isKindOf: FloatArray).
	self assert: a size equals: 4
]

{ #category : #test }
KnVec4Test >> testNormalized [
	| v |
	v := self newVecX: 1 y: 2 z: 3.
	self
		assert: v normalized
		equals: (self newVecX: 1 / 14 sqrt y: 2 / 14 sqrt z: 3 / 14 sqrt).
	v := self newVecX: 0 y: 0 z: 0.
	self assert: v normalized isZero
]

{ #category : #test }
KnVec4Test >> testOrthogonalWith [
	| v |
	v := self newVecX: 1 y: 0 z: 0.
	self
		assert: (v orthogonalWith: (self newVecX: 0 y: 0 z: 1))
		equals: (self newVecX: 0 y: -1 z: 0).
	v := self newVecX: 0 y: 0 z: 1.
	self
		assert: (v orthogonalWith: (self newVecX: -1 y: 0 z: 0))
		equals: (self newVecX: 0 y: -1 z: 0).
	v := self newVecX: 0 y: 0 z: 1.
	self assert: (v orthogonalWith: (self newVecX: 0 y: 0 z: 2)) isZero
]

{ #category : #test }
KnVec4Test >> testPlus [
	| a b c |
	a := self newVecX: 1 y: 2 z: 3.
	b := self newVecX: 5 y: 6 z: 7.
	c := a + b.
	self deny: c = a.
	self deny: c = b.
	self assertCollection: c array equals: #(6 8 10 0) asFloatArray.
	a := self newVecX: 1 y: 2 z: 3 w: 1.
	b := self newVecX: 5 y: 6 z: 7 w: 2.
	c := a + b.
	self assertCollection: c array equals: #(6 8 10 3) asFloatArray
]

{ #category : #test }
KnVec4Test >> testPrivArray [
	| v |
	v := self newVec.
	self assertCollection: v privArray asArray equals: #(0 0 0 0).
	v privArray: #(1 2 3 4) asFloatArray.
	self assertCollection: v privArray asArray equals: #(1 2 3 4).
	self assert: (v privArray isKindOf: FloatArray)
]

{ #category : #test }
KnVec4Test >> testR [
	| v |
	v := self newVecX: 1 y: 2 z: 3.
	self assert: v r equals: (1 + 4 + 9) sqrt
]

{ #category : #test }
KnVec4Test >> testSetArray [
	| v |
	v := self basicNewVec.
	self assert: v privArray isNil.
	v setArray: #(5 6 7).
	self assert: (v privArray at: 1) equals: 5.
	self assert: (v privArray at: 2) equals: 6.
	self assert: (v privArray at: 3) equals: 7.
	self assert: (v privArray at: 4) equals: 0.
	v := self basicNewVec.
	self assert: v privArray isNil.
	v setArray: #(5 6 7 8).
	self assert: (v privArray at: 1) equals: 5.
	self assert: (v privArray at: 2) equals: 6.
	self assert: (v privArray at: 3) equals: 7.
	self assert: (v privArray at: 4) equals: 8
]

{ #category : #test }
KnVec4Test >> testSetInfinity [
	| v |
	v := self basicNewVec.
	v setInfinity.
	self assert: v x isInfinite.
	self assert: v y isInfinite.
	self assert: v z isInfinite.
	self assert: v w isInfinite
]

{ #category : #test }
KnVec4Test >> testSetXYZW [
	| v |
	v := self basicNewVec.
	self assert: v privArray isNil.
	v setX: 5 y: 6 z: 7 w: 8.
	self assert: (v privArray at: 1) equals: 5.
	self assert: (v privArray at: 2) equals: 6.
	self assert: (v privArray at: 3) equals: 7.
	self assert: (v privArray at: 4) equals: 8
]

{ #category : #test }
KnVec4Test >> testSign [
	| v |
	v := self newVecX: 1 y: 2 z: 3.
	self assert: v sign equals: (self newVecX: 1 y: 1 z: 1).
	v := self newVecX: -1 y: -2 z: -3.
	self assert: v sign equals: (self newVecX: -1 y: -1 z: -1).
	v := self newVecX: 0 y: -0.1 z: 0.
	self assert: v sign equals: (self newVecX: 0 y: -1 z: 0).
	v := self newVecX: -0.0 y: -0.0 z: -0.0.
	self assert: v sign equals: (self newVecX: 0 y: 0 z: 0)
]

{ #category : #test }
KnVec4Test >> testStar [
	| v r v2 |
	v := self newVecX: 1 y: 2 z: 3.
	r := v * 10.
	self deny: v = r.
	self assertCollection: r array equals: #(10 20 30 0) asFloatArray.
	v2 := self newVecX: 5 y: -6 z: 0.
	self assert: v2 * v equals: (self newVecX: -18 y: -15 z: 16).
	v2 := self newVecX: 2 y: 4 z: 6.
	self assert: (v2 * v) isZero
]

{ #category : #test }
KnVec4Test >> testSumProduct [
	| v1 v2 |
	v1 := self newVecX: 1 y: 2 z: 3.
	v2 := self newVecX: 5 y: 6 z: 7.
	self assert: (v1 sumProduct: v2) equals: (1*5)+(2*6)+(3*7)
]

{ #category : #test }
KnVec4Test >> testSwapXY [
	| v |
	v := self newVecX: 1 y: 2 z: 3.
	self assert: v swapXY equals: (self newVecX: 2 y: 1 z: 3)
]

{ #category : #test }
KnVec4Test >> testSwapYZ [
	| v |
	v := self newVecX: 1 y: 2 z: 3.
	self assert: v swapYZ equals: (self newVecX: 1 y: 3 z: 2)
]

{ #category : #test }
KnVec4Test >> testSwapZX [
	| v |
	v := self newVecX: 1 y: 2 z: 3.
	self assert: v swapZX equals: (self newVecX: 3 y: 2 z: 1)
]

{ #category : #test }
KnVec4Test >> testW [
	| v |
	v := self newVec.
	self assert: v w equals: 0.
	v := self newVecX: 1 y: 2 z: 3 w: 4.
	self assert: v w equals: 4.
	v := v w: 1.
	self assert: v w equals: 1
]

{ #category : #test }
KnVec4Test >> testX [
	| v |
	v := self newVec.
	self assert: v x equals: 0.
	v := self newVecX: 1 y: 2 z: 3 w: 4.
	self assert: v x equals: 1
]

{ #category : #test }
KnVec4Test >> testY [
	| v |
	v := self newVec.
	self assert: v y equals: 0.
	v := self newVecX: 1 y: 2 z: 3 w: 4.
	self assert: v y equals: 2
]

{ #category : #test }
KnVec4Test >> testZ [
	| v |
	v := self newVec.
	self assert: v z equals: 0.
	v := self newVecX: 1 y: 2 z: 3 w: 4.
	self assert: v z equals: 3
]
