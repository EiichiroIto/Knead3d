Class {
	#name : #KnParallelTransform,
	#superclass : #KnViewingTransform,
	#instVars : [
		'sp',
		'direction'
	],
	#category : #'Knead3d-Core'
}

{ #category : #accessing }
KnParallelTransform >> direction [
	^ direction
]

{ #category : #accessing }
KnParallelTransform >> direction: vec4 [
	direction := vec4
]

{ #category : #testing }
KnParallelTransform >> isParallelTransform [
	^ true
]

{ #category : #accessing }
KnParallelTransform >> makeTransformation: mat4 [
	| vec4 z |
	vec4 := self direction array
		in: [ :arr | 
			KnVec4
				x: (mat4 multiplyCol: 1 by: arr)
				y: (mat4 multiplyCol: 2 by: arr)
				z: (mat4 multiplyCol: 3 by: arr) ].
	z := vec4 z.
	(z closeTo: 0)
		ifTrue: [ self error: 'projection parallel view plane' ].
	self sp: vec4 / z
]

{ #category : #accessing }
KnParallelTransform >> sp [
	^ sp
]

{ #category : #accessing }
KnParallelTransform >> sp: vec4 [
	sp := vec4
]

{ #category : #accessing }
KnParallelTransform >> transform: vec4 [
	^ vec4 z
		in:
			[ :z | KnVec4 x: vec4 x - (z * sp x) y: vec4 y - (z * sp y) z: z ]
]
