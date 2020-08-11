Class {
	#name : #KnPerspectiveTransform,
	#superclass : #KnViewingTransform,
	#instVars : [
		'centerOfProjection',
		'center'
	],
	#category : #'Knead3d-Core'
}

{ #category : #accessing }
KnPerspectiveTransform >> adjustZ: aNumber [
	aNumber ifNil: [ ^ nil ].
	^ aNumber / (centerOfProjection z - aNumber)
]

{ #category : #accessing }
KnPerspectiveTransform >> center [
	^ center
]

{ #category : #accessing }
KnPerspectiveTransform >> center: vec4 [
	center := vec4
]

{ #category : #accessing }
KnPerspectiveTransform >> centerOfProjection [
	^ centerOfProjection
]

{ #category : #accessing }
KnPerspectiveTransform >> centerOfProjection: vec4 [
	centerOfProjection := vec4
]

{ #category : #testing }
KnPerspectiveTransform >> isPerspectiveTransform [
	^ true
]

{ #category : #accessing }
KnPerspectiveTransform >> makeTransformation: mat4 [
	| vec4 |
	vec4 := self center.
	vec4 := mat4 multiplyByVec4: (vec4 w: 1).
	vec4 z < 0
		ifTrue: [ self error: 'center of projection behind view plane' ].
	self centerOfProjection: vec4
]

{ #category : #accessing }
KnPerspectiveTransform >> transform: vec4 [
	| x y z xc yc zc d |
	x := vec4 x.
	y := vec4 y.
	z := vec4 z.
	xc := centerOfProjection x.
	yc := centerOfProjection y.
	zc := centerOfProjection z.
	(z closeTo: zc)
		ifTrue: [ ^ KnVec4
				x: (x - xc) * Float infinity
				y: (y - yc) * Float infinity
				z: Float infinity ].
	d := zc - z.
	^ KnVec4
		x: (x * zc - (xc * z)) / d
		y: (y * zc - (yc * z)) / d
		z: z / d
]
