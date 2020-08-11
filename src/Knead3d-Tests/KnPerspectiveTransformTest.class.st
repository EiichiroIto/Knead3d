"
A KnPerspectiveTransformTest is a test class for testing the behavior of KnPerspectiveTransform
"
Class {
	#name : #KnPerspectiveTransformTest,
	#superclass : #TestCase,
	#category : #'Knead3d-Tests'
}

{ #category : #private }
KnPerspectiveTransformTest >> newTransform [
	^ KnPerspectiveTransform new
]

{ #category : #private }
KnPerspectiveTransformTest >> newVecX: x y: y z: z [
	^ KnVec4 x: x y: y z: z
]

{ #category : #test }
KnPerspectiveTransformTest >> testCenter [
	| t v |
	t := self newTransform.
	self assert: t center isNil.
	v := self newVecX: 1 y: 2 z: 3.
	t center: v.
	self assert: t center equals: v	
]

{ #category : #test }
KnPerspectiveTransformTest >> testCenterOfProjection [
	| t v |
	t := self newTransform.
	v := self newVecX: 1 y: 2 z: 3.
	t centerOfProjection: v.
	self assert: t centerOfProjection x equals: 1.
	self assert: t centerOfProjection y equals: 2.
	self assert: t centerOfProjection z equals: 3
]

{ #category : #test }
KnPerspectiveTransformTest >> testTransform [
	"
            -zc   0  0   0
              0 -zc  0   0
[ 1 2 3 4 ]  xc  yc -1   1
              0   0  0 -zc
"

	| t v r |
	t := self newTransform.
	v := self newVecX: 10 y: 20 z: 30.
	t centerOfProjection: v.
	v := self newVecX: 1 y: 2 z: 3.
	r := t transform: v.
	self assert: r x closeTo: (-30 + (3 * 10)) asFloat.
	self assert: r y closeTo: (2 * -30 + (3 * 20)) asFloat.
	self assert: r z closeTo: (3 / (3 - 30)) negated asFloat
]
