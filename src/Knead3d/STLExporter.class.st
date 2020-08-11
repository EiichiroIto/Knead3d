Class {
	#name : #STLExporter,
	#superclass : #ScratchExporter,
	#category : #'Knead3d-Converter'
}

{ #category : #private }
STLExporter >> writeFloat: aFloat [
	self writeInt: aFloat asIEEE32BitWord
]

{ #category : #private }
STLExporter >> writeFooter: aProject [
	"do nothing"
]

{ #category : #private }
STLExporter >> writeHeader: aProject [
	| st triangles |
	st := WriteStream on: Array new.
	aProject objects do: [ :each | st nextPutAll: each asTriangles ].
	triangles := st contents.
	triangles isEmpty
		ifTrue: [ ^ self ].
	self writeSTLHeader.
	self writeSTLTriangles: triangles
]

{ #category : #private }
STLExporter >> writeInt: anInteger [
	stream nextPutAll: (anInteger asByteArrayOfSize: 4) reversed
]

{ #category : #private }
STLExporter >> writeSTLHeader [
	stream
		nextPutAll: Knead3D appName asByteArray;
		nextPutAll: ' stl file' asByteArray.
	79 - stream position timesRepeat: [ stream nextPut: 32 ].
	stream nextPut: 0
]

{ #category : #private }
STLExporter >> writeSTLTriangle: aCollection [
	| normal |
	normal := KnTriangulator normalOfTriangle: aCollection.
	self
		writeFloat: normal x;
		writeFloat: normal z;
		writeFloat: normal y.
	aCollection
		do: [ :each | 
			self
				writeFloat: each x;
				writeFloat: each z;
				writeFloat: each y ].
	stream
		nextPut: 0;
		nextPut: 0
]

{ #category : #private }
STLExporter >> writeSTLTriangles: aCollection [
	self writeInt: aCollection size.
	aCollection do: [ :each | self writeSTLTriangle: each ]
]

{ #category : #private }
STLExporter >> writeScript: aScript [
	"do nothing"
]
