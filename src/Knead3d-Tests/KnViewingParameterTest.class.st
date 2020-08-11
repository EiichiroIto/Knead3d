"
A KnViewingParamsTest is a test class for testing the behavior of KnViewingParams
"
Class {
	#name : #KnViewingParameterTest,
	#superclass : #TestCase,
	#category : #'Knead3d-Tests'
}

{ #category : #private }
KnViewingParameterTest >> newParam [
	^ KnViewingParameter new
]

{ #category : #private }
KnViewingParameterTest >> newVecX: x y: y z: z w: w [
	^ KnVec4 x: x y: y z: z w: w
]

{ #category : #test }
KnViewingParameterTest >> testBackDistance [
	| p |
	p := self newParam.
	self assert: p backDistance isNil.
	p frontDistance: 100.
	p backDistance: 123.
	self assert: p backDistance equals: 123.
	self should: [ p backDistance: 50. ] raise: Error.
	p backDistance: nil.
	self assert: p backDistance isNil
]

{ #category : #test }
KnViewingParameterTest >> testBackZ [
	| p |
	p := self newParam.
	p viewDistance: 10.
	self assert: p backZ isNil.
	p backDistance: 8.
	self assert: p backZ equals: 2.
	p backDistance: 15.
	self assert: p backZ equals: -5
]

{ #category : #test }
KnViewingParameterTest >> testFrontDistance [
	| p |
	p := self newParam.
	self assert: p frontDistance isNil.
	p backDistance: 150.
	p frontDistance: 123.
	self assert: p frontDistance equals: 123.
	self should: [ p frontDistance: 160. ] raise: Error.
	p frontDistance: nil.
	self assert: p frontDistance isNil

]

{ #category : #test }
KnViewingParameterTest >> testFrontZ [
	| p |
	p := self newParam.
	p viewDistance: 10.
	self assert: p frontZ isNil.
	p frontDistance: 8.
	self assert: p frontZ equals: 2.
	p frontDistance: 15.
	self assert: p frontZ equals: -5
]

{ #category : #test }
KnViewingParameterTest >> testViewDistance [
	| w |
	w := self newParam.
	self assert: w viewDistance equals: 0.
	w viewDistance: 123.
	self assert: w viewDistance equals: 123
]

{ #category : #test }
KnViewingParameterTest >> testViewPlaneNormal [
	| w |
	w := self newParam.
	self assert: w viewPlaneNormal isNil.
	w viewPlaneNormal: (KnVec4 fromArray: #(1 2 3 1)).
	self assert: w viewPlaneNormal x closeTo: 1 / 14 sqrt.
	self assert: w viewPlaneNormal y closeTo: 2 / 14 sqrt.
	self assert: w viewPlaneNormal z closeTo: 3 / 14 sqrt.
	self should: [ w viewPlaneNormal: KnVec4 new ] raise: Error
]

{ #category : #test }
KnViewingParameterTest >> testViewReferencePoint [
	| w |
	w := self newParam.
	self assert: w viewPlaneNormal isNil.
	w viewReferencePoint: (KnVec4 fromArray: #(1 2 3 1)).
	self assert: w viewReferencePoint x closeTo: 1.
	self assert: w viewReferencePoint y closeTo: 2.
	self assert: w viewReferencePoint z closeTo: 3
]

{ #category : #test }
KnViewingParameterTest >> testViewUp [
	| w v |
	w := self newParam.
	self assert: w viewUp isNil.
	v := self newVecX: 1 y: 2 z: 3 w: 0.
	w viewUp: v.
	self assert: w viewUp x closeTo: 1.
	self assert: w viewUp y closeTo: 2.
	self assert: w viewUp z closeTo: 3.
	v := self newVecX: 0 y: 0 z: 0 w: 0.
	self should: [ w viewUp: v ] raise: Error
]

{ #category : #test }
KnViewingParameterTest >> testWindow [
	| p |
	p := self newParam.
	self assert: p window isNil.
	self should: [ p window: #(1 2) ] raise: Error.
	p window: #(1 2 3 4).
	self assertCollection: p window equals: #(1 2 3 4)
]
