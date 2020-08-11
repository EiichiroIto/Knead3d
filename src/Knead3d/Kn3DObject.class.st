Class {
	#name : #Kn3DObject,
	#superclass : #Object,
	#instVars : [
		'type',
		'points'
	],
	#category : #'Knead3d-Core'
}

{ #category : #api }
Kn3DObject class >> end: aCollection [
	aCollection isCollection
		ifFalse: [ self error ].
	^ self type: self endType points: aCollection
]

{ #category : #constants }
Kn3DObject class >> endType [
	^ #end
]

{ #category : #api }
Kn3DObject class >> line: aVector [
	aVector isCollection
		ifTrue: [ self error ].
	^ self type: self lineType point: aVector
]

{ #category : #constants }
Kn3DObject class >> lineType [
	^ #line
]

{ #category : #api }
Kn3DObject class >> move: aVector [
	aVector isCollection
		ifTrue: [ self error ].
	^ self type: self moveType point: aVector
]

{ #category : #constants }
Kn3DObject class >> moveType [
	^ #move
]

{ #category : #api }
Kn3DObject class >> side: aCollection [
	aCollection isCollection
		ifFalse: [ self error ].
	^ self type: self sideType points: aCollection
]

{ #category : #constants }
Kn3DObject class >> sideType [
	^ #side
]

{ #category : #api }
Kn3DObject class >> start: aCollection [
	aCollection isCollection
		ifFalse: [ self error ].
	^ self type: self startType points: aCollection
]

{ #category : #constants }
Kn3DObject class >> startType [
	^ #start
]

{ #category : #api }
Kn3DObject class >> type: aSymbol point: aVector [
	^ self new
		type: aSymbol;
		point: aVector;
		yourself
]

{ #category : #api }
Kn3DObject class >> type: aSymbol points: aCollection [
	^ self new
		type: aSymbol;
		points: aCollection;
		yourself
]

{ #category : #converting }
Kn3DObject >> asTriangles [
	| obj polygon |
	self isValidPolygon
		ifFalse: [ ^ #() ].
	obj := self reduced.
	obj ifNil: [ ^ #() ].
	polygon := obj polygon.
	polygon size < 3
		ifTrue: [ ^ #() ].
	polygon size = 3
		ifTrue: [ ^ {polygon} ].
	^ KnTriangulator new clipEarsFrom: polygon
]

{ #category : #testing }
Kn3DObject >> includesPoint: aVector [
	| list |
	list := self polygon
		overlappingPairsCollect: [ :p1 :p2 | (p1 - aVector) * (p2 - aVector) ].
	list := list collect: #sign.
	^ list allButFirst allSatisfy: [ :each | each = list first ]
]

{ #category : #testing }
Kn3DObject >> isEnd [
	^ type = self class endType
]

{ #category : #testing }
Kn3DObject >> isLine [
	^ type = self class lineType
]

{ #category : #testing }
Kn3DObject >> isMove [
	^ type = self class moveType
]

{ #category : #testing }
Kn3DObject >> isMoveOrLine [
	^ #(move line) includes: type
]

{ #category : #testing }
Kn3DObject >> isPolygon [
	^ #(start end side) includes: type
]

{ #category : #testing }
Kn3DObject >> isSide [
	^ type = self class sideType
]

{ #category : #testing }
Kn3DObject >> isStart [
	^ type = self class startType
]

{ #category : #testing }
Kn3DObject >> isTriangle [
	^ 	self isPolygon and: [ self points size = 3 ]
]

{ #category : #testing }
Kn3DObject >> isValidPolygon [
	^ self isPolygon and: [ self sides >= 3 ]
]

{ #category : #accessing }
Kn3DObject >> point: anObject [
	points := anObject
]

{ #category : #accessing }
Kn3DObject >> points [
	^ points
]

{ #category : #accessing }
Kn3DObject >> points: aCollection [
	| list |
	aCollection isEmpty
		ifTrue: [ ^ points := nil ].
	list := aCollection collect: [ :each | each w: 0 ].
	points := (list first closeTo: list last)
		ifTrue: [ list allButLast ]
		ifFalse: [ list copy ]
]

{ #category : #accessing }
Kn3DObject >> polygon [
	^ self points copyWith: self points first
]

{ #category : #printing }
Kn3DObject >> printOn: aStream [
	aStream
		nextPutAll: self type asString;
		nextPut: $<.
	self isPolygon
		ifTrue: [ aStream
				nextPutAll: self points size asString;
				nextPut: $: ].
	aStream
		nextPutAll: self points asString;
		nextPut: $>
]

{ #category : #private }
Kn3DObject >> privReverse [
	self isPolygon
		ifFalse: [ ^ self ].
	self points: {self points first} , self points allButFirst reverse
]

{ #category : #private }
Kn3DObject >> privTransform: aBlock [
	self
		points:
			(self isPolygon
				ifTrue: [ self points collect: aBlock ]
				ifFalse: [ aBlock cull: self points ])
]

{ #category : #converting }
Kn3DObject >> reduced [
	| list last |
	last := self polygon first.
	list := OrderedCollection new.
	list add: last.
	self polygon allButFirst
		do: [ :each | 
			(each nearTo: last)
				ifFalse: [ list add: each.
					last := each ] ].
	(last nearTo: list first)
		ifTrue: [ list removeLast ].
	list size < 3
		ifTrue: [ ^ nil ].
	list add: list first.
	^ self class new
		type: self type;
		points: list asArray;
		yourself
]

{ #category : #accessing }
Kn3DObject >> sides [
	^ self points size
]

{ #category : #converting }
Kn3DObject >> swapXY [
	self privTransform: [ :v | v swapXY ].
	self privReverse
]

{ #category : #converting }
Kn3DObject >> swapYZ [
	self privTransform: [ :v | v swapYZ ].
	self privReverse
]

{ #category : #converting }
Kn3DObject >> swapZX [
	self privTransform: [ :v | v swapZX ].
	self privReverse
]

{ #category : #converting }
Kn3DObject >> transformBy: aTransformation [
	self privTransform: [ :v | aTransformation transform: v ]
]

{ #category : #accessing }
Kn3DObject >> type [
	^ type
]

{ #category : #accessing }
Kn3DObject >> type: anObject [
	type := anObject
]

{ #category : #accessing }
Kn3DObject >> xs [
	self isPolygon
		ifTrue: [ ^ self points collect: #x ].
	self isMoveOrLine
		ifTrue: [ ^ self points x ].
	^ #()
]

{ #category : #accessing }
Kn3DObject >> ys [
	self isPolygon
		ifTrue: [ ^ self points collect: #y ].
	self isMoveOrLine
		ifTrue: [ ^ self points y ].
	^ #()
]

{ #category : #accessing }
Kn3DObject >> zs [
	self isPolygon
		ifTrue: [ ^ self points collect: #z ].
	self isMoveOrLine
		ifTrue: [ ^ self points z ].
	^ #()
]
