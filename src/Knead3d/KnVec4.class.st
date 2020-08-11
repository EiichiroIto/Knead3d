Class {
	#name : #KnVec4,
	#superclass : #Object,
	#instVars : [
		'array'
	],
	#category : #'Knead3d-Core'
}

{ #category : #private }
KnVec4 class >> epsilon [
	^ 0.000001
]

{ #category : #'instance creation' }
KnVec4 class >> fromArray: aCollection [
	^ self basicNew
		setArray: aCollection;
		yourself
]

{ #category : #'instance creation' }
KnVec4 class >> infinity [
	^ self basicNew
		setInfinity;
		yourself
]

{ #category : #'instance creation' }
KnVec4 class >> x: x y: y z: z [
	^ self basicNew
		setX: x y: y z: z w: 0;
		yourself
]

{ #category : #'instance creation' }
KnVec4 class >> x: x y: y z: z w: w [
	^ self basicNew
		setX: x y: y z: z w: w;
		yourself
]

{ #category : #'instance creation' }
KnVec4 class >> zero [
	^ self x: 0 y: 0 z: 0
]

{ #category : #arithmetic }
KnVec4 >> * other [
	^ other multiplyByVec4: self
]

{ #category : #arithmetic }
KnVec4 >> + other [
	| list |
	list := array with: other privArray collect: [ :a :b | a + b ].
	^ self class fromArray: list
]

{ #category : #arithmetic }
KnVec4 >> - other [
	| list |
	list := array with: other privArray collect: [ :a :b | a - b ].
	^ self class fromArray: list
]

{ #category : #arithmetic }
KnVec4 >> / other [
	^ other divideByVec4: self
]

{ #category : #comparing }
KnVec4 >> = other [
	self == other
		ifTrue: [ ^ true ].
	(other isKindOf: self class)
		ifFalse: [ ^ false ].
	^ array = other privArray
]

{ #category : #accessing }
KnVec4 >> array [
	^ array copy
]

{ #category : #accessing }
KnVec4 >> at: anInteger [
	^ array at: anInteger
]

{ #category : #comparing }
KnVec4 >> closeTo: other [
	array
		withIndexDo: [ :each :index | 
			(each closeTo: (other at: index))
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #comparing }
KnVec4 >> closeTo: other precision: aPrecision [
	array
		withIndexDo: [ :each :index | 
			(each closeTo: (other at: index) precision: aPrecision)
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #arithmetic }
KnVec4 >> dotProduct: other [
	^ self x * other x + (self y * other y) + (self z * other z)
]

{ #category : #comparing }
KnVec4 >> hash [
	^ array hash
]

{ #category : #testing }
KnVec4 >> isOrthogonalTo: other [
	^ (self dotProduct: other) closeTo: 0
]

{ #category : #testing }
KnVec4 >> isParallelTo: other [
	^ (self * other) isZero
]

{ #category : #testing }
KnVec4 >> isZero [
	^ array allSatisfy: [ :each | each = 0 ]
]

{ #category : #arithmetic }
KnVec4 >> lengthOfYZ [
	^ (self y squared + self z squared) sqrt
]

{ #category : #arithmetic }
KnVec4 >> multiplyByMat4: other [
	^ other multiplyByVec4: self
]

{ #category : #arithmetic }
KnVec4 >> multiplyByVec4: other [
	^ self class
		x: other y * self z - (other z * self y)
		y: other z * self x - (other x * self z)
		z: other x * self y - (other y * self x)
]

{ #category : #testing }
KnVec4 >> nearTo: aVector [
	^ (self - aVector) r < self class epsilon
]

{ #category : #arithmetic }
KnVec4 >> negated [
	^ self class fromArray: (self privArray collect: #negated)
]

{ #category : #private }
KnVec4 >> newArray [
	^ FloatArray new: 4
]

{ #category : #converting }
KnVec4 >> normalized [
	| r |
	self isZero
		ifTrue: [ ^ self ].
	r := self r.
	^ self class x: self x / r y: self y / r z: self z / r
]

{ #category : #accessing }
KnVec4 >> orthogonalWith: other [
	^ (self * other) normalized
]

{ #category : #printing }
KnVec4 >> printOn: aStream [
	aStream
		nextPut: $[;
		nextPutAll: self x asString;
		nextPut: $,;
		nextPutAll: self y asString;
		nextPut: $,;
		nextPutAll: self z asString;
		nextPut: $,;
		nextPutAll: self w asString;
		nextPut: $]
]

{ #category : #private }
KnVec4 >> privArray [
	^ array
]

{ #category : #private }
KnVec4 >> privArray: aCollection [
	array := aCollection
]

{ #category : #accessing }
KnVec4 >> r [
	^ (self x squared + self y squared + self z squared) sqrt
]

{ #category : #accessing }
KnVec4 >> setArray: aCollection [
	| x y z w |
	(aCollection size between: 3 and: 4)
		ifFalse: [ self error: 'invalid array size' ].
	x := aCollection first.
	y := aCollection second.
	z := aCollection third.
	w := aCollection size = 3
		ifTrue: [ 0 ]
		ifFalse: [ aCollection fourth ].
	self
		setX: x
		y: y
		z: z
		w: w
]

{ #category : #accessing }
KnVec4 >> setInfinity [
	Float infinity
		in: [ :inf | 
			self
				setX: inf
				y: inf
				z: inf
				w: inf ].
	^ self
]

{ #category : #private }
KnVec4 >> setX: x y: y z: z w: w [
	array := self newArray.
	array at: 1 put: x.
	array at: 2 put: y.
	array at: 3 put: z.
	array at: 4 put: w
]

{ #category : #accessing }
KnVec4 >> sign [
	| x y z |
	x := (self x closeTo: 0)
		ifTrue: [ 0 ]
		ifFalse: [ self x sign ].
	y := (self y closeTo: 0)
		ifTrue: [ 0 ]
		ifFalse: [ self y sign ].
	z := (self z closeTo: 0)
		ifTrue: [ 0 ]
		ifFalse: [ self z sign ].
	^ self class x: x y: y z: z
]

{ #category : #arithmetic }
KnVec4 >> subNormalOf: other [
	| a b c |
	a := (self y - other y) * (self z + other z).
	b := (self z - other z) * (self x + other x).
	c := (self x - other x) * (self y + other y).
	^ self class x: a y: b z: c
]

{ #category : #arithmetic }
KnVec4 >> sumProduct: vec4 [
	^ (array with: vec4 privArray collect: [ :a :b | a * b ])
		inject: 0
		into: [ :prev :each | prev + each ]
]

{ #category : #converting }
KnVec4 >> swapXY [
	^ self class x: self y y: self x z: self z w: self w
]

{ #category : #converting }
KnVec4 >> swapYZ [
	^ self class x: self x y: self z z: self y w: self w
]

{ #category : #converting }
KnVec4 >> swapZX [
	^ self class x: self z y: self y z: self x w: self w
]

{ #category : #accessing }
KnVec4 >> w [
	^ array at: 4
]

{ #category : #accessing }
KnVec4 >> w: w [
	^ self class x: self x y: self y z: self z w: w
]

{ #category : #accessing }
KnVec4 >> x [
	^ array at: 1
]

{ #category : #accessing }
KnVec4 >> x: x [
	^ self class x: x y: self y z: self z w: self w
]

{ #category : #accessing }
KnVec4 >> y [
	^ array at: 2
]

{ #category : #accessing }
KnVec4 >> y: y [
	^ self class x: self x y: y z: self z w: self w
]

{ #category : #accessing }
KnVec4 >> z [
	^ array at: 3
]

{ #category : #accessing }
KnVec4 >> z: z [
	^ self class x: self x y: self y z: z w: self w
]
