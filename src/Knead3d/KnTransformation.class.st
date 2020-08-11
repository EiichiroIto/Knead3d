Class {
	#name : #KnTransformation,
	#superclass : #Object,
	#instVars : [
		'tMatrix'
	],
	#category : #'Knead3d-Core'
}

{ #category : #initialization }
KnTransformation >> initialize [
	tMatrix := self newTransform
]

{ #category : #private }
KnTransformation >> newTransform [
	^ KnMatrix4 identity
]

{ #category : #api }
KnTransformation >> rotateAt: aPoint axis: aVector by: theta [
	| a b c v l |
	a := aVector x.
	b := aVector y.
	c := aVector z.
	v := (b squared + c squared) sqrt.
	l := aVector r.
	self tMatrix translate: aPoint negated.
	v = 0
		ifFalse: [ self tMatrix rotateXSin: b / v cos: c / v ].
	self tMatrix rotateYSin: a / l cos: v / l.
	self tMatrix rotateZSin: theta sin cos: theta cos.
	self tMatrix rotateYSin: (a / l) negated cos: v / l.
	v = 0
		ifFalse: [ self tMatrix rotateXSin: (b / v) negated cos: c / v ].
	self tMatrix translate: aPoint
]

{ #category : #api }
KnTransformation >> rotateUp: aVector [
	| arr xupvp yupvp rup |
	arr := (aVector w: 0) array.
	xupvp := self tMatrix multiplyCol: 1 by: arr.
	yupvp := self tMatrix multiplyCol: 2 by: arr.
	rup := (xupvp squared + yupvp squared) sqrt.
	(rup closeTo: 0)
		ifTrue: [ ^ self ].
	self tMatrix rotateZSin: xupvp / rup cos: yupvp / rup
]

{ #category : #api }
KnTransformation >> rotateXY: aVector [
	| v |
	v := aVector lengthOfYZ.
	(v closeTo: 0)
		ifFalse: [ self tMatrix
				rotateXSin: (aVector y / v) negated
				cos: (aVector z / v) negated ].
	self tMatrix rotateYSin: aVector x cos: v
]

{ #category : #api }
KnTransformation >> rotateZ: aNumber at: aVector [
	self tMatrix translate: aVector negated.
	self tMatrix rotateZ: aNumber.
	self tMatrix translate: aVector
]

{ #category : #accessing }
KnTransformation >> tMatrix [
	^ tMatrix
]

{ #category : #api }
KnTransformation >> transform: aVector [
	^ self tMatrix * (aVector w: 1)
]

{ #category : #api }
KnTransformation >> translate: aVector [
	self tMatrix translate: aVector
]
