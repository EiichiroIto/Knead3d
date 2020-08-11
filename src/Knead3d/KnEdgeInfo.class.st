Class {
	#name : #KnEdgeInfo,
	#superclass : #Object,
	#instVars : [
		'xa',
		'dx',
		'yMax',
		'yMin'
	],
	#category : #'Knead3d-Core'
}

{ #category : #'instance creation' }
KnEdgeInfo class >> from: p1 to: p2 [
	^ self new
		from: p1 to: p2;
		yourself
]

{ #category : #comparing }
KnEdgeInfo >> = other [
	self == other
		ifTrue: [ ^ true ].
	self yMax = other yMax
		ifFalse: [ ^ false ].
	self yMin = other yMin
		ifFalse: [ ^ false ].
	self xa = other xa
		ifFalse: [ ^ false ].
	^ self dx = other dx
]

{ #category : #accessing }
KnEdgeInfo >> dx [
	^ dx
]

{ #category : #accessing }
KnEdgeInfo >> dx: aNumber [
	dx := aNumber
]

{ #category : #accessing }
KnEdgeInfo >> from: aPoint1 to: aPoint2 [
	| x1 x2 y1 y2 |
	x1 := aPoint1 x.
	y1 := aPoint1 y.
	x2 := aPoint2 x.
	y2 := aPoint2 y.
	yMax := y1 max: y2.
	dx := -1.0 * (x2 truncated - x1 truncated) / (y2 - y1).
	y1 > y2
		ifTrue: [ yMin := y2.
			xa := x1 truncated ]
		ifFalse: [ yMin := y1.
			xa := x2 truncated ]
]

{ #category : #accessing }
KnEdgeInfo >> nextXa [
	^ xa + dx
]

{ #category : #printing }
KnEdgeInfo >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPutAll: '(yMax=';
		nextPutAll: yMax asString;
		nextPutAll: ',yMin=';
		nextPutAll: yMin asString;
		nextPutAll: ',xa=';
		nextPutAll: xa asString;
		nextPutAll: ',dx=';
		nextPutAll: dx asString;
		nextPut: $)
]

{ #category : #accessing }
KnEdgeInfo >> xa [
	^ xa
]

{ #category : #accessing }
KnEdgeInfo >> xa: anInteger [
	xa := anInteger
]

{ #category : #accessing }
KnEdgeInfo >> yMax [
	^ yMax
]

{ #category : #accessing }
KnEdgeInfo >> yMin [
	^ yMin
]

{ #category : #accessing }
KnEdgeInfo >> yMin: anInteger [
	yMin := anInteger
]
