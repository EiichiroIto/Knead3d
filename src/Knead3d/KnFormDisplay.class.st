Class {
	#name : #KnFormDisplay,
	#superclass : #KnDisplayInterpreter,
	#instVars : [
		'form',
		'canvas',
		'fillStyle',
		'lineColor'
	],
	#category : #'Knead3d-Core'
}

{ #category : #accessing }
KnFormDisplay >> canvas [
	^ canvas
]

{ #category : #accessing }
KnFormDisplay >> canvas: aCanvas [
	canvas := aCanvas
]

{ #category : #polygon }
KnFormDisplay >> displayPointsFrom: from to: to [
	^ (from to: to)
		collect: [ :each | 
			| item arg |
			item := self displayFile at: each.
			arg := item arg.
			arg x @ arg y ]
]

{ #category : #private }
KnFormDisplay >> doDisplay [
	"do nothing"
]

{ #category : #private }
KnFormDisplay >> doErase [
	self fillColor: Color black
]

{ #category : #private }
KnFormDisplay >> doLine: aVector [
	| p1 p2 |
	p1 := self current.
	self current: aVector x @ aVector y.
	p2 := self current.
	(p1 isNil or: [ p2 isNil ])
		ifTrue: [ self error ].
	self canvas
		line: p1
		to: p2
		width: self lineWidth
		color: self lineColor
]

{ #category : #private }
KnFormDisplay >> doLineColor: aColor [
	self lineColor: aColor
]

{ #category : #private }
KnFormDisplay >> doMove: aVector [
	self current: aVector x @ aVector y
]

{ #category : #private }
KnFormDisplay >> doPolygon: aVector opcode: anInteger [
	fillStyle ifNotNil: [ self fillPolygon: self index ].
	self doMove: aVector
]

{ #category : #private }
KnFormDisplay >> doShowCursor: aPoint [
	| p |
	p := self current.
	p ifNil: [ ^ self ].
	self canvas
		fillRectangle: (Rectangle center: p extent: 5 @ 5)
		fillStyle: Color red
]

{ #category : #polygon }
KnFormDisplay >> edgesFrom: anInteger [
	| points item p1 edges |
	item := self displayFile at: anInteger.
	points := self
		displayPointsFrom: anInteger
		to: anInteger + item opcode.
	edges := OrderedCollection new.
	p1 := points first.
	points
		allButFirstDo: [ :each | 
			p1 y ~= each y
				ifTrue: [ edges
						add:
							{p1.
							each} ].
			p1 := each ].
	^ edges
]

{ #category : #accessing }
KnFormDisplay >> extent [
	^ form ifNotNil: [ form extent ]
]

{ #category : #private }
KnFormDisplay >> fillColor: aColor [
	self canvas fillColor: aColor
]

{ #category : #polygon }
KnFormDisplay >> fillInX1: x1 x2: x2 y: y [
	canvas
		line: x1 truncated @ y
		to: x2 truncated @ y
		width: 1
		color: self fillStyle
]

{ #category : #polygon }
KnFormDisplay >> fillPolygon: anInteger [
	| edges scan startEdge endEdge |
	edges := self loadPolygonFrom: anInteger.
	edges size < 2
		ifTrue: [ ^ self ].
	scan := edges first yMax.
	startEdge := 1.
	endEdge := self includeEdgeStarting: 1 scan: scan in: edges.
	[ endEdge = startEdge ]
		whileFalse: [ self xsort: edges from: startEdge to: endEdge - 1.
			self
				fillScanFrom: startEdge
				to: endEdge
				scan: scan
				in: edges.
			scan := scan - 1.
			startEdge := self
				updateXValues: edges
				from: startEdge
				to: endEdge - 1
				scan: scan.
			endEdge := self includeEdgeStarting: endEdge scan: scan in: edges ]
]

{ #category : #polygon }
KnFormDisplay >> fillScanFrom: start to: end scan: scan in: edges [
	| j |
	j := start.
	(end - start) // 2
		timesRepeat: [ self fillInX1: (edges at: j) xa x2: (edges at: j + 1) xa y: scan.
			j := j + 2 ]
]

{ #category : #accessing }
KnFormDisplay >> fillStyle [
	^ fillStyle
]

{ #category : #accessing }
KnFormDisplay >> fillStyle: aColor [
	fillStyle := aColor
]

{ #category : #accessing }
KnFormDisplay >> form [
	^ form
]

{ #category : #accessing }
KnFormDisplay >> form: anObject [
	form := anObject.
	canvas := FormCanvas on: form
]

{ #category : #private }
KnFormDisplay >> height [
	^ self form height
]

{ #category : #polygon }
KnFormDisplay >> includeEdgeStarting: anInteger scan: aNumber in: aCollection [
	| end |
	end := anInteger.
	[ end <= aCollection size
		and: [ (aCollection at: end) yMax >= aNumber ] ]
		whileTrue: [ end := end + 1 ].
	^ end
]

{ #category : #accessing }
KnFormDisplay >> lineColor [
	^ lineColor ifNil: [ Color white ]
]

{ #category : #accessing }
KnFormDisplay >> lineColor: aColor [
	lineColor := aColor
]

{ #category : #private }
KnFormDisplay >> lineWidth [
	^ 1
]

{ #category : #polygon }
KnFormDisplay >> loadPolygonFrom: anInteger [
	| edgeInfos |
	edgeInfos := self edgesFrom: anInteger.
	edgeInfos := edgeInfos
		collect: [ :each | KnEdgeInfo from: each first to: each second ].
	^ edgeInfos sort: [ :a :b | a yMax > b yMax ]
]

{ #category : #polygon }
KnFormDisplay >> updateXValues: edges from: from to: to scan: scan [
	| k2 info1 info2 |
	k2 := to.
	to to: from by: -1 do: [ :k1 | 
		info1 := edges at: k1.
		info2 := edges at: k2.
		info1 yMin < scan
			ifTrue: [ info2 xa: info1 nextXa.
				k1 = k2
					ifFalse: [ info2
							yMin: info1 yMin;
							dx: info1 dx ].
				k2 := k2 - 1 ] ].
	^ k2 + 1
]

{ #category : #api }
KnFormDisplay >> viewport [
	^ {0.
	form width.
	form height.
	0}
]

{ #category : #private }
KnFormDisplay >> width [
	^ self form width
]

{ #category : #polygon }
KnFormDisplay >> xsort: aCollection from: anInteger1 to: anInteger2 [
	| l a b tmp |
	anInteger1 to: anInteger2 do: [ :k | 
		l := k.
		[ l > anInteger1
			and: [ a := aCollection at: l.
				b := aCollection at: l - 1.
				a xa < b xa ] ]
			whileTrue: [ tmp := a yMin.
				a yMin: b yMin.
				b yMin: tmp.
				tmp := a xa.
				a xa: b xa.
				b xa: tmp.
				tmp := a dx.
				a dx: b dx.
				b dx: tmp.
				l := l - 1 ] ]
]
