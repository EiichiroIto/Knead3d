Class {
	#name : #KnMatrix4,
	#superclass : #Object,
	#instVars : [
		'array'
	],
	#category : #'Knead3d-Core'
}

{ #category : #'instance creation' }
KnMatrix4 class >> identity [
	^ self new
		setTransformation;
		yourself
]

{ #category : #arithmetic }
KnMatrix4 >> * other [
	^ other multiplyByMat4: self
]

{ #category : #comparing }
KnMatrix4 >> = other [
	self == other
		ifTrue: [ ^ true ].
	(other isKindOf: self class)
		ifFalse: [ ^ false ].
	^ self privArray = other privArray
]

{ #category : #accessing }
KnMatrix4 >> array [
	^ array copy
]

{ #category : #accessing }
KnMatrix4 >> at: anInteger [
	^ array at: anInteger
]

{ #category : #accessing }
KnMatrix4 >> at: anInteger put: aFloat [
	array at: anInteger put: aFloat
]

{ #category : #accessing }
KnMatrix4 >> fromArray: aCollection [
	aCollection size = 16
		ifFalse: [ self error: 'invalid array size' ].
	array := aCollection asFloatArray
]

{ #category : #accessing }
KnMatrix4 >> indexOfRow: r col: c [
	^ c + ((r - 1) * 4)
]

{ #category : #initialization }
KnMatrix4 >> initialize [
	array := FloatArray new: 16
]

{ #category : #arithmetic }
KnMatrix4 >> multiplyByMat4: other [
	| mat4 |
	mat4 := self class new.
	1 to: 4 do: [ :r | 
		1 to: 4 do: [ :c | 
			other
				multiplyRow: r
				andCol: c
				of: self
				to: mat4 ] ].
	^ mat4
]

{ #category : #arithmetic }
KnMatrix4 >> multiplyByVec4: vec4 [
	| arr |
	arr := vec4 array.
	^ KnVec4
		fromArray: ((1 to: 4) collect: [ :each | self multiplyCol: each by: arr ])
]

{ #category : #private }
KnMatrix4 >> multiplyCol: anInteger by: anArray [
	| sum |
	sum := 0.
	1 to: 4 do:
		[ :each | sum := sum + ((self row: each col: anInteger) * (anArray at: each)) ].
	^ sum
]

{ #category : #private }
KnMatrix4 >> multiplyRow: r andCol: c of: other to: mat4 [
	| sum i |
	sum := 0.
	1 to: 4 do: [ :each | 
		| a b |
		i := self indexOfRow: r col: each.
		a := self at: i.
		i := self indexOfRow: each col: c.
		b := other at: i.
		sum := sum + (a * b) ].
	i := self indexOfRow: r col: c.
	mat4 at: i put: sum
]

{ #category : #printing }
KnMatrix4 >> printOn: aStream [
	aStream nextPut: $|.
	array
		do: [ :each | aStream nextPutAll: each asString ]
		separatedBy: [ aStream nextPut: Character space ].
	aStream nextPut: $|
]

{ #category : #private }
KnMatrix4 >> privArray [
	^ array
]

{ #category : #private }
KnMatrix4 >> privArray: aCollection [
	array := aCollection
]

{ #category : #api }
KnMatrix4 >> rotate: theta axis: aVector [
	| n1 n2 n3 st ct |
	st := theta degreesToRadians sin negated.
	ct := theta degreesToRadians cos.
	n1 := aVector x.
	n2 := aVector y.
	n3 := aVector z.
	self
		fromArray:
			{(ct + (n1 squared * (1 - ct))).
			(n1 * n2 * (1 - ct) - (n3 * st)).
			(n1 * n3 * (1 - ct) + (n2 * st)).
			0.
			(n2 * n1 * (1 - ct) + (n3 * st)).
			(ct + (n2 squared * (1 - ct))).
			(n2 * n3 * (1 - ct) - (n1 * st)).
			0.
			(n3 * n1 * (1 - ct) - (n2 * st)).
			(n3 * n2 * (1 - ct) + (n1 * st)).
			(ct + (n3 squared * (1 - ct))).
			0.
			0.
			0.
			0.
			1.0}
]

{ #category : #api }
KnMatrix4 >> rotateX: aNumber [
	| radians |
	radians := aNumber degreesToRadians.
	^ self rotateXSin: radians sin cos: radians cos
]

{ #category : #api }
KnMatrix4 >> rotateXSin: s cos: c [
	1 to: 4 do: [ :each | 
		| i2 i3 tmp |
		i2 := self indexOfRow: each col: 2.
		i3 := self indexOfRow: each col: 3.
		tmp := (self at: i2) * c - ((self at: i3) * s).
		self at: i3 put: (self at: i2) * s + ((self at: i3) * c).
		self at: i2 put: tmp ]
]

{ #category : #api }
KnMatrix4 >> rotateY: aNumber [
	| radians |
	radians := aNumber degreesToRadians.
	^ self rotateYSin: radians sin cos: radians cos
]

{ #category : #api }
KnMatrix4 >> rotateYSin: s cos: c [
	1 to: 4 do: [ :each | 
		| i1 i3 tmp |
		i1 := self indexOfRow: each col: 1.
		i3 := self indexOfRow: each col: 3.
		tmp := (self at: i1) * c + ((self at: i3) * s).
		self at: i3 put: (self at: i3) * c - ((self at: i1) * s).
		self at: i1 put: tmp ]
]

{ #category : #api }
KnMatrix4 >> rotateZ: aNumber [
	| radians |
	radians := aNumber degreesToRadians.
	^ self rotateZSin: radians sin cos: radians cos
]

{ #category : #api }
KnMatrix4 >> rotateZSin: s cos: c [
	1 to: 4 do: [ :each | 
		| i1 i2 tmp |
		i1 := self indexOfRow: each col: 1.
		i2 := self indexOfRow: each col: 2.
		tmp := (self at: i1) * c - ((self at: i2) * s).
		self at: i2 put: (self at: i1) * s + ((self at: i2) * c).
		self at: i1 put: tmp ]
]

{ #category : #accessing }
KnMatrix4 >> row: r col: c [
	| i |
	i := self indexOfRow: r col: c.
	^ self at: i
]

{ #category : #private }
KnMatrix4 >> setTransformation [
	array at: 1 put: 1.
	array at: 6 put: 1.
	array at: 11 put: 1.
	array at: 16 put: 1
]

{ #category : #api }
KnMatrix4 >> translate: vec4 [
	array at: 13 put: (array at: 13) + vec4 x.
	array at: 14 put: (array at: 14) + vec4 y.
	array at: 15 put: (array at: 15) + vec4 z
]
