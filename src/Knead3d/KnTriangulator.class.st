Class {
	#name : #KnTriangulator,
	#superclass : #Object,
	#category : #'Knead3d-Core'
}

{ #category : #testing }
KnTriangulator class >> normalOfTriangle: aCollection [
	^ (aCollection second - aCollection first)
		* (aCollection third - aCollection second)
]

{ #category : #private }
KnTriangulator >> calcNormal2Of: aCollection [
	| list v |
	v := nil.
	list := (aCollection first closeTo: aCollection last)
		ifTrue: [ aCollection ]
		ifFalse: [ aCollection copyWith: aCollection first ].
	list
		overlappingPairsDo: [ :v1 :v2 | 
			| v3 |
			v3 := v1 subNormalOf: v2.
			v := v ifNil: [ v3 ] ifNotNil: [ v + v3 ] ].
	v ifNil: [ ^ nil ].
	^ v normalized
]

{ #category : #api }
KnTriangulator >> clipEarsFrom: aCollection [
	| list stream |
	list := self removeCollinearPoints: aCollection.
	stream := WriteStream on: Array new.
	self clipEarsFrom: list into: stream.
	list := self validTriangles: stream contents.
	^ list
]

{ #category : #private }
KnTriangulator >> clipEarsFrom: aCollection into: aStream [
	| triangle rest n1 n2 |
	aCollection size < 3
		ifTrue: [ ^ self ].
	aCollection size = 3
		ifTrue: [ ^ aStream nextPut: aCollection ].
	n1 := self calcNormal2Of: aCollection.
	triangle := aCollection copyFrom: 1 to: 3.
	n2 := self calcNormal2Of: triangle.
	rest := aCollection copyFrom: 4 to: aCollection size.
	((self isConvex: triangle)
		and: [ (n1 closeTo: n2)
				and: [ (self triangle: triangle containsAll: rest) not ] ])
		ifTrue: [ aStream nextPut: triangle.
			^ self
				clipEarsFrom:
					{aCollection first.
					aCollection third} , rest
				into: aStream ].
	self
		clipEarsFrom: (aCollection copyWithoutFirst copyWith: aCollection first)
		into: aStream
]

{ #category : #testing }
KnTriangulator >> isConvex: aCollection [
	^ ((aCollection second - aCollection first)
		* (aCollection third - aCollection second)) isZero not
]

{ #category : #api }
KnTriangulator >> naiveTrianglesFrom: aCollection [
	| stream list |
	stream := WriteStream on: Array new.
	self naiveTrianglesFrom: aCollection into: stream.
	list := self validTriangles: stream contents.
	^ list
]

{ #category : #private }
KnTriangulator >> naiveTrianglesFrom: aCollection into: aStream [
	| first |
	first := aCollection first.
	aStream
		nextPut:
			{first.
			aCollection second.
			aCollection third}.
	3 to: aCollection size - 2 do: [ :each | 
		aStream
			nextPut:
				{first.
				(aCollection at: each).
				(aCollection at: each + 1)} ].
	aStream
		nextPut:
			{first.
			(aCollection at: aCollection size - 1).
			aCollection last}
]

{ #category : #private }
KnTriangulator >> removeCollinearPoints: aCollection [
	| last vec lastVec out |
	out := WriteStream on: Array new.
	last := aCollection first.
	lastVec := aCollection second - last.
	out nextPut: last.
	(aCollection copyWithoutFirst copyWith: last)
		overlappingPairsDo: [ :p1 :p2 | 
			vec := p2 - p1.
			(lastVec * vec) isZero
				ifFalse: [ out nextPut: p1 ].
			lastVec := vec ].
	^ out contents
]

{ #category : #testing }
KnTriangulator >> triangle: aCollection contains: aVec4 [
	| v1 v2 v3 b1 b2 b3 |
	v1 := aCollection second - aCollection first.
	v2 := aCollection third - aCollection second.
	v3 := aCollection first - aCollection third.
	b1 := v1 * (aVec4 - aCollection second).
	b2 := v2 * (aVec4 - aCollection third).
	b3 := v3 * (aVec4 - aCollection first).
	^ (b1 dotProduct: b2) > 0 and: [ (b1 dotProduct: b3) >0 ]
]

{ #category : #testing }
KnTriangulator >> triangle: aCollection1 containsAll: aCollection2 [
	^ aCollection2
		allSatisfy: [ :each | self triangle: aCollection1 contains: each ]
]

{ #category : #testing }
KnTriangulator >> triangle: aCollection on: aVec4 [
	| nv |
	nv := (aCollection second - aCollection first)
		* (aCollection third - aCollection second).
	^ (nv dotProduct: aVec4 - aCollection first) isZero
]

{ #category : #private }
KnTriangulator >> validTriangles: aCollection [
	^ aCollection
		reject: [ :each | (self class normalOfTriangle: each) isZero ]
]
