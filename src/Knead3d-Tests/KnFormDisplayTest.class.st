"
A Kn3DDisplayFormTest is a test class for testing the behavior of Kn3DDisplayForm
"
Class {
	#name : #KnFormDisplayTest,
	#superclass : #TestCase,
	#category : #'Knead3d-Tests'
}

{ #category : #private }
KnFormDisplayTest >> newDisplay [
	^ KnFormDisplay new
]

{ #category : #private }
KnFormDisplayTest >> sampleDisplayFile [
	| f |
	f := self samplePolygonPoints
		collect: [ :each | KnDisplayItem opcode: 2 arg: each ].
	(f at: 1) opcode: f size - 1.
	^ f
]

{ #category : #private }
KnFormDisplayTest >> samplePolygonPoints [
	^ {(7 @ 0).
	(1 @ 2).
	(3 @ 6).
	(5 @ 4).
	(9 @ 8).
	(7 @ 0)}
]

{ #category : #test }
KnFormDisplayTest >> testCanvas [
	| d |
	d := self newDisplay.
	self assert: d canvas isNil.
	d form: (Form extent: 1 @ 1).
	self assert: (d canvas isKindOf: FormCanvas).
	d canvas: nil.
	self assert: d canvas isNil
]

{ #category : #test }
KnFormDisplayTest >> testCurrent [
	| d |
	d := self newDisplay.
	self assert: d current isNil.
	d current: 1 @ 2.
	self assert: d current equals: 1 @ 2.
	d current: 3 @ 4.
	self assert: d current equals: 3 @ 4
]

{ #category : #test }
KnFormDisplayTest >> testDisplayPointsFromTo [
	| d f ret |
	d := self newDisplay.
	f := self sampleDisplayFile.
	d displayFile: f.
	ret := d displayPointsFrom: 1 to: f size.
	self
		assertCollection: ret
		equals:
			{(7 @ 0).
			(1 @ 2).
			(3 @ 6).
			(5 @ 4).
			(9 @ 8).
			(7 @ 0)}
]

{ #category : #test }
KnFormDisplayTest >> testEdgesFrom [
	| d f ret |
	d := self newDisplay.
	f := OrderedCollection new.
	f
		add: (KnDisplayItem opcode: 3 arg: 0 @ 99);
		add: (KnDisplayItem opcode: 2 arg: 49 @ 49);
		add: (KnDisplayItem opcode: 2 arg: 0 @ 0);
		add: (KnDisplayItem opcode: 2 arg: 0 @ 99).
	d displayFile: f.
	ret := d edgesFrom: 1.
	self
		assertCollection: ret
		equals:
			{{(0 @ 99).
			(49 @ 49)}.
			{(49 @ 49).
			(0 @ 0)}.
			{(0 @ 0).
			(0 @ 99)}} asOrderedCollection.
	f := OrderedCollection new.
	f
		add: (KnDisplayItem opcode: 3 arg: 0 @ 99);
		add: (KnDisplayItem opcode: 2 arg: 49 @ 49);
		add: (KnDisplayItem opcode: 2 arg: 0 @ 49);
		add: (KnDisplayItem opcode: 2 arg: 0 @ 99).
	d displayFile: f.
	ret := d edgesFrom: 1.
	self
		assertCollection: ret
		equals:
			{{(0 @ 99).
			(49 @ 49)}.
			{(0 @ 49).
			(0 @ 99)}} asOrderedCollection.
	d displayFile: self sampleDisplayFile.
	ret := d edgesFrom: 1.
	self
		assertCollection: ret
		equals:
			{{(7 @ 0). (1 @ 2)}.
			{(1 @ 2). (3 @ 6)}.
			{(3 @ 6). (5 @ 4)}.
			{(5 @ 4). (9 @ 8)}.
			{(9 @ 8). (7 @ 0)}} asOrderedCollection
]

{ #category : #test }
KnFormDisplayTest >> testForm [
	| d |
	d := self newDisplay.
	d form: (Form extent: 10 @ 20 depth: 2).
	self assert: d form isForm.
	self assert: (d canvas isKindOf: FormCanvas)
]

{ #category : #test }
KnFormDisplayTest >> testHeight [
	| d |
	d := self newDisplay.
	d form: (Form extent: 10 @ 20 depth: 2).
	self assert: d height equals: 20
]

{ #category : #test }
KnFormDisplayTest >> testIncludeEdgeStartingScanIn [
	| d edges ret f |
	d := self newDisplay.
	edges := OrderedCollection new.
	edges add: (KnEdgeInfo from: 1 @ 4 to: 2 @ 3).
	edges add: (KnEdgeInfo from: 1 @ 5 to: 2 @ 1).
	edges add: (KnEdgeInfo from: 5 @ 3 to: 2 @ 6).
	edges sort: [ :a :b | a yMax > b yMax ].
	ret := d includeEdgeStarting: 1 scan: 7 in: edges.
	self assert: ret equals: 1.
	ret := d includeEdgeStarting: 1 scan: 6 in: edges.
	self assert: ret equals: 2.
	ret := d includeEdgeStarting: 1 scan: 5 in: edges.
	self assert: ret equals: 3.
	ret := d includeEdgeStarting: 1 scan: 4 in: edges.
	self assert: ret equals: 4.
	ret := d includeEdgeStarting: 2 scan: 7 in: edges.
	self assert: ret equals: 2.
	ret := d includeEdgeStarting: 2 scan: 6 in: edges.
	self assert: ret equals: 2.
	ret := d includeEdgeStarting: 2 scan: 5 in: edges.
	self assert: ret equals: 3.
	ret := d includeEdgeStarting: 2 scan: 4 in: edges.
	self assert: ret equals: 4.
	f := self sampleDisplayFile.
	d displayFile: f.
	d form: (Form extent: 10 @ 10 depth: 2).
	edges := d loadPolygonFrom: 1.
	ret := d includeEdgeStarting: 1 scan: 8 in: edges.
	self assert: ret equals: 3
]

{ #category : #test }
KnFormDisplayTest >> testLineColor [
	| d |
	d := self newDisplay.
	self assert: d lineColor equals: Color white.
	d lineColor: Color red.
	self assert: d lineColor equals: Color red
]

{ #category : #test }
KnFormDisplayTest >> testLineWidth [
	| d |
	d := self newDisplay.
	self assert: d lineWidth equals: 1
]

{ #category : #test }
KnFormDisplayTest >> testLoadPolygonFrom [
	| d f ret |
	d := self newDisplay.
	f := OrderedCollection new.
	f
		add: (KnDisplayItem opcode: 3 arg: 0 @ 0);
		add: (KnDisplayItem opcode: 2 arg: 0.5 @ 0.5);
		add: (KnDisplayItem opcode: 2 arg: 0 @ 1);
		add: (KnDisplayItem opcode: 2 arg: 0 @ 0).
	d displayFile: f.
	ret := d loadPolygonFrom: 1.
	self assertCollection: ret size equals: 3.
	self assert: ret first yMax equals: 1.
	self assert: ret first yMin equals: 0.
	self assert: ret second yMax equals: 1.
	self assert: ret second yMin equals: 0.5.
	self assert: ret third yMax equals: 0.5.
	self assert: ret third yMin equals: 0.
	f := self sampleDisplayFile.
	d displayFile: f.
	ret := d loadPolygonFrom: 1.
	self assert: ret size equals: 5.
	self assert: ret first yMax equals: 8.
	self assert: ret first yMin equals: 0.
	self assert: ret first xa equals: 9.
	self assert: ret second yMax equals: 8.
	self assert: ret second yMin equals: 4.
	self assert: ret second xa equals: 9.
	self assert: ret third yMax equals: 6.
	self assert: ret third yMin equals: 4.
	self assert: ret third xa equals: 3.
	self assert: ret fourth yMax equals: 6.
	self assert: ret fourth yMin equals: 2.
	self assert: ret fourth xa equals: 3.
	self assert: ret fifth yMax equals: 2.
	self assert: ret fifth yMin equals: 0.
	self assert: ret fifth xa equals: 1	
]

{ #category : #test }
KnFormDisplayTest >> testSampleDisplayFile [
	| f |
	f := self sampleDisplayFile.
	self assert: f size equals: 6.
	self assert: f first opcode equals: 5.
	2 to: 6 do: [ :each | self assert: (f at: each) opcode equals: 2 ]
]

{ #category : #test }
KnFormDisplayTest >> testUpdateXValuesFromToScan [
	| d f edges ret |
	d := self newDisplay.
	f := self sampleDisplayFile.
	d displayFile: f.
	d form: (Form extent: 10 @ 10 depth: 2).
	edges := d loadPolygonFrom: 1.
	self assert: edges first dx equals: -0.25.
	self assert: edges second dx equals: -1.
	ret := d updateXValues: edges from: 1 to: 2 scan: 7.
	self assert: ret equals: 1.
	self assert: edges first yMin equals: 0.
	self assert: edges first xa equals: 8.75.
	self assert: edges first dx equals: -0.25.
	self assert: edges second yMin equals: 4.
	self assert: edges second xa equals: 8.
	self assert: edges second dx equals: -1
]

{ #category : #test }
KnFormDisplayTest >> testWidth [
	| d |
	d := self newDisplay.
	d form: (Form extent: 10 @ 20 depth: 2).
	self assert: d width equals: 10
]

{ #category : #test }
KnFormDisplayTest >> testXsortFromTo [
	| d f edges tmp1 tmp2 |
	d := self newDisplay.
	f := self sampleDisplayFile.
	d displayFile: f.
	d form: (Form extent: 10 @ 10 depth: 2).
	edges := d loadPolygonFrom: 1.
	tmp1 := edges first copy.
	tmp2 := edges second copy.
	d xsort: edges from: 1 to: 2.
	self assert: edges first equals: tmp1.
	self assert: edges second equals: tmp2
]
