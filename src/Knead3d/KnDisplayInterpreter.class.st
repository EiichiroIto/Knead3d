Class {
	#name : #KnDisplayInterpreter,
	#superclass : #Object,
	#instVars : [
		'current',
		'needErase',
		'displayFile',
		'index'
	],
	#category : #'Knead3d-Core'
}

{ #category : #accessing }
KnDisplayInterpreter >> current [
	^ current
]

{ #category : #accessing }
KnDisplayInterpreter >> current: aPoint [
	current := aPoint
]

{ #category : #accessing }
KnDisplayInterpreter >> displayFile [
	^ displayFile
]

{ #category : #accessing }
KnDisplayInterpreter >> displayFile: aCollection [
	displayFile := aCollection
]

{ #category : #private }
KnDisplayInterpreter >> doDisplay [
	self subclassResponsibility
]

{ #category : #private }
KnDisplayInterpreter >> doErase [
	self subclassResponsibility
]

{ #category : #private }
KnDisplayInterpreter >> doLine: aVector [
	self subclassResponsibility
]

{ #category : #private }
KnDisplayInterpreter >> doLineColor: aVector [
	self subclassResponsibility
]

{ #category : #private }
KnDisplayInterpreter >> doMove: aVector [
	self subclassResponsibility
]

{ #category : #private }
KnDisplayInterpreter >> doOpcode: anInteger args: aCollection [
	anInteger = KnDisplayItem cursor
		ifTrue: [ ^ self doShowCursor: aCollection first ].
	anInteger = KnDisplayItem color
		ifTrue: [ ^ self doLineColor: aCollection first ].
	anInteger = KnDisplayItem move
		ifTrue: [ ^ self doMove: aCollection first ].
	anInteger = KnDisplayItem line
		ifTrue: [ ^ self doLine: aCollection first ].
	anInteger > KnDisplayItem line
		ifTrue: [ ^ self doPolygon: aCollection first opcode: anInteger ].
	self error: 'invalid opcode'
]

{ #category : #private }
KnDisplayInterpreter >> doPolygon: aVector opcode: anInteger [
	self subclassResponsibility
]

{ #category : #private }
KnDisplayInterpreter >> doShowCursor: aPoint [
	self subclassResponsibility
]

{ #category : #accessing }
KnDisplayInterpreter >> index [
	^ index
]

{ #category : #accessing }
KnDisplayInterpreter >> index: anInteger [
	index := anInteger
]

{ #category : #private }
KnDisplayInterpreter >> interpret [
	self displayFile
		withIndexDo: [ :each :index | 
			self index: index.
			self doOpcode: each opcode args: each args ]
]

{ #category : #api }
KnDisplayInterpreter >> interpret: aCollection [
	self needErase
		ifTrue: [ self doErase.
			self needErase: false ].
	self displayFile: aCollection.
	self interpret.
	self doDisplay
]

{ #category : #accessing }
KnDisplayInterpreter >> needErase [
	^ needErase ifNil: [ true ]
]

{ #category : #accessing }
KnDisplayInterpreter >> needErase: aBoolean [
	needErase := aBoolean
]

{ #category : #api }
KnDisplayInterpreter >> newFrame [
	self needErase: true
]

{ #category : #private }
KnDisplayInterpreter >> pointFromNormalizedX: x y: y [
	"return point instance from normalized (x,y)"
	self subclassResponsibility
]

{ #category : #printing }
KnDisplayInterpreter >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(;
		nextPutAll: self identityHash asString;
		nextPut: $)
]

{ #category : #api }
KnDisplayInterpreter >> viewport [
	self subclassResponsibility
]
