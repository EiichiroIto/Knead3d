"
A Kn3DObjectTest is a test class for testing the behavior of Kn3DObject
"
Class {
	#name : #Kn3DObjectTest,
	#superclass : #TestCase,
	#category : #'Knead3d-Tests'
}

{ #category : #private }
Kn3DObjectTest >> newEnd: aCollection [
	^ Kn3DObject end: aCollection
]

{ #category : #private }
Kn3DObjectTest >> newLine: aVector [
	^ Kn3DObject line: aVector
]

{ #category : #private }
Kn3DObjectTest >> newMove: aVector [
	^ Kn3DObject move: aVector
]

{ #category : #private }
Kn3DObjectTest >> newSide: aCollection [
	^ Kn3DObject side: aCollection
]

{ #category : #private }
Kn3DObjectTest >> newStart: aCollection [
	^ Kn3DObject start: aCollection
]

{ #category : #private }
Kn3DObjectTest >> newVecX: x y: y z: z [
	^ KnVec4 x: x y: y z: z
]

{ #category : #test }
Kn3DObjectTest >> testAsTriangles [
	| o l ret |
	l := {(self newVecX: 0 y: 0 z: 0).
	(self newVecX: 0 y: 0 z: 1).
	(self newVecX: 1 y: 0 z: 1).
	(self newVecX: 1 y: 0 z: 0).
	(self newVecX: 0 y: 0 z: 0)}.
	o := self newSide: l.
	ret := o asTriangles.
	self
		assertCollection: ret
		equals:
			{{(self newVecX: 0 y: 0 z: 0).
			(self newVecX: 0 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 1)}.
			{(self newVecX: 0 y: 0 z: 0).
			(self newVecX: 1 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 0)}}.
	l := {(self newVecX: 0 y: 0 z: 0).
	(self newVecX: 0 y: 0 z: 2).
	(self newVecX: 1 y: 0 z: 2).
	(self newVecX: 2 y: 0 z: 1).
	(self newVecX: 2 y: 0 z: 0).
	(self newVecX: 0 y: 0 z: 0)}.
	o := self newSide: l.
	ret := o asTriangles.
	self
		assertCollection: ret
		equals:
			{{(self newVecX: 0 y: 0 z: 0).
			(self newVecX: 0 y: 0 z: 2).
			(self newVecX: 1 y: 0 z: 2)}.
			{(self newVecX: 0 y: 0 z: 0).
			(self newVecX: 1 y: 0 z: 2).
			(self newVecX: 2 y: 0 z: 1)}.
			{(self newVecX: 0 y: 0 z: 0).
			(self newVecX: 2 y: 0 z: 1).
			(self newVecX: 2 y: 0 z: 0)}}
]

{ #category : #test }
Kn3DObjectTest >> testIncludesPoint [
	| o |
	o := self
		newSide:
			{(KnVec4 x: 4 y: 0 z: 0).
			(KnVec4 x: 4 y: 0 z: 4).
			(KnVec4 x: 0 y: 0 z: 4)}.
	self assert: (o includesPoint: (KnVec4 x: 3 y: 0 z: 3)).
	self assert: (o includesPoint: (KnVec4 x: 3 y: 0 z: 2)).
	self assert: (o includesPoint: (KnVec4 x: 2 y: 0 z: 3)).
	self deny: (o includesPoint: (KnVec4 x: 1 y: 0 z: 1)).
	self deny: (o includesPoint: (KnVec4 x: 4 y: 0 z: -5)).
	self deny: (o includesPoint: (KnVec4 x: -5 y: 0 z: 4)).
	self deny: (o includesPoint: (KnVec4 x: 2 y: 0 z: 1)).
	self deny: (o includesPoint: (KnVec4 x: 1 y: 0 z: 2))
]

{ #category : #test }
Kn3DObjectTest >> testIsEnd [
	self deny: (self newStart: {}) isEnd.
	self deny: (self newSide: {}) isEnd.
	self assert: (self newEnd: {}) isEnd.
	self deny: (self newMove: 0) isEnd.
	self deny: (self newLine: 1) isEnd
]

{ #category : #test }
Kn3DObjectTest >> testIsLine [
	self deny: (self newStart: {}) isLine.
	self deny: (self newSide: {}) isLine.
	self deny: (self newEnd: {}) isLine.
	self deny: (self newMove: 0) isLine.
	self assert: (self newLine: 1) isLine
]

{ #category : #test }
Kn3DObjectTest >> testIsMove [
	self deny: (self newStart: {}) isMove.
	self deny: (self newSide: {}) isMove.
	self deny: (self newEnd: {}) isMove.
	self assert: (self newMove: 0) isMove.
	self deny: (self newLine: 1) isMove
]

{ #category : #test }
Kn3DObjectTest >> testIsMoveOrLine [
	self deny: (self newStart: {}) isMoveOrLine.
	self deny: (self newSide: {}) isMoveOrLine.
	self deny: (self newEnd: {}) isMoveOrLine.
	self assert: (self newMove: 0) isMoveOrLine.
	self assert: (self newLine: 1) isMoveOrLine
]

{ #category : #test }
Kn3DObjectTest >> testIsPolygon [
	self assert: (self newStart: {}) isPolygon.
	self assert: (self newSide: {}) isPolygon.
	self assert: (self newEnd: {}) isPolygon.
	self deny: (self newMove: 0) isPolygon.
	self deny: (self newLine: 1) isPolygon
]

{ #category : #test }
Kn3DObjectTest >> testIsSide [
	self deny: (self newStart: {}) isSide.
	self assert: (self newSide: {}) isSide.
	self deny: (self newEnd: {}) isSide.
	self deny: (self newMove: 0) isSide.
	self deny: (self newLine: 1) isSide
]

{ #category : #test }
Kn3DObjectTest >> testIsStart [
	self assert: (self newStart: {}) isStart.
	self deny: (self newSide: {}) isStart.
	self deny: (self newEnd: {}) isStart.
	self deny: (self newMove: 0) isStart.
	self deny: (self newLine: 1) isStart
]

{ #category : #test }
Kn3DObjectTest >> testIsTriangle [
	| o l |
	l := {(self newVecX: 1 y: 2 z: 3).
	(self newVecX: 4 y: 5 z: 6).
	(self newVecX: 7 y: 8 z: 9).
	(self newVecX: 1 y: 2 z: 3)}.
	o := self newSide: l.
	self assert: o isTriangle.
	l := {(self newVecX: 1 y: 2 z: 3).
	(self newVecX: 4 y: 5 z: 6).
	(self newVecX: 7 y: 8 z: 9)}.
	o := self newSide: l.
	self assert: o isTriangle.
	l := {(self newVecX: 1 y: 2 z: 3).
	(self newVecX: 4 y: 5 z: 6).
	(self newVecX: 7 y: 8 z: 9).
	(self newVecX: 10 y: 11 z: 12).
	(self newVecX: 1 y: 2 z: 3)}.
	o := self newSide: l.
	self deny: o isTriangle
]

{ #category : #test }
Kn3DObjectTest >> testPoint [
	| o |
	o := self newMove: (self newVecX: 1 y: 2 z: 3).
	self assertCollection: o points equals: (self newVecX: 1 y: 2 z: 3).
	o point: (self newVecX: 4 y: 5 z: 6).
	self assertCollection: o points equals: (self newVecX: 4 y: 5 z: 6)
]

{ #category : #test }
Kn3DObjectTest >> testPoints [
	| o |
	o := self
		newEnd:
			{(self newVecX: 0 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 0)}.
	self
		assertCollection: o points
		equals:
			{(self newVecX: 0 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 0)}.
	o
		points:
			{(self newVecX: 0 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 0).
			(self newVecX: 0 y: 0 z: 1)}.
	self
		assertCollection: o points
		equals:
			{(self newVecX: 0 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 0)}
]

{ #category : #test }
Kn3DObjectTest >> testPolygon [
	| o |
	o := self
		newSide:
			{(KnVec4 x: 2 y: 0 z: 0).
			(KnVec4 x: 2 y: 0 z: 2).
			(KnVec4 x: 0 y: 0 z: 2)}.
	self
		assertCollection: o polygon
		equals:
			{(KnVec4 x: 2 y: 0 z: 0).
			(KnVec4 x: 2 y: 0 z: 2).
			(KnVec4 x: 0 y: 0 z: 2).
			(KnVec4 x: 2 y: 0 z: 0)}
]

{ #category : #test }
Kn3DObjectTest >> testReduced [
	| o l1 l2 epsilon ret |
	epsilon := KnVec4 epsilon.
	l1 := {(self newVecX: 1 y: 2 z: 3).
	(self newVecX: 4 y: 5 z: 6).
	(self newVecX: 7 y: 8 z: 9).
	(self newVecX: 1 y: 2 z: 3)}.
	o := self newEnd: l1.
	ret := o reduced.
	self assert: ret isEnd.
	self assertCollection: ret points equals: {(self newVecX: 1 y: 2 z: 3).
	(self newVecX: 4 y: 5 z: 6).
	(self newVecX: 7 y: 8 z: 9)}.
	l2 := {(self newVecX: 1 y: 2 z: 3).
	(self newVecX: 1 + epsilon y: 2 z: 3).
	(self newVecX: 4 y: 5 z: 6).
	(self newVecX: 4 y: 5 + epsilon z: 6).
	(self newVecX: 7 y: 8 z: 9).
	(self newVecX: 7 y: 8 z: 9 + epsilon).
	(self newVecX: 1 y: 2 z: 3)}.
	o := self newStart: l2.
	ret := o reduced.
	self assert: ret isStart.
	self assertCollection: ret points equals: {(self newVecX: 1 y: 2 z: 3).
	(self newVecX: 4 y: 5 z: 6).
	(self newVecX: 7 y: 8 z: 9)}
]

{ #category : #test }
Kn3DObjectTest >> testType [
	| o |
	o := self newMove: (self newVecX: 1 y: 2 z: 3).
	self assert: o type equals: #move.
	o type: #start.
	self assert: o type equals: #start
]
