"
A KnTransformationTest is a test class for testing the behavior of KnTransformation
"
Class {
	#name : #KnTransformationTest,
	#superclass : #TestCase,
	#category : #'Knead3d-Tests'
}

{ #category : #private }
KnTransformationTest >> newTransformation [
	^ KnTransformation new
]

{ #category : #test }
KnTransformationTest >> testInitialize [
	| t |
	t := self newTransformation.
	self assert: (t tMatrix isKindOf: KnMatrix4)
]

{ #category : #test }
KnTransformationTest >> testNewTransform [
	| t |
	t := self newTransformation.
	self assert: (t newTransform isKindOf: KnMatrix4)
]

{ #category : #test }
KnTransformationTest >> testTMatrix [
	| t |
	t := self newTransformation.
	self assert: (t tMatrix isKindOf: KnMatrix4)
]
