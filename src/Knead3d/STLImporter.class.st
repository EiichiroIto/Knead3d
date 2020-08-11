Class {
	#name : #STLImporter,
	#superclass : #ScratchImporter,
	#instVars : [
		'stream',
		'header',
		'triangles'
	],
	#category : #'Knead3d-Converter'
}

{ #category : #accessing }
STLImporter >> import: aString to: anApplication [
	| builder |
	self importFrom: aString asByteArray.
	builder := anApplication builder.
	builder clear.
	triangles do: [ :each | builder addSideTo: each ]
]

{ #category : #private }
STLImporter >> importFrom: aByteArray [
	| num |
	stream := ReadStream on: aByteArray.
	num := self readHeader.
	triangles := OrderedCollection new.
	num timesRepeat: [ self readTriangle ]
]

{ #category : #private }
STLImporter >> readHeader [
	header := stream next: 80.
	^ self toInt: (stream next: 4)
]

{ #category : #private }
STLImporter >> readTriangle [
	| nx ny nz x1 y1 z1 x2 y2 z2 x3 y3 z3 |
	nx := self toFloat: (stream next: 4).
	ny := self toFloat: (stream next: 4).
	nz := self toFloat: (stream next: 4).
	x1 := self toFloat: (stream next: 4).
	y1 := self toFloat: (stream next: 4).
	z1 := self toFloat: (stream next: 4).
	x2 := self toFloat: (stream next: 4).
	y2 := self toFloat: (stream next: 4).
	z2 := self toFloat: (stream next: 4).
	x3 := self toFloat: (stream next: 4).
	y3 := self toFloat: (stream next: 4).
	z3 := self toFloat: (stream next: 4).
	triangles
		add:
			{(KnVec4 x: x1 y: z1 z: y1).
			(KnVec4 x: x2 y: z2 z: y2).
			(KnVec4 x: x3 y: z3 z: y3).
			(KnVec4 x: x1 y: z1 z: y1)}.
	stream next: 2
]

{ #category : #private }
STLImporter >> toFloat: aByteArray [
	^ Float fromIEEE32Bit: (self toInt: aByteArray)
]

{ #category : #private }
STLImporter >> toInt: aByteArray [
	^ aByteArray first + (aByteArray second * 256)
		+ (aByteArray third * 256 * 256)
		+ (aByteArray fourth * 256 * 256 * 256)
]
