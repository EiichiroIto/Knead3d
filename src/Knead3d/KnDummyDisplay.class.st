Class {
	#name : #KnDummyDisplay,
	#superclass : #Object,
	#instVars : [
		'display',
		'canvas',
		'whenLogDo'
	],
	#category : #'Knead3d-Dummy'
}

{ #category : #api }
KnDummyDisplay >> fillBlack [
	display fillBlack
]

{ #category : #accessing }
KnDummyDisplay >> form [
	^ display form
]

{ #category : #accessing }
KnDummyDisplay >> form: aForm [
	display form: aForm.
	display canvas: canvas
]

{ #category : #initialization }
KnDummyDisplay >> initialize [
	display := KnFormDisplay new.
	canvas := KnDummyCanvas new
]

{ #category : #private }
KnDummyDisplay >> viewingTransform: vec4 opcode: opcode [
	whenLogDo ifNotNil: [ :b |
	b
		cull: [ :l | 
			l
				add:
					{opcode.
					vec4} ]].
	display viewingTransform: vec4 opcode: opcode
]

{ #category : #accessing }
KnDummyDisplay >> whenLogDo: aBlock [
	whenLogDo := aBlock.
	canvas whenLogDo: aBlock
]

{ #category : #api }
KnDummyDisplay >> window: aCollection [ 
	display window: aCollection
]
