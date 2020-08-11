Class {
	#name : #KnDummyContext,
	#superclass : #Object,
	#instVars : [
		'display'
	],
	#category : #'Knead3d-Dummy'
}

{ #category : #api }
KnDummyContext >> clip: vec4 opcode: opcode [
	display viewingTransform: vec4 opcode: opcode
]

{ #category : #api }
KnDummyContext >> display [
	^ display
]

{ #category : #api }
KnDummyContext >> display: aDisplay [
	display := aDisplay
]

{ #category : #api }
KnDummyContext >> frontZ: frontZ backZ: backZ [
	"do nothing"
]

{ #category : #api }
KnDummyContext >> window: aWindow [
	display window: aWindow
]
