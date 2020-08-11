Class {
	#name : #KneadEvaluator,
	#superclass : #Object,
	#instVars : [
		'builder',
		'modified'
	],
	#category : #'Knead3d-Project'
}

{ #category : #accessing }
KneadEvaluator >> builder [
	^ builder
]

{ #category : #accessing }
KneadEvaluator >> builder: anObject [
	builder := anObject
]

{ #category : #'basic ops' }
KneadEvaluator >> clear [
	self builder clear.
	self modified: true
]

{ #category : #'operator ops' }
KneadEvaluator >> computeFunction: aString of: aNumber [
	aString = 'sqrt'
		ifTrue: [ ^ aNumber sqrt ].
	aString = 'abs'
		ifTrue: [ ^ aNumber abs ].
	aString = 'sin'
		ifTrue: [ ^ aNumber degreesToRadians sin ].
	aString = 'cos'
		ifTrue: [ ^ aNumber degreesToRadians cos ].
	aString = 'tan'
		ifTrue: [ ^ aNumber degreesToRadians tan ].
	aString = 'asin'
		ifTrue: [ ^ aNumber arcSin radiansToDegrees ].
	aString = 'acos'
		ifTrue: [ ^ aNumber arcCos radiansToDegrees ].
	aString = 'atan'
		ifTrue: [ ^ aNumber arcTan radiansToDegrees ].
	aString = 'ln'
		ifTrue: [ ^ aNumber ln ].
	aString = 'log'
		ifTrue: [ ^ aNumber log ].
	aString = 'e ^'
		ifTrue: [ ^ aNumber exp ].
	aString = '10 ^'
		ifTrue: [ ^ 10 raisedTo: aNumber ].
	self error
]

{ #category : #'polygon ops' }
KneadEvaluator >> detach [
	self builder detach.
	self modified: true
]

{ #category : #'sensing ops' }
KneadEvaluator >> dirX [
	^ self builder direction x
]

{ #category : #'sensing ops' }
KneadEvaluator >> dirY [
	^ self builder direction y
]

{ #category : #'sensing ops' }
KneadEvaluator >> dirZ [
	^ self builder direction z
]

{ #category : #'basic ops' }
KneadEvaluator >> directionX: x y: y z: z [
	self builder directionX: x y: y z: z.
	self modified: true
]

{ #category : #'polygon ops' }
KneadEvaluator >> down: aNumber [
	self builder up: aNumber negated.
	self modified: true
]

{ #category : #'basic ops' }
KneadEvaluator >> forward: aNumber [
	self builder forward: aNumber.
	self modified: true
]

{ #category : #'operator ops' }
KneadEvaluator >> getFalse [
	^ false
]

{ #category : #'operator ops' }
KneadEvaluator >> getTrue [
	^ true
]

{ #category : #'polygon ops' }
KneadEvaluator >> grow: aNumber [
	self builder shrink: aNumber negated.
	self modified: true
]

{ #category : #'sensing ops' }
KneadEvaluator >> hasNormal [
	^ self builder hasNormal
]

{ #category : #'sensing ops' }
KneadEvaluator >> hasPolygon [
	^ self builder hasPolygon
]

{ #category : #'sensing ops' }
KneadEvaluator >> heading [
	^ self builder heading
]

{ #category : #'basic ops' }
KneadEvaluator >> heading: aNumber [
	self builder heading: aNumber.
	self modified: true
]

{ #category : #initialization }
KneadEvaluator >> initialize [
	modified := true
]

{ #category : #'operator ops' }
KneadEvaluator >> is: x between: a and: b [
	^ x between: a and: b
]

{ #category : #'sensing ops' }
KneadEvaluator >> isPenDown [
	^ self builder isPenDown
]

{ #category : #private }
KneadEvaluator >> maxOf: aSymbol [
	| list |
	list := self builder objects collect: aSymbol.
	list := list reject: #isEmpty.
	list := list collect: #max.
	^ list max
]

{ #category : #'object ops' }
KneadEvaluator >> maxX [
	^ self maxOf: #xs
]

{ #category : #'object ops' }
KneadEvaluator >> maxY [
	^ self maxOf: #ys
]

{ #category : #'object ops' }
KneadEvaluator >> maxZ [
	^ self maxOf: #zs
]

{ #category : #private }
KneadEvaluator >> minOf: aSymbol [
	| list |
	list := self builder objects collect: aSymbol.
	list := list reject: #isEmpty.
	list := list collect: #min.
	^ list min
]

{ #category : #'object ops' }
KneadEvaluator >> minX [
	^ self minOf: #xs
]

{ #category : #'object ops' }
KneadEvaluator >> minY [
	^ self minOf: #ys
]

{ #category : #'object ops' }
KneadEvaluator >> minZ [
	^ self minOf: #zs
]

{ #category : #accessing }
KneadEvaluator >> modified [
	^ modified
]

{ #category : #accessing }
KneadEvaluator >> modified: anObject [
	modified := anObject.
	Transcript show: 'modified: '; show: anObject ; cr
]

{ #category : #'polygon ops' }
KneadEvaluator >> mold [
	self builder mold.
	self modified: true
]

{ #category : #'basic ops' }
KneadEvaluator >> moveX: x y: y z: z [
	self builder moveX: x y: y z: z.
	self modified: true
]

{ #category : #'operator ops' }
KneadEvaluator >> negated: aNumber [
	^ aNumber negated
]

{ #category : #'polygon ops' }
KneadEvaluator >> next [
	self builder next.
	self modified: true
]

{ #category : #'operator ops' }
KneadEvaluator >> not: aFalse [ 
	^ aFalse not
]

{ #category : #'basic ops' }
KneadEvaluator >> penDown [
	self builder isPenDown: true
]

{ #category : #'basic ops' }
KneadEvaluator >> penUp [
	self builder isPenDown: false
]

{ #category : #'sensing ops' }
KneadEvaluator >> penX [
	^ self builder pen x
]

{ #category : #'sensing ops' }
KneadEvaluator >> penY [
	^ self builder pen y
]

{ #category : #'sensing ops' }
KneadEvaluator >> penZ [
	^ self builder pen z
]

{ #category : #'polygon ops' }
KneadEvaluator >> pitch: aNumber [
	self builder pitch: aNumber.
	self modified: true
]

{ #category : #'operator ops' }
KneadEvaluator >> randomFrom: a to: b [
	^ (a to: b) atRandom
]

{ #category : #'basic ops' }
KneadEvaluator >> roll: aNumber [
	self builder roll: aNumber.
	self modified: true
]

{ #category : #'basic ops' }
KneadEvaluator >> rotate: aNumber [
	self builder rotate: aNumber.
	self modified: true
]

{ #category : #'object ops' }
KneadEvaluator >> rotateObject: aNumber [
	self builder rotateObject: aNumber.
	self modified: true
]

{ #category : #'operator ops' }
KneadEvaluator >> rounded: aNumber [
	^ aNumber rounded
]

{ #category : #'polygon ops' }
KneadEvaluator >> shrink: aNumber [
	self builder shrink: aNumber.
	self modified: true
]

{ #category : #'polygon ops' }
KneadEvaluator >> stamp [
	self builder stamp
]

{ #category : #'object ops' }
KneadEvaluator >> swapXY [
	self builder swapXY.
	self modified: true
]

{ #category : #'object ops' }
KneadEvaluator >> swapYZ [
	self builder swapYZ.
	self modified: true
]

{ #category : #'object ops' }
KneadEvaluator >> swapZX [
	self builder swapZX.
	self modified: true
]

{ #category : #'object ops' }
KneadEvaluator >> translateX: x y: y z: z [
	self builder translateX: x y: y z: z.
	self modified: true
]

{ #category : #'operator ops' }
KneadEvaluator >> truncated: aNumber [
	^ aNumber truncated
]

{ #category : #'polygon ops' }
KneadEvaluator >> up: aNumber [
	self builder up: aNumber.
	self modified: true
]

{ #category : #'basic ops' }
KneadEvaluator >> yaw: aNumber [
	self flag: #toImplement.
	self shouldBeImplemented
]
