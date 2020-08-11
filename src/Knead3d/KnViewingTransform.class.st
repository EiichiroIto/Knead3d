Class {
	#name : #KnViewingTransform,
	#superclass : #Object,
	#category : #'Knead3d-Core'
}

{ #category : #accessing }
KnViewingTransform >> adjustZ: aNumber [
	^ aNumber
]

{ #category : #testing }
KnViewingTransform >> isParallelTransform [
	^ false
]

{ #category : #testing }
KnViewingTransform >> isPerspectiveTransform [
	^ false
]

{ #category : #private }
KnViewingTransform >> newVec [
	^ KnVec4 x: 0 y: 0 z: 0
]

{ #category : #accessing }
KnViewingTransform >> transform: vec4 [
	self subclassResponsibility
]
