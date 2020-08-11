"
A KnParallelTransformTest is a test class for testing the behavior of KnParallelTransform
"
Class {
	#name : #KnParallelTransformTest,
	#superclass : #TestCase,
	#category : #'Knead3d-Tests'
}

{ #category : #private }
KnParallelTransformTest >> newTransform [
	^ KnParallelTransform new
]

{ #category : #private }
KnParallelTransformTest >> newVecX: x y: y z: z [
	^ KnVec4 x: x y: y z: z
]

{ #category : #test }
KnParallelTransformTest >> testDirection [
	| t v |
	t := self newTransform.
	self assert: t direction isNil.
	v := self newVecX: 1 y: 2 z: 3.
	t direction: v.
	self assert: t direction equals: v
]

{ #category : #test }
KnParallelTransformTest >> testSp [
	| t v |
	t := self newTransform.
	self assert: t sp isNil.
	v := self newVecX: 1 y: 2 z: 3.
	t sp: v.
	self assert: t sp equals: v
]

{ #category : #test }
KnParallelTransformTest >> testTransform [
	"
                 1      0 0 0
                 0      1 0 0
[ 1 2 3 4 ] -xp/zp -yp/zp 1 0
                 0      0 0 1
"

	| t v r |
	t := self newTransform.
	v := self newVecX: 10 y: 20 z: 30.
	t sp: v / 30.
	v := self newVecX: 1 y: 2 z: 3.
	r := t transform: v.
	self assert: r x closeTo: (1 + (3 * (10 negated / 30))) asFloat.
	self assert: r y closeTo: (2 + (3 * (20 negated / 30))) asFloat.
	self assert: r z equals: 3
]
