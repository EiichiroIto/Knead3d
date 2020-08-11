"
A KnEdgeInfoTest is a test class for testing the behavior of KnEdgeInfo
"
Class {
	#name : #KnEdgeInfoTest,
	#superclass : #TestCase,
	#category : #'Knead3d-Tests'
}

{ #category : #private }
KnEdgeInfoTest >> newInfo [
	^ KnEdgeInfo new
]

{ #category : #test }
KnEdgeInfoTest >> testDx [
	| i |
	i := self newInfo.
	self assert: i dx isNil.
	i dx: 123.
	self assert: i dx equals: 123
]

{ #category : #test }
KnEdgeInfoTest >> testFromTo [
	| i |
	i := self newInfo.
	i from: 1.2 @ 4.3 to: 3.1 @ 2.5.
	self assert: i yMax equals: 4.3.
	self assert: i yMin equals: 2.5.
	self assert: i xa equals: 1.
	self assert: i dx equals: -1 * (3 - 1) / (2.5 - 4.3).
	i from: 2.2 @ 2.7 to: 3.1 @ 4.6.
	self assert: i yMax equals: 4.6.
	self assert: i yMin equals: 2.7.
	self assert: i xa equals: 3.
	self assert: i dx equals: -1 * (3 - 2) / (4.6 - 2.7)
]

{ #category : #test }
KnEdgeInfoTest >> testXa [
	| i |
	i := self newInfo.
	self assert: i xa isNil.
	i xa: 123.
	self assert: i xa equals: 123
]

{ #category : #test }
KnEdgeInfoTest >> testYMax [
	self testFromTo
]

{ #category : #test }
KnEdgeInfoTest >> testYMin [
	| i |
	i := self newInfo.
	self assert: i yMin isNil.
	i yMin: 123.
	self assert: i yMin equals: 123
]
