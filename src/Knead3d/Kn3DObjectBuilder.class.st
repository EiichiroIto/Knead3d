Class {
	#name : #Kn3DObjectBuilder,
	#superclass : #Object,
	#instVars : [
		'pen',
		'direction',
		'points',
		'objects',
		'isPenDown',
		'normal',
		'heading',
		'hasPolygon',
		'subDirection'
	],
	#category : #'Knead3d-Core'
}

{ #category : #private }
Kn3DObjectBuilder >> addEndTo: aCollection [
	objects add: (Kn3DObject end: aCollection)
]

{ #category : #private }
Kn3DObjectBuilder >> addLineTo: aVector [
	objects add: (Kn3DObject line: aVector)
]

{ #category : #private }
Kn3DObjectBuilder >> addMoveTo: aVector [
	objects add: (Kn3DObject move: aVector)
]

{ #category : #private }
Kn3DObjectBuilder >> addSideTo: aCollection [
	objects add: (Kn3DObject side: aCollection)
]

{ #category : #private }
Kn3DObjectBuilder >> addSidesFrom: aCollection1 to: aCollection2 [
	| v1 v2 v3 v4 l s |
	s := aCollection1 size min: aCollection2 size.
	1 to: s - 1 do: [ :each | 
		v1 := aCollection1 at: each.
		v2 := aCollection2 at: each.
		v3 := aCollection2 at: each + 1.
		v4 := aCollection1 at: each + 1.
		l := {v1.
		v4.
		v3.
		v2.
		v1}.
		self addSideTo: l ].
	aCollection1 size > s
		ifTrue: [ s to: aCollection1 size - 1 do: [ :each | 
				v1 := aCollection1 at: each.
				v2 := aCollection2 at: each.
				v3 := aCollection1 at: each + 1.
				l := {v1.
				v3.
				v2.
				v1}.
				self addSideTo: l ] ].
	aCollection2 size > s
		ifTrue: [ s to: aCollection2 size - 1 do: [ :each | 
				v1 := aCollection1 at: each.
				v2 := aCollection2 at: each.
				v3 := aCollection2 at: each + 1.
				l := {v1.
				v3.
				v2.
				v1}.
				self addSideTo: l ] ]
]

{ #category : #private }
Kn3DObjectBuilder >> addStartTo: aCollection [
	objects add: (Kn3DObject start: aCollection)
]

{ #category : #utilities }
Kn3DObjectBuilder >> arrangePoints: aCollection [
	| list last vec vec2 |
	list := OrderedCollection new.
	last := aCollection first.
	list add: last.
	vec := nil.
	aCollection allButFirst , {last}
		do: [ :each | 
			(each nearTo: last)
				ifFalse: [ vec2 := (each - last) normalized.
					(vec notNil and: [ (vec dotProduct: vec2) closeTo: 1 ])
						ifTrue: [ list removeLast ].
					vec := vec2.
					list add: each ].
			last := each ].
	^ list asArray
]

{ #category : #private }
Kn3DObjectBuilder >> baryCenterOf: aCollection [
	| all |
	all := aCollection
		inject: KnVec4 zero
		into: [ :prev :each | prev + each ].
	^ all / aCollection size
]

{ #category : #api }
Kn3DObjectBuilder >> buildAxesObject: aWorld [
	aWorld color: Color red.
	aWorld moveToAbs: (self newVecX: 0 y: 0 z: 0).
	aWorld lineToAbs: (self newVecX: 0.1 y: 0 z: 0).
	aWorld color: Color green.
	aWorld moveToAbs: (self newVecX: 0 y: 0 z: 0).
	aWorld lineToAbs: (self newVecX: 0 y: 0.1 z: 0).
	aWorld color: Color blue.
	aWorld moveToAbs: (self newVecX: 0 y: 0 z: 0).
	aWorld lineToAbs: (self newVecX: 0 y: 0 z: 0.1)
]

{ #category : #api }
Kn3DObjectBuilder >> buildObject: aWorld [
	objects
		do: [ :each | 
			each isMove
				ifTrue: [ aWorld moveToAbs: each points * self magnification ].
			each isLine
				ifTrue: [ aWorld lineToAbs: each points * self magnification ].
			each isPolygon
				ifTrue: [ aWorld
						polygonAbsolute: (each polygon collect: [ :v | v * self magnification ]) ] ]
]

{ #category : #api }
Kn3DObjectBuilder >> buildPenObject: aWorld [
	aWorld moveToAbs: self pen * self magnification.
	aWorld showCursor: self pen
]

{ #category : #private }
Kn3DObjectBuilder >> calcFaceTo: aVector [
	^ self normal
		ifNil: [ 0 ]
		ifNotNil: [ :n | aVector - self points first dotProduct: n ]
]

{ #category : #private }
Kn3DObjectBuilder >> calcNormal [
	^ self calcNormalOf: self points
]

{ #category : #utilities }
Kn3DObjectBuilder >> calcNormalOf: aCollection [
	| v |
	v := nil.
	aCollection
		overlappingPairsDo: [ :v1 :v2 | 
			| v3 n |
			v3 := v1 - v2.
			v
				ifNil: [ v := v3 ]
				ifNotNil: [ n := v * v3.
					n isZero
						ifFalse: [ ^ n ] ] ].
	^ nil
]

{ #category : #api }
Kn3DObjectBuilder >> clear [
	self pen: (KnVec4 x: 0 y: 0 z: 0).
	self subDirection: (KnVec4 x: 0 y: 0 z: 1).
	self direction: (KnVec4 x: 1 y: 0 z: 0).
	self heading: 0.
	self clearNormal.
	self clearObjects.
	self clearPoints.
	self hasPolygon: false.
	isPenDown := true
]

{ #category : #private }
Kn3DObjectBuilder >> clearNormal [
	normal := nil
]

{ #category : #private }
Kn3DObjectBuilder >> clearObjects [
	objects := OrderedCollection new
]

{ #category : #private }
Kn3DObjectBuilder >> clearPoints [
	self points: OrderedCollection new
]

{ #category : #api }
Kn3DObjectBuilder >> detach [
	self clearPoints.
	self hasPolygon: false
]

{ #category : #accessing }
Kn3DObjectBuilder >> direction [
	^ direction
]

{ #category : #accessing }
Kn3DObjectBuilder >> direction: aVector [
	| old |
	old := direction.
	direction := aVector normalized.
	(old isNil or: [ (direction isParallelTo: self subDirection) not ])
		ifTrue: [ ^ self ].
	self subDirection: old negated
]

{ #category : #api }
Kn3DObjectBuilder >> directionX: x y: y z: z [
	| newDir |
	"oldDir := self direction."
	newDir := self newVecX: x y: y z: z.
	self direction: newDir.
	self heading: 0.
	"self hasPolygon
		ifFalse: [ ^ self ].
	self rotatePolygonFrom: oldDir.
	self updateLines"
]

{ #category : #private }
Kn3DObjectBuilder >> enterNewPlaneTo: newVec [
	self isPenDown: false.
	self makePolygon: newVec.
	self privMoveTo: newVec
]

{ #category : #api }
Kn3DObjectBuilder >> forward: aNumber [
	| oldVec newVec dir |
	oldVec := self pen.
	dir := self penDirection.
	newVec := oldVec + (dir * aNumber).
	self moveTo: newVec
]

{ #category : #testing }
Kn3DObjectBuilder >> hasNormal [
	^ self normal notNil
]

{ #category : #testing }
Kn3DObjectBuilder >> hasPoints [
	^ self points notEmpty
]

{ #category : #testing }
Kn3DObjectBuilder >> hasPolygon [
	^ hasPolygon
]

{ #category : #accessing }
Kn3DObjectBuilder >> hasPolygon: aBoolean [
	hasPolygon := aBoolean
]

{ #category : #api }
Kn3DObjectBuilder >> heading [
	^ heading
]

{ #category : #api }
Kn3DObjectBuilder >> heading: aNumber [
	heading := aNumber \\ 360
]

{ #category : #initialization }
Kn3DObjectBuilder >> initialize [
	self clear
]

{ #category : #testing }
Kn3DObjectBuilder >> isCoplanarPointsWith: aVector [
	self normal ifNil: [ ^ true ].
	self hasPoints
		ifFalse: [ ^ (self normal dotProduct: aVector - self pen) isZero ].
	^ (self points first - aVector dotProduct: self normal) closeTo: 0
]

{ #category : #testing }
Kn3DObjectBuilder >> isPenDown [
	^ isPenDown
]

{ #category : #api }
Kn3DObjectBuilder >> isPenDown: aBoolean [
	isPenDown = aBoolean
		ifTrue: [ ^ self ].
	isPenDown := aBoolean.
	aBoolean
		ifFalse: [ ^ self ].
	self hasPolygon
		ifFalse: [ ^ self ].
	self hasPolygon: false.
	self clearPoints.
	self clearNormal.
	self removeLines
]

{ #category : #private }
Kn3DObjectBuilder >> lastStart [
	objects size to: 1 by: -1 do: [ :index | 
		| item |
		item := objects at: index.
		(item isEnd or: [ item isSide ])
			ifTrue: [ ^ nil ].
		item isStart
			ifTrue: [ ^ item ] ].
	^ nil
]

{ #category : #private }
Kn3DObjectBuilder >> magnification [
	^ 0.01
]

{ #category : #private }
Kn3DObjectBuilder >> makePolygon: aVector [
	"make vector list from points into polygon variable
	remove redundant vectors.
	then clear points"

	| face |
	self normal
		ifNil: [ self clearPoints.
			self removeLines.
			^ self ].
	self points isEmpty
		ifTrue: [ ^ self ].
	self removeLines.
	self hasPolygon
		ifTrue: [ ^ self ].
	self hasPolygon: true.
	self points: (self arrangePoints: self points).
	face := self calcFaceTo: aVector.
	face = 0
		ifTrue: [ self error ].
	face < 0
		ifTrue: [ self addStartTo: (self reversedPointsOf: self points) ]
		ifFalse: [ self addStartTo: self points.
			self points: (self reversedPointsOf: self points) ]
]

{ #category : #api }
Kn3DObjectBuilder >> mold [
	| prev |
	self hasPolygon
		ifFalse: [ ^ self ].
	self removeLines.
	prev := self removeLastEnd
		ifNil: [ self lastStart
				ifNil: [ ^ self ]
				ifNotNil: [ :e | self reversedPointsOf: e polygon ] ]
		ifNotNil: [ :e | e polygon ].
	self addSidesFrom: prev to: self points.
	self addEndTo: self points
]

{ #category : #private }
Kn3DObjectBuilder >> moveTo: newVec [
	| oldVec needAddPoint |
	oldVec := self pen.
	(oldVec closeTo: newVec)
		ifTrue: [ ^ self ].
	needAddPoint := self isPenDown and: [ (self points includes: oldVec) not ].
	(self isCoplanarPointsWith: newVec)
		ifFalse: [ ^ self enterNewPlaneTo: newVec ].
	needAddPoint
		ifTrue: [ self privAddPoint: oldVec.
			self addMoveTo: oldVec ].
	self isPenDown
		ifTrue: [ self privLineTo: newVec ]
		ifFalse: [ self privMoveTo: newVec ]
]

{ #category : #api }
Kn3DObjectBuilder >> moveX: x y: y z: z [
	| newVec |
	newVec := self newVecX: x y: y z: z.
	self moveTo: newVec
]

{ #category : #private }
Kn3DObjectBuilder >> newTransformation [
	^ KnTransformation new
]

{ #category : #utilities }
Kn3DObjectBuilder >> newVecX: x y: y z: z [
	^ KnVec4 x: x y: y z: z
]

{ #category : #api }
Kn3DObjectBuilder >> next [
	| i |
	i := self points indexOf: self pen.
	i = 0
		ifTrue: [ ^ self ].
	i := (i \\ self points size) + 1.
	self pen: (self points at: i)
]

{ #category : #accessing }
Kn3DObjectBuilder >> normal [
	normal
		ifNil:
			[ self calcNormal ifNotNil: [ :n | normal := n normalized ] ].
	^ normal
]

{ #category : #accessing }
Kn3DObjectBuilder >> normal: aVector [
	normal := aVector normalized
]

{ #category : #accessing }
Kn3DObjectBuilder >> objects [
	^ objects
]

{ #category : #accessing }
Kn3DObjectBuilder >> pen [
	^ pen
]

{ #category : #accessing }
Kn3DObjectBuilder >> pen: aVector [
	pen := aVector
]

{ #category : #private }
Kn3DObjectBuilder >> penDirection [
	"calculate from points and heading"

	| x z |
	x := self direction x.
	z := self direction z.
	((x closeTo: 0) and: [ z closeTo: 0 ])
		ifTrue: [ ^ self penDirectionParallelToYAxis ].
	^ z abs > x abs
		ifTrue: [ self penDirectionParallelToYAxis ]
		ifFalse: [ self penDirectionOrthogonalToZAxis ]
]

{ #category : #private }
Kn3DObjectBuilder >> penDirectionOrthogonalToZAxis [
	| x y z u v xp |
	x := self direction x.
	y := self direction y.
	z := self direction z.
	u := (1 - z squared) sqrt arcCos.
	z := (self heading degreesToRadians + u) sin.
	v := (y / x) arcTan.
	xp := (self heading degreesToRadians + u) cos.
	y := xp * v sin.
	x := xp * v cos.
	^ (self newVecX: x y: y z: z) normalized
]

{ #category : #private }
Kn3DObjectBuilder >> penDirectionParallelToYAxis [
	| n t |
	n := self direction orthogonalWith: self subDirection.
	t := self newTransformation.
	t rotateAt: KnVec4 zero axis: n by: self heading degreesToRadians.
	^ (t transform: self direction) w: 0
]

{ #category : #api }
Kn3DObjectBuilder >> pitch: aNumber [
	self rotatePolygon: aNumber axis: [ self direction ]
]

{ #category : #accessing }
Kn3DObjectBuilder >> points [
	^ points
]

{ #category : #private }
Kn3DObjectBuilder >> points: aCollection [
	points := aCollection.
	self clearNormal
]

{ #category : #printing }
Kn3DObjectBuilder >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(;
		nextPutAll: self identityHash asString;
		nextPut: $,;
		nextPutAll: self objects size asString;
		nextPut: $,;
		nextPutAll: self points size asString;
		nextPut: $,;
		nextPutAll: self pen asString;
		nextPut: $,;
		nextPutAll: self heading asString;
		nextPut: $)
]

{ #category : #private }
Kn3DObjectBuilder >> privAddPoint: aVector [
	points add: aVector
]

{ #category : #private }
Kn3DObjectBuilder >> privLineTo: aVector [
	self privAddPoint: aVector.
	self addLineTo: aVector.
	self pen: aVector
]

{ #category : #private }
Kn3DObjectBuilder >> privMoveTo: aVector [
	| diff |
	diff := aVector - self pen.
	diff isZero
		ifTrue: [ ^ self ].
	self pen: aVector.
	self hasPolygon
		ifFalse: [ ^ self ].
	self points: (self points collect: [ :each | each + diff ]).
	self updateLines
]

{ #category : #private }
Kn3DObjectBuilder >> removeLastEnd [
	objects size to: 1 by: -1 do: [ :index | 
		| item |
		item := objects at: index.
		item isStart
			ifTrue: [ ^ nil ].
		item isEnd
			ifTrue: [ ^ objects remove: item ] ]
]

{ #category : #private }
Kn3DObjectBuilder >> removeLastStart [
	^ self lastStart
		ifNotNil: [ :item | objects remove: item ]
]

{ #category : #private }
Kn3DObjectBuilder >> removeLines [
	objects := objects reject: [ :each | each isMoveOrLine ]
]

{ #category : #utilities }
Kn3DObjectBuilder >> reversedPointsOf: aCollection [
	^ {aCollection first}
		, (aCollection copyFrom: 2 to: aCollection size - 1) reversed
		, {aCollection last}
]

{ #category : #api }
Kn3DObjectBuilder >> roll: aNumber [
	self rotatePolygon: aNumber axis: [ self normal ]
]

{ #category : #api }
Kn3DObjectBuilder >> rotate: aNumber [
	self heading: self heading + aNumber
]

{ #category : #private }
Kn3DObjectBuilder >> rotateAt: aPoint axis: aVector by: theta [
	| t |
	t := self newTransformation rotateAt: aPoint axis: aVector by: theta.
	self points: (self points collect: [ :each | t transform: each ])
]

{ #category : #api }
Kn3DObjectBuilder >> rotateObject: aNumber [
	| t |
	t := self newTransformation
		rotateAt: self pen
		axis: self direction
		by: aNumber degreesToRadians.
	self objects do: [ :each | each transformBy: t ]
]

{ #category : #private }
Kn3DObjectBuilder >> rotatePolygon: aNumber axis: aVector [
	| i |
	self hasPolygon
		ifFalse: [ self
				makePolygon: (self baryCenterOf: self points) - (self normal * aNumber) ].
	i := self points indexOf: self pen.
	i = 0
		ifTrue: [ ^ self ].
	self rotateAt: self pen axis: aVector value by: aNumber degreesToRadians.
	self updateLines.
	self pen: (self points at: i)
]

{ #category : #private }
Kn3DObjectBuilder >> rotatePolygonFrom2: oldDir [
	| c t newDir degrees |
	newDir := self direction.
	c := self baryCenterOf: self points.
	degrees := (newDir x @ newDir y) degrees
		- (oldDir x @ oldDir y) degrees.
	t := self newTransformation.
	t rotateZ: degrees degreesToRadians at: c.
	self points: (self points collect: [ :each | t transform: each ])
]

{ #category : #private }
Kn3DObjectBuilder >> rotatePolygonFrom: oldDir [
	| c m t newDir |
	newDir := self direction.
	c := self baryCenterOf: self points.
	m := KnMatrix4 identity.
	m translate: c negated.
	t := (newDir x @ newDir y) degrees - (oldDir x @ oldDir y) degrees.
	m rotateZ: t.
	m translate: c.
	self points: (self points collect: [ :each | m * (each w: 1) ])
]

{ #category : #api }
Kn3DObjectBuilder >> shrink: anInteger [
	| center |
	self hasPoints
		ifFalse: [ ^ self ].
	center := self baryCenterOf: self points.
	self
		points:
			(self points
				collect: [ :each | (center - each) normalized * anInteger + each ]).
	self updateLines.
	self pen: (center - self pen) normalized * anInteger + self pen
]

{ #category : #api }
Kn3DObjectBuilder >> stamp [
	self hasPolygon
		ifFalse: [ ^ self ].
	self removeLastStart.
	self addStartTo: (self reversedPointsOf: self points)
]

{ #category : #accessing }
Kn3DObjectBuilder >> subDirection [
	^ subDirection
]

{ #category : #accessing }
Kn3DObjectBuilder >> subDirection: aVector [
	subDirection := aVector
]

{ #category : #api }
Kn3DObjectBuilder >> swapXY [
	self objects do: [ :each | each swapXY ]
]

{ #category : #api }
Kn3DObjectBuilder >> swapYZ [
	self objects do: [ :each | each swapYZ ]
]

{ #category : #api }
Kn3DObjectBuilder >> swapZX [
	self objects do: [ :each | each swapZX ]
]

{ #category : #api }
Kn3DObjectBuilder >> translateX: x y: y z: z [
	| v t |
	v := KnVec4 x: x y: y z: z.
	t := self newTransformation translate: v.
	self objects do: [ :each | each transformBy: t ]
]

{ #category : #api }
Kn3DObjectBuilder >> up: aNumber [
	| dir oldVec newVec |
	oldVec := self pen.
	dir := self normal negated.
	newVec := oldVec + (dir * aNumber).
	self moveTo: newVec
]

{ #category : #private }
Kn3DObjectBuilder >> updateLines [
	self removeLines.
	self hasPoints
		ifFalse: [ ^ self ].
	self addMoveTo: self points first.
	self points allButFirst do: [ :each | self addLineTo: each ]
]
