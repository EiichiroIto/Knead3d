Class {
	#name : #Kn2DExample,
	#superclass : #Object,
	#instVars : [
		'displayFile'
	],
	#category : #'Knead3d-Examples'
}

{ #category : #examples }
Kn2DExample class >> example1 [
	<example>
	self new
		in: [ :obj | 
			obj setup.
			obj moveAbsToX: 0.2 y: 0.8.
			obj lineAbsToX: 0.2 y: 0.2.
			obj lineAbsToX: 0.8 y: 0.2.
			obj display ]
]

{ #category : #examples }
Kn2DExample class >> example2 [
	<example>
	| f |
	self new
		in: [ :obj | 
			f := obj polygonDisplayFileFrom: obj samplePolygonPoints.
			obj displayFile: f.
			obj display ]
]

{ #category : #private }
Kn2DExample >> display [
	| d morph |
	d := self newDisplay.
	d interpret: displayFile.
	morph := d form asMorph.
	morph
		on: #click send: #delete to: morph;
		openInWorld
]

{ #category : #accessing }
Kn2DExample >> displayFile: aCollection [
	displayFile := aCollection
]

{ #category : #private }
Kn2DExample >> lineAbsToX: x y: y [
	displayFile add: (KnDisplayItem opcode: 2 arg: (x @ y))
]

{ #category : #private }
Kn2DExample >> moveAbsToX: x y: y [
	displayFile add: (KnDisplayItem opcode: 1 arg: (x @ y))
]

{ #category : #private }
Kn2DExample >> newDisplay [
	^ KnFormDisplay new
		form: (Form extent: 400 @ 400 depth: 2);
		fillStyle: Color white;
		yourself
]

{ #category : #private }
Kn2DExample >> polygonAbs: aCollection [
	| n |
	n := aCollection size.
	n < 3
		ifTrue: [ self error: 'polygon size error' ].
	aCollection last
		in:
			[ :p | displayFile add: (KnDisplayItem opcode: n arg: p first @ p second) ].
	aCollection
		do: [ :each | self lineAbsToX: each first y: each second ]
]

{ #category : #private }
Kn2DExample >> polygonDisplayFileFrom: aCollection [
	| f |
	f := aCollection
		collect: [ :each | KnDisplayItem opcode: 2 arg: each ].
	(f at: 1) opcode: f size - 1.
	^ f
]

{ #category : #private }
Kn2DExample >> samplePolygonPoints [
	^ {(0.8 @ 0.9).
	(0.2 @ 0.7).
	(0.4 @ 0.3).
	(0.6 @ 0.5).
	(1.0 @ 0.1).
	(0.8 @ 0.9)}
]

{ #category : #private }
Kn2DExample >> setup [
	displayFile := OrderedCollection new
]
