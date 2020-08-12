"
A KnTriangulatorTest is a test class for testing the behavior of KnTriangulator
"
Class {
	#name : #KnTriangulatorTest,
	#superclass : #TestCase,
	#category : #'Knead3d-Tests'
}

{ #category : #private }
KnTriangulatorTest >> newTriangulator [
	^ KnTriangulator new
]

{ #category : #private }
KnTriangulatorTest >> newVecX: x y: y z: z [
	^ KnVec4 x: x y: y z: z
]

{ #category : #private }
KnTriangulatorTest >> polygon1 [
	^ {(2 @ 0).
	(1 @ 3).
	(0 @ 0)}
]

{ #category : #private }
KnTriangulatorTest >> polygon2 [
	^ {(0 @ 0).
	(1 @ 1).
	(2 @ 1).
	(1 @ 3)}
]

{ #category : #private }
KnTriangulatorTest >> polygon3 [
	^ {(0 @ 0).
	(2 @ 0).
	(2 @ 3).
	(1 @ 1).
	(0 @ 3)}
]

{ #category : #private }
KnTriangulatorTest >> polygon4 [
	^ {(0 @ 0).
	(2 @ 3).
	(3 @ 0).
	(3 @ 5).
	(1 @ 2).
	(0 @ 4)}
]

{ #category : #private }
KnTriangulatorTest >> polygon5 [
	^ {(0 @ 2).
	(3 @ 0).
	(5 @ 2).
	(5 @ 4).
	(3 @ 6).
	(0 @ 3).
	(3 @ 5).
	(4 @ 3).
	(3 @ 1)}
]

{ #category : #test }
KnTriangulatorTest >> testCalcNormal2Of [
	| b in out |
	b := self newTriangulator.
	in := {(self newVecX: 2 y: 1 z: 0).
	(self newVecX: 1 y: 1 z: 0).
	(self newVecX: 1 y: 2 z: 0).
	(self newVecX: 0 y: 0 z: 0)}.
	out := b calcNormal2Of: in.
	self assert: out equals: (self newVecX: 0 y: 0 z: 1).
	in := {(self newVecX: 2 y: 1 z: 0).
	(self newVecX: 1 y: 2 z: 0).
	(self newVecX: 1 y: 1 z: 0)}.
	out := b calcNormal2Of: in.
	self assert: out equals: (self newVecX: 0 y: 0 z: 1).
	in := {(self newVecX: 0 y: 0 z: 0).
	(self newVecX: 2 y: 1 z: 0).
	(self newVecX: 1 y: 1 z: 0)}.
	out := b calcNormal2Of: in.
	self assert: out equals: (self newVecX: 0 y: 0 z: 1).
	in := {(self newVecX: 1 y: 1 z: 0).
	(self newVecX: 1 y: 2 z: 0).
	(self newVecX: 0 y: 0 z: 0)}.
	out := b calcNormal2Of: in.
	self assert: out equals: (self newVecX: 0 y: 0 z: 1).
	in := {(self newVecX: 2 y: 1 z: 0).
	(self newVecX: 1 y: 1 z: 0).
	(self newVecX: 1 y: 2 z: 0)}.
	out := b calcNormal2Of: in.
	self assert: out equals: (self newVecX: 0 y: 0 z: -1).
	in := {(self newVecX: 0 y: 0 z: 0).
	(self newVecX: 1 y: 2 z: 0).
	(self newVecX: 1 y: 1 z: 0)}.
	out := b calcNormal2Of: in.
	self assert: out equals: (self newVecX: 0 y: 0 z: -1)
]

{ #category : #test }
KnTriangulatorTest >> testClipEarsFrom [
	| t in out |
	t := self newTriangulator.
	in := {(self newVecX: 0 y: 0 z: 0).
	(self newVecX: 0 y: 0 z: 1).
	(self newVecX: 1 y: 0 z: 1).
	(self newVecX: 1 y: 0 z: 0).
	(self newVecX: 0 y: 0 z: 0)}.
	out := t clipEarsFrom: in.
	self
		assertCollection: out
		equals:
			{{(self newVecX: 0 y: 0 z: 0).
			(self newVecX: 0 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 1)}.
			{(self newVecX: 0 y: 0 z: 0).
			(self newVecX: 1 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 0)}}.
	in := {(self newVecX: 0 y: 0 z: 0).
	(self newVecX: 0 y: 0 z: 2).
	(self newVecX: 1 y: 0 z: 2).
	(self newVecX: 2 y: 0 z: 1).
	(self newVecX: 2 y: 0 z: 0).
	(self newVecX: 0 y: 0 z: 0)}.
	out := t clipEarsFrom: in.
	self
		assertCollection: out
		equals:
			{{(self newVecX: 0 y: 0 z: 0).
			(self newVecX: 0 y: 0 z: 2).
			(self newVecX: 1 y: 0 z: 2)}.
			{(self newVecX: 0 y: 0 z: 0).
			(self newVecX: 1 y: 0 z: 2).
			(self newVecX: 2 y: 0 z: 1)}.
			{(self newVecX: 0 y: 0 z: 0).
			(self newVecX: 2 y: 0 z: 1).
			(self newVecX: 2 y: 0 z: 0)}}.
	in := {(self newVecX: 0 y: 0 z: 0).
	(self newVecX: 2 y: 1 z: 0).
	(self newVecX: 1 y: 1 z: 0).
	(self newVecX: 1 y: 2 z: 0)}.
	out := t clipEarsFrom: in.
	self
		assertCollection: out
		equals:
			{{(self newVecX: 0 y: 0 z: 0).
			(self newVecX: 2 y: 1 z: 0).
			(self newVecX: 1 y: 1 z: 0)}.
			{(self newVecX: 0 y: 0 z: 0).
			(self newVecX: 1 y: 1 z: 0).
			(self newVecX: 1 y: 2 z: 0)}}.
	in := {(self newVecX: 2 y: 1 z: 0).
	(self newVecX: 1 y: 1 z: 0).
	(self newVecX: 1 y: 2 z: 0).
	(self newVecX: 0 y: 0 z: 0)}.
	out := t clipEarsFrom: in.
	self
		assertCollection: out
		equals:
			{{(self newVecX: 1 y: 1 z: 0).
			(self newVecX: 1 y: 2 z: 0).
			(self newVecX: 0 y: 0 z: 0)}.
			{(self newVecX: 1 y: 1 z: 0).
			(self newVecX: 0 y: 0 z: 0).
			(self newVecX: 2 y: 1 z: 0)}}.
	in := {(self newVecX: 10.0 y: 0.0 z: 0.0).
	(self
		newVecX: 13.090169906616211
		y: 1.8144820046472887e-7
		z: 9.510563850402832).
	(self newVecX: 5.0 y: 1.3119467894284753e-6 z: 15.388415336608887).
	(self
		newVecX: -3.090169906616211
		y: 1.8144820046472887e-7
		z: 9.510563850402832).
	(self newVecX: 0.0 y: 0.0 z: 0.0)}.
	out := t clipEarsFrom: in.
	self
		assertCollection: out
		equals:
			{{(KnVec4 x: 10.0 y: 0.0 z: 0.0).
			(KnVec4
				x: 13.090169906616211
				y: 1.8144820046472887e-7
				z: 9.510563850402832).
			(KnVec4 x: 5.0 y: 1.3119467894284753e-6 z: 15.388415336608887)}.
			{(KnVec4 x: 10.0 y: 0.0 z: 0.0).
			(KnVec4 x: 5.0 y: 1.3119467894284753e-6 z: 15.388415336608887).
			(KnVec4
				x: -3.090169906616211
				y: 1.8144820046472887e-7
				z: 9.510563850402832)}.
			{(KnVec4 x: 10.0 y: 0.0 z: 0.0).
			(KnVec4
				x: -3.090169906616211
				y: 1.8144820046472887e-7
				z: 9.510563850402832).
			(KnVec4 x: 0.0 y: 0.0 z: 0.0)}}
]

{ #category : #test }
KnTriangulatorTest >> testIsConvex [
	| t v1 v2 v3 |
	t := self newTriangulator.
	v1 := self newVecX: 0 y: 0 z: 1.
	v2 := self newVecX: 1 y: 0 z: 1.
	v3 := self newVecX: 0 y: 1 z: 1.
	self
		assert:
			(t
				isConvex:
					{v1.
					v2.
					v3}).
	v1 := self newVecX: 2 y: 2 z: 1.
	v2 := self newVecX: 1 y: 0 z: 1.
	v3 := self newVecX: 0 y: 1 z: 1.
	self
		assert:
			(t
				isConvex:
					{v1.
					v2.
					v3}).
	v1 := self newVecX: 0 y: 0 z: 1.
	v2 := self newVecX: 1 y: 0 z: 1.
	v3 := self newVecX: 2 y: 0 z: 1.
	self
		deny:
			(t
				isConvex:
					{v1.
					v2.
					v3}).
	v1 := self newVecX: 0 y: 0 z: 1.
	v2 := self newVecX: 1 y: 1 z: 1.
	v3 := self newVecX: 2 y: 2 z: 1.
	self
		deny:
			(t
				isConvex:
					{v1.
					v2.
					v3})
]

{ #category : #test }
KnTriangulatorTest >> testNaiveTrianglesFrom [
	| t in out |
	t := self newTriangulator.
	in := {(self newVecX: 0 y: 0 z: 0).
	(self newVecX: 0 y: 0 z: 1).
	(self newVecX: 1 y: 0 z: 1).
	(self newVecX: 1 y: 0 z: 0).
	(self newVecX: 0 y: 0 z: 0)}.
	out := t naiveTrianglesFrom: in.
	self
		assertCollection: out
		equals:
			{{(self newVecX: 0 y: 0 z: 0).
			(self newVecX: 0 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 1)}.
			{(self newVecX: 0 y: 0 z: 0).
			(self newVecX: 1 y: 0 z: 1).
			(self newVecX: 1 y: 0 z: 0)}}.
	in := {(self newVecX: 0 y: 0 z: 0).
	(self newVecX: 0 y: 0 z: 2).
	(self newVecX: 1 y: 0 z: 2).
	(self newVecX: 2 y: 0 z: 1).
	(self newVecX: 2 y: 0 z: 0).
	(self newVecX: 0 y: 0 z: 0)}.
	out := t naiveTrianglesFrom: in.
	self
		assertCollection: out
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
KnTriangulatorTest >> testRemoveCollinearPoints [
	| t in out |
	t := self newTriangulator.
	in := {(self newVecX: 0 y: 0 z: 0).
	(self newVecX: 2 y: 0 z: 0).
	(self newVecX: 2 y: 2 z: 0)}.
	out := t removeCollinearPoints: in.
	self assertCollection: out equals: in.
	in := {(self newVecX: 0 y: 0 z: 0).
	(self newVecX: 1 y: 0 z: 0).
	(self newVecX: 2 y: 0 z: 0).
	(self newVecX: 2 y: 1 z: 0).
	(self newVecX: 2 y: 2 z: 0).
	(self newVecX: 1 y: 1 z: 0)}.
	out := t removeCollinearPoints: in.
	self
		assertCollection: out
		equals:
			{(self newVecX: 0 y: 0 z: 0).
			(self newVecX: 2 y: 0 z: 0).
			(self newVecX: 2 y: 2 z: 0)}
]

{ #category : #test }
KnTriangulatorTest >> testTriangleContains [
	| t v1 v2 v3 tri |
	t := self newTriangulator.
	v1 := self newVecX: 0 y: 0 z: 1.
	v2 := self newVecX: 2 y: 0 z: 1.
	v3 := self newVecX: 0 y: 2 z: 1.
	tri := {v1.
	v2.
	v3}.
	self assert: (t triangle: tri contains: (self newVecX: 0.5 y: 0.5 z: 1)).
	self assert: (t triangle: tri contains: (self newVecX: 0.9 y: 0.9 z: 1)).
	self deny: (t triangle: tri contains: (self newVecX: 1.1 y: 1.1 z: 1)).
	self deny: (t triangle: tri contains: (self newVecX: 3 y: 0 z: 1))
]

{ #category : #test }
KnTriangulatorTest >> testTriangleContainsAll [
	| t v1 v2 v3 tri |
	t := self newTriangulator.
	v1 := self newVecX: 0 y: 0 z: 1.
	v2 := self newVecX: 2 y: 0 z: 1.
	v3 := self newVecX: 0 y: 2 z: 1.
	tri := {v1.
	v2.
	v3}.
	self
		assert: (t triangle: tri containsAll: {(self newVecX: 1 y: 0.1 z: 1)}).
	self deny: (t triangle: tri containsAll: {(self newVecX: 3 y: 0 z: 1)}).
	self
		assert:
			(t
				triangle: tri
				containsAll:
					{(self newVecX: 1 y: 0.1 z: 1).
					(self newVecX: 0.1 y: 1 z: 1)}).
	self
		deny:
			(t
				triangle: tri
				containsAll:
					{(self newVecX: 4 y: 0 z: 1).
					(self newVecX: 3 y: 0 z: 1)}).
	self
		deny:
			(t
				triangle: tri
				containsAll:
					{(self newVecX: 1 y: 0.1 z: 1).
					(self newVecX: 3 y: 0 z: 1)})
]

{ #category : #test }
KnTriangulatorTest >> testTriangleOn [
	| t v1 v2 v3 tri |
	t := self newTriangulator.
	v1 := self newVecX: 0 y: 0 z: 1.
	v2 := self newVecX: 2 y: 0 z: 1.
	v3 := self newVecX: 0 y: 2 z: 1.
	tri := {v1.
	v2.
	v3}.
	self assert: (t triangle: tri on: (self newVecX: 0 y: 0 z: 1)).
	self assert: (t triangle: tri on: (self newVecX: 2 y: 0 z: 1)).
	self assert: (t triangle: tri on: (self newVecX: 0 y: 2 z: 1)).
	self assert: (t triangle: tri on: (self newVecX: 1 y: 0 z: 1)).
	self assert: (t triangle: tri on: (self newVecX: 0 y: 1 z: 1)).
	self assert: (t triangle: tri on: (self newVecX: 1 y: 1 z: 1)).
	self assert: (t triangle: tri on: (self newVecX: 10 y: 10 z: 1)).
	self deny: (t triangle: tri on: (self newVecX: 0 y: 0 z: 2)).
	self deny: (t triangle: tri on: (self newVecX: 2 y: 0 z: 2)).
	self deny: (t triangle: tri on: (self newVecX: 0 y: 2 z: 2)).
	self deny: (t triangle: tri on: (self newVecX: 1 y: 0 z: 2)).
	self deny: (t triangle: tri on: (self newVecX: 0 y: 1 z: 2)).
	self deny: (t triangle: tri on: (self newVecX: 1 y: 1 z: 2)).
	self deny: (t triangle: tri on: (self newVecX: 0 y: 0 z: 0)).
	self deny: (t triangle: tri on: (self newVecX: 2 y: 0 z: 0)).
	self deny: (t triangle: tri on: (self newVecX: 0 y: 2 z: 0)).
	self deny: (t triangle: tri on: (self newVecX: 1 y: 0 z: 0)).
	self deny: (t triangle: tri on: (self newVecX: 0 y: 1 z: 0)).
	self deny: (t triangle: tri on: (self newVecX: 1 y: 1 z: 0))
]

{ #category : #test }
KnTriangulatorTest >> testValidTriangles [
	| t in out |
	t := self newTriangulator.
	in := {{(self newVecX: 0 y: 0 z: 0).
	(self newVecX: 1 y: 1 z: 0).
	(self newVecX: 2 y: 2 z: 0)}.
	{(self newVecX: 0 y: 0 z: 0).
	(self newVecX: 1 y: 1 z: 0).
	(self newVecX: 1 y: 0 z: 0)}.
	{(self newVecX: 0 y: 0 z: 0).
	(self newVecX: 1 y: 0 z: 0).
	(self newVecX: 2 y: 0 z: 0)}}.
	out := t validTriangles: in.
	self
		assertCollection: out
		equals:
			{{(self newVecX: 0 y: 0 z: 0).
			(self newVecX: 1 y: 1 z: 0).
			(self newVecX: 1 y: 0 z: 0)}}
]
