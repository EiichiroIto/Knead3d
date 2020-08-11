Class {
	#name : #KnClippingContext,
	#superclass : #Object,
	#instVars : [
		'firstVecs',
		'lastVecs',
		'firstOps',
		'closing',
		'isClippingPolygon',
		'countIn',
		'needFirsts',
		'tOps',
		'tVecs',
		'clipValues',
		'displayFile',
		'viewportPoint',
		'viewportExtent',
		'clipOrigin'
	],
	#category : #'Knead3d-Core'
}

{ #category : #api }
KnClippingContext >> clip: vec4 opcode: opcode [
	isClippingPolygon
		ifTrue: [ ^ self clipPolygonEdge: vec4 opcode: opcode ].
	opcode <= 2
		ifTrue: [ ^ self clipBack: vec4 opcode: opcode ].
	isClippingPolygon := true.
	countIn := opcode.
	self resetTBuffer.
	self resetLasts: vec4
]

{ #category : #private }
KnClippingContext >> clipBack: vec4 opcode: opcode [
	| bz |
	self isClipBack
		ifFalse: [ ^ self clipFront: vec4 opcode: opcode ].
	bz := self clipValueAt: #back.
	(self isClippingPolygon and: [ self needFirstAt: #back ])
		ifTrue: [ self needFirstAt: #back put: false.
			self firstVecAt: #back put: vec4.
			self firstOpAt: #back put: opcode ]
		ifFalse: [ (vec4 z <= bz and: [ (self lastVecAt: #back) z < bz ])
				ifTrue: [ self clipFront: (self vec: vec4 zOf: #back) opcode: 1 ]
				ifFalse: [ (vec4 z <= bz and: [ (self lastVecAt: #back) z > bz ])
						ifTrue: [ self
								clipFront: (self vec: vec4 zOf: #back)
								opcode:
									(opcode > 0
										ifTrue: [ opcode ]
										ifFalse: [ 1 ]) ] ] ].
	self lastVecAt: #back put: vec4.
	(vec4 z >= bz and: [ closing ~= #back ])
		ifTrue: [ self clipFront: vec4 opcode: opcode ]
]

{ #category : #private }
KnClippingContext >> clipBottom: vec4 opcode: opcode [
	| by |
	by := self clipValueAt: #bottom.
	(self isClippingPolygon and: [ self needFirstAt: #bottom ])
		ifTrue: [ self needFirstAt: #bottom put: false.
			self firstVecAt: #bottom put: vec4.
			self firstOpAt: #bottom put: opcode ]
		ifFalse: [ (vec4 y >= by and: [ (self lastVecAt: #bottom) y < by ])
				ifTrue: [ self clipTop: (self vec: vec4 yOf: #bottom) opcode: 1 ]
				ifFalse: [ (vec4 y <= by and: [ (self lastVecAt: #bottom) y > by ])
						ifTrue: [ self
								clipTop: (self vec: vec4 yOf: #bottom)
								opcode:
									(opcode > 0
										ifTrue: [ opcode ]
										ifFalse: [ 1 ]) ] ] ].
	self lastVecAt: #bottom put: vec4.
	(vec4 y >= by and: [ closing ~= #bottom ])
		ifTrue: [ self clipTop: vec4 opcode: opcode ]
]

{ #category : #private }
KnClippingContext >> clipFront: vec4 opcode: opcode [
	| fz |
	vec4 ifNil: [ ^ self ].
	self isClipFront
		ifFalse: [ ^ self clipLeft: vec4 opcode: opcode ].
	fz := self clipValueAt: #front.
	(self isClippingPolygon and: [ self needFirstAt: #front ])
		ifTrue: [ self needFirstAt: #front put: false.
			self firstVecAt: #front put: vec4.
			self firstOpAt: #front put: opcode ]
		ifFalse: [ (vec4 z <= fz and: [ (self lastVecAt: #front) z > fz ])
				ifTrue: [ self clipLeft: (self vec: vec4 zOf: #front) opcode: 1 ]
				ifFalse: [ (vec4 z >= fz and: [ (self lastVecAt: #front) z < fz ])
						ifTrue: [ self
								clipLeft: (self vec: vec4 zOf: #front)
								opcode:
									(opcode > 0
										ifTrue: [ opcode ]
										ifFalse: [ 1 ]) ] ] ].
	self lastVecAt: #front put: vec4.
	(vec4 z <= fz and: [ closing ~= #front ])
		ifTrue: [ self clipLeft: vec4 opcode: opcode ]
]

{ #category : #private }
KnClippingContext >> clipLeft: vec4 opcode: opcode [
	| lx |
	lx := self clipValueAt: #left.
	(self isClippingPolygon and: [ self needFirstAt: #left ])
		ifTrue: [ self needFirstAt: #left put: false.
			self firstVecAt: #left put: vec4.
			self firstOpAt: #left put: opcode ]
		ifFalse: [ (vec4 x >= lx and: [ (self lastVecAt: #left) x < lx ])
				ifTrue: [ self clipRight: (self vec: vec4 xOf: #left) opcode: 1 ]
				ifFalse: [ (vec4 x <= lx and: [ (self lastVecAt: #left) x > lx ])
						ifTrue: [ self
								clipRight: (self vec: vec4 xOf: #left)
								opcode:
									(opcode > 0
										ifTrue: [ opcode ]
										ifFalse: [ 1 ]) ] ] ].
	self lastVecAt: #left put: vec4.
	(vec4 x >= lx and: [ closing ~= #left ])
		ifTrue: [ self clipRight: vec4 opcode: opcode ]
]

{ #category : #accessing }
KnClippingContext >> clipOrigin [
	^ clipOrigin
]

{ #category : #private }
KnClippingContext >> clipPolygonEdge: vec4 opcode: opcode [
	countIn := countIn - 1.
	self clipBack: vec4 opcode: opcode.
	countIn > 0
		ifTrue: [ ^ self ].
	self closing: #back.
	(self isClipBack and: [ (self needFirstAt: #back) not ])
		ifTrue: [ self
				clipBack: (self firstVecAt: #back)
				opcode: (self firstOpAt: #back) ].
	self closing: #front.
	(self isClipFront and: [ (self needFirstAt: #front) not ])
		ifTrue: [ self
				clipFront: (self firstVecAt: #front)
				opcode: (self firstOpAt: #front) ].
	self closing: #left.
	(self needFirstAt: #left)
		ifFalse: [ self
				clipLeft: (self firstVecAt: #left)
				opcode: (self firstOpAt: #left) ].
	self closing: #right.
	(self needFirstAt: #right)
		ifFalse: [ self
				clipRight: (self firstVecAt: #right)
				opcode: (self firstOpAt: #right) ].
	self closing: #bottom.
	(self needFirstAt: #bottom)
		ifFalse: [ self
				clipBottom: (self firstVecAt: #bottom)
				opcode: (self firstOpAt: #bottom) ].
	self closing: #top.
	(self needFirstAt: #top)
		ifFalse:
			[ self clipTop: (self firstVecAt: #top) opcode: (self firstOpAt: #top) ].
	self closing: #none.
	isClippingPolygon := false.
	tOps size < 3
		ifTrue: [ ^ self ].
	self isBackFace
		ifTrue: [ ^ self ].
	tVecs last in: [ :v | self viewingTransform: v opcode: tVecs size ].
	tVecs with: tOps do: [ :v :op | self viewingTransform: v opcode: op ]
]

{ #category : #private }
KnClippingContext >> clipRight: vec4 opcode: opcode [
	| rx |
	rx := self clipValueAt: #right.
	(self isClippingPolygon and: [ self needFirstAt: #right ])
		ifTrue: [ self needFirstAt: #right put: false.
			self firstVecAt: #right put: vec4.
			self firstOpAt: #right put: opcode ]
		ifFalse: [ (vec4 x <= rx and: [ (self lastVecAt: #right) x > rx ])
				ifTrue: [ self clipBottom: (self vec: vec4 xOf: #right) opcode: 1 ]
				ifFalse: [ (vec4 x >= rx and: [ (self lastVecAt: #right) x < rx ])
						ifTrue: [ self
								clipBottom: (self vec: vec4 xOf: #right)
								opcode:
									(opcode > 0
										ifTrue: [ opcode ]
										ifFalse: [ 1 ]) ] ] ].
	self lastVecAt: #right put: vec4.
	(vec4 x <= rx and: [ closing ~= #right ])
		ifTrue: [ self clipBottom: vec4 opcode: opcode ]
]

{ #category : #private }
KnClippingContext >> clipTop: vec4 opcode: opcode [
	| ty |
	ty := self clipValueAt: #top.
	(self isClippingPolygon and: [ self needFirstAt: #top ])
		ifTrue: [ self needFirstAt: #top put: false.
			self firstVecAt: #top put: vec4.
			self firstOpAt: #top put: opcode ]
		ifFalse: [ (vec4 y <= ty and: [ (self lastVecAt: #top) y > ty ])
				ifTrue: [ self saveClippedPoint: (self vec: vec4 yOf: #top) opcode: 1 ]
				ifFalse: [ (vec4 y >= ty and: [ (self lastVecAt: #top) y < ty ])
						ifTrue: [ self
								saveClippedPoint: (self vec: vec4 yOf: #top)
								opcode:
									(opcode > 0
										ifTrue: [ opcode ]
										ifFalse: [ 1 ]) ] ] ].
	self lastVecAt: #top put: vec4.
	(vec4 y <= ty and: [ closing ~= #top ])
		ifTrue: [ self saveClippedPoint: vec4 opcode: opcode ]
]

{ #category : #accessing }
KnClippingContext >> clipValueAt: aSymbol [
	^ clipValues at: aSymbol ifAbsent: [ nil ]
]

{ #category : #accessing }
KnClippingContext >> clipValueAt: aSymbol put: aNumber [
	clipValues at: aSymbol put: aNumber
]

{ #category : #accessing }
KnClippingContext >> clipValues [
	^ clipValues
]

{ #category : #accessing }
KnClippingContext >> closing [
	^ closing
]

{ #category : #accessing }
KnClippingContext >> closing: aSymbol [
	closing := aSymbol
]

{ #category : #api }
KnClippingContext >> displayFile [
	^ displayFile
]

{ #category : #api }
KnClippingContext >> displayFile: aCollection [
	displayFile := aCollection
]

{ #category : #private }
KnClippingContext >> firstOpAt: aSymbol [
	^ firstOps at: aSymbol
]

{ #category : #private }
KnClippingContext >> firstOpAt: aSymbol put: opcode [
	firstOps at: aSymbol put: opcode
]

{ #category : #accessing }
KnClippingContext >> firstOps [
	^ firstOps
]

{ #category : #private }
KnClippingContext >> firstVecAt: aSymbol [
	^ firstVecs at: aSymbol
]

{ #category : #private }
KnClippingContext >> firstVecAt: aSymbol put: vec4 [
	firstVecs at: aSymbol put: vec4
]

{ #category : #accessing }
KnClippingContext >> firstVecs [
	^ firstVecs
]

{ #category : #api }
KnClippingContext >> frontZ: frontZ backZ: backZ [
	self
		clipValueAt: #front put: frontZ;
		clipValueAt: #back put: backZ
]

{ #category : #initialization }
KnClippingContext >> initialize [
	self reset
]

{ #category : #testing }
KnClippingContext >> isBackFace [
	| c j |
	c := 0.
	tVecs
		withIndexDo: [ :each :index | 
			j := index = tVecs size
				ifTrue: [ 1 ]
				ifFalse: [ index + 1 ].
			c := c + ((each x - (tVecs at: j) x) * (each y + (tVecs at: j) y)) ].
	^ c < 0
]

{ #category : #testing }
KnClippingContext >> isClipBack [
	^ (self clipValueAt: #back) notNil
]

{ #category : #testing }
KnClippingContext >> isClipFront [
	^ (self clipValueAt: #front) notNil
]

{ #category : #accessing }
KnClippingContext >> isClippingPolygon [
	^ isClippingPolygon
]

{ #category : #accessing }
KnClippingContext >> isClippingPolygon: aBoolean [
	isClippingPolygon := aBoolean
]

{ #category : #private }
KnClippingContext >> lastVecAt: aSymbol [
	^ lastVecs at: aSymbol ifAbsent: [ KnVec4 x: 0 y: 0 z: 0 ]
]

{ #category : #private }
KnClippingContext >> lastVecAt: aSymbol put: vec4 [
	lastVecs at: aSymbol put: vec4
]

{ #category : #accessing }
KnClippingContext >> lastVecs [
	^ lastVecs
]

{ #category : #accessing }
KnClippingContext >> needFirstAt: aSymbol [
	^ needFirsts at: aSymbol
]

{ #category : #accessing }
KnClippingContext >> needFirstAt: aSymbol put: aBoolean [
	needFirsts at: aSymbol put: aBoolean
]

{ #category : #accessing }
KnClippingContext >> needFirsts [
	^ needFirsts
]

{ #category : #private }
KnClippingContext >> putInTBuffer: vec4 opcode: opcode [
	tOps add: opcode.
	tVecs add: vec4
]

{ #category : #api }
KnClippingContext >> reset [
	firstVecs := Dictionary new.
	lastVecs := Dictionary new.
	firstOps := Dictionary new.
	needFirsts := Dictionary new.
	clipValues := Dictionary new.
	isClippingPolygon := false.
	closing := nil.
	self viewportPoint: nil.
	self viewportExtent: nil.
	#(#back #front #left #right #top #bottom)
		do: [ :each | 
			lastVecs at: each put: KnVec4 zero.
			needFirsts at: each put: false ]
]

{ #category : #private }
KnClippingContext >> resetLasts: vec4 [
	#(#back #front #left #right #top #bottom)
		do: [ :each | 
			lastVecs at: each put: vec4.
			needFirsts at: each put: true ]
]

{ #category : #private }
KnClippingContext >> resetTBuffer [
	tOps := OrderedCollection new.
	tVecs := OrderedCollection new
]

{ #category : #private }
KnClippingContext >> saveClippedPoint: vec4 opcode: opcode [
	isClippingPolygon
		ifTrue: [ self putInTBuffer: vec4 opcode: opcode ]
		ifFalse: [ self viewingTransform: vec4 opcode: opcode ]
]

{ #category : #api }
KnClippingContext >> setupViewport [
	| v br |
	v := self clipValueAt: #viewport.
	self viewportPoint: v first @ v third.
	clipOrigin := (self clipValueAt: #left) @ (self clipValueAt: #bottom).
	br := (self clipValueAt: #right) @ (self clipValueAt: #top).
	self viewportExtent: (v second @ v fourth - self viewportPoint)
		/ (br - clipOrigin)
]

{ #category : #accessing }
KnClippingContext >> tOps [
	^ tOps
]

{ #category : #accessing }
KnClippingContext >> tVecs [
	^ tVecs
]

{ #category : #private }
KnClippingContext >> vec: vec4 xOf: aSymbol [
	| last x y z v d |
	x := vec4 x.
	y := vec4 y.
	z := vec4 z.
	last := self lastVecAt: aSymbol.
	d := x - last x.
	v := self clipValueAt: aSymbol.
	y := (y - last y) * (v - x) / d + y.
	z := (z - last z) * (v - x) / d + z.
	^ KnVec4 x: v y: y z: z
]

{ #category : #private }
KnClippingContext >> vec: vec4 yOf: aSymbol [
	| last x y z v d |
	x := vec4 x.
	y := vec4 y.
	z := vec4 z.
	last := self lastVecAt: aSymbol.
	d := y - last y.
	v := self clipValueAt: aSymbol.
	x := (x - last x) * (v - y) / d + x.
	z := (z - last z) * (v - y) / d + z.
	^ KnVec4 x: x y: v z: z
]

{ #category : #private }
KnClippingContext >> vec: vec4 zOf: aSymbol [
	| x y z last v d |
	x := vec4 x.
	y := vec4 y.
	z := vec4 z.
	last := self lastVecAt: aSymbol.
	d := z - last z.
	(d closeTo: 0)
		ifTrue: [ ^ nil ].
	v := self clipValueAt: aSymbol.
	x := (x - last x) * (v - z) / d + x.
	y := (y - last y) * (v - z) / d + y.
	^ KnVec4 x: x y: y z: v
]

{ #category : #private }
KnClippingContext >> viewingTransform: vec4 opcode: opcode [
	| p v item |
	displayFile ifNil: [ ^ self ].
	p := vec4 x @ vec4 y.
	p := (p - clipOrigin) * self viewportExtent + self viewportPoint.
	v := KnVec4 x: p x y: p y z: vec4 z.
	item := KnDisplayItem opcode: opcode arg: v.
	(displayFile notEmpty and: [ displayFile last = item ])
		ifTrue: [ ^ self ].
	displayFile add: item
]

{ #category : #api }
KnClippingContext >> viewport: anArray [
	self clipValueAt: #viewport put: anArray copy
]

{ #category : #accessing }
KnClippingContext >> viewportExtent [
	^ viewportExtent
]

{ #category : #accessing }
KnClippingContext >> viewportExtent: aPoint [
	viewportExtent := aPoint
]

{ #category : #accessing }
KnClippingContext >> viewportPoint [
	^ viewportPoint
]

{ #category : #accessing }
KnClippingContext >> viewportPoint: aPoint [
	viewportPoint := aPoint
]

{ #category : #api }
KnClippingContext >> window: anArray [
	self
		clipValueAt: #left put: anArray first;
		clipValueAt: #right put: anArray second;
		clipValueAt: #bottom put: anArray third;
		clipValueAt: #top put: anArray fourth
]
