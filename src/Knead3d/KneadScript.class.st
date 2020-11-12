Class {
	#name : #KneadScript,
	#superclass : #ScratchScript,
	#instVars : [
		'objName',
		'listVarNames',
		'evaluator',
		'vars'
	],
	#category : #'Knead3d-Project'
}

{ #category : #'ston-core' }
KneadScript class >> stonAllInstVarNames [
	^ super stonAllInstVarNames , #(objName varNames listVarNames evaluator)
]

{ #category : #variables }
KneadScript >> addList: aString [
	listVarNames add: aString
]

{ #category : #variables }
KneadScript >> addVariable: aString [
	vars at: aString asSymbol put: 0
]

{ #category : #'block specs' }
KneadScript >> blocks [
	"Answer a collection of block specifications for the blocks that are common to all objects. Block specificatons (Arrays) are interspersed with category names (Strings). A block specification is an Array of the form: (<block spec string> <block type> <selector> [optional initial argument values]).

	Explanation of flags:
		-	no flags
		b	boolean reporter
		c	c-shaped block containing a sequence of commands (always special form)
		r	reporter
		s	special form command with its own evaluation rule
		t	timed command, like wait or glide
		E	message event hat
		K	key event hat
		M	mouse-click event hat
		S	start event hat
		W	when <condition> hat (obsolete)"

	| blocks |
	blocks := #(
		'basic'
			('clear'									-	clear)
			-
			('forward %n'							-	forward:					5)
			('rotate %n'							-	rotate:						90)
			('heading %n'							-	heading:					0)
			-
			('move %n %n %n'						-	moveX:y:z:				0 0 0)
			('direction %n %n %n'				-	directionX:y:z:		0 1 0)
			-
			('penDown'								-	penDown)
			('penUp'									-	penUp)
		'polygon'
			('stamp'									-	stamp)
			('mold'										-	mold)
			-
			('up %n'									-	up: 							10)
			('down %n'								-	down: 						10)
			('roll %n'								-	roll: 						10)
			('pitch %n'								-	pitch:						10)
			"('yaw %n'									-	yaw:							10)"
			-
			('shrink %n'							-	shrink:						1)
			('grow %n'								-	grow:						1)
			-
			('detach'									-	detach)
			('next'										-	next)
		'object'
			('min x'									r	minX)
			('min y'									r	minY)
			('min z'									r	minZ)
			-
			('max x'									r	maxX)
			('max y'									r	maxY)
			('max z'									r	maxZ)
			-
			('rotate object %n'				-	rotateObject:			30)
			('translate x %n y %n z %n'	-	translateX:y:z:		0 0 0)
			-
			('swap x and y'						-	swapXY)
			('swap y and z'						-	swapYZ)
			('swap z and x'						-	swapZX)
		'sensing'
			('pen x'									r penX)
			('pen y'									r penY)
			('pen z'									r penZ)
			-
			('dir x'									r dirX)
			('dir y'									r dirY)
			('dir z'									r dirZ)
			-
			('heading'								r heading)
			('is pen down'							b	isPenDown)
			-
			('has polygon'							b	hasPolygon)
			('has normal vector'				b	hasNormal)
		'control'
			('when start'							G	-)
			-
			('if %b'									c	doIf)
			('if %b'									c	doIfElse)
			-
			('repeat %n'							c	doRepeat 10)
			('while %b'								c	doWhile)
			('repeat until %b'					c	doUntil)
			-
			('call %S'								s	callSubroutine '')
			-
			('stop script'							s	doReturn)
			('stop all'								s	stopAll)
		'operators'
			('%n + %n'								r	+ - -)
			('%n - %n'								r	- - -)
			('%n * %n'								r	* - -)
			('%n / %n'								r	/ - -)
			('- %n'										r	negated: 1)
			-
			('pick random %n to %n'			r	randomFrom:to: 1 10)
			-
			('%s < %s'								b	< '' '')
			('%s = %s'								b	= '' '')
			('%s > %s'								b	> '' '')
			('%n between %n and %n'			b is:between:and: 50 0 100)
			-
			('%b and %b'							b	&)
			('%b or %b'								b	|)
			('not %b'									b	not:)
			-
			('true'										b 	getTrue)
			('false'									b 	getFalse)
			-
			('%n mod %n'							r	\\ - -)
			('round %n'								r	rounded: -)
			('truncate %n'							r	truncated: -)
			-
			('%f of %n'								r	computeFunction:of: 'sqrt' 10)
	).

	^ blocks, self variablesBlocks
]

{ #category : #accessing }
KneadScript >> buildObject: aWorld isActive: aBoolean [
	aWorld
		color:
			(aBoolean
				ifTrue: [ Color white ]
				ifFalse: [ Color gray ]).
	self builder buildObject: aWorld.
	aBoolean
		ifTrue: [ self builder
				buildPenObject: aWorld;
				buildAxesObject: aWorld ]
]

{ #category : #accessing }
KneadScript >> builder [
	^ evaluator builder
]

{ #category : #variables }
KneadScript >> changeVar: aString to: aString2 [
	| v1 v2 |
	v1 := (vars at: aString asSymbol ifAbsent: [ 0 ]) asNumberNoError.
	v2 := aString2 asNumberNoError.
	vars at: aString asSymbol put: v1 + v2
]

{ #category : #accessing }
KneadScript >> clearObjects [
	self evaluator clear
]

{ #category : #variables }
KneadScript >> deleteList: aString [
	listVarNames remove: aString ifAbsent: [  ]
]

{ #category : #variables }
KneadScript >> deleteVariable: aString [
	vars removeKey: aString asSymbol ifAbsent: [  ]
]

{ #category : #evaluation }
KneadScript >> evaluateFunction: aSymbol withArgs: anArgs [
	aSymbol = #setVar:to:
		ifTrue: [ ^ self setVar: anArgs first to: anArgs second ].
	aSymbol = #changeVar:by:
		ifTrue: [ ^ self changeVar: anArgs first to: anArgs second ].
	aSymbol = #getVar:
		ifTrue: [ ^ self getVar: anArgs first ].
	^ super evaluateFunction: aSymbol withArgs: anArgs
]

{ #category : #accessing }
KneadScript >> evaluator [
	^ evaluator
]

{ #category : #variables }
KneadScript >> getVar: aString [
	^ vars at: aString asSymbol
]

{ #category : #initialization }
KneadScript >> initialize [
	super initialize.
	vars := Dictionary new.
	listVarNames := OrderedCollection new.
	evaluator := self newEvaluator
		builder: self newBuilder;
		yourself
]

{ #category : #testing }
KneadScript >> isValidSubName: aString [ 
	^ true
]

{ #category : #'argument menus' }
KneadScript >> listVarNames [
	^ listVarNames
]

{ #category : #testing }
KneadScript >> needBuild [
	^ self evaluator modified
]

{ #category : #accessing }
KneadScript >> needBuild: aBoolean [
	self evaluator modified: aBoolean
]

{ #category : #private }
KneadScript >> newBuilder [
	^ Kn3DObjectBuilder new
]

{ #category : #private }
KneadScript >> newEvaluator [
	^ KneadEvaluator new
]

{ #category : #accessing }
KneadScript >> objName [
	^ objName
]

{ #category : #accessing }
KneadScript >> objName: aString [
	objName := aString
]

{ #category : #variables }
KneadScript >> setVar: aString to: aString2 [ 
	| v |
	v := aString2 isNumberString ifTrue: [ aString2 asNumberNoError ] ifFalse: [aString2].
	vars at: aString asSymbol put: v
]

{ #category : #'block specs' }
KneadScript >> setupBlockCategory [
	super setupBlockCategory.

		"addCategory: 'display' color: (Color h: 264 s: 0.62 v: 0.89);
		addCategory: 'modules' color: (Color h: 296 s: 0.66 v: 0.85);
		addCategory: 'network' color: (Color h: 165 s: 1 v: 0.63);
		addCategory: 'spi' color: (Color h: 225 s: 0.65 v: 0.83);"

	blockDef
		addCategory: 'basic' color: (Color h: 225 s: 0.65 v: 0.83);
		addCategory: 'polygon' color: (Color h: 165 s: 1 v: 0.63);
		addCategory: 'object' color: (Color h: 264 s: 0.62 v: 0.89)
]

{ #category : #processes }
KneadScript >> stopAllProcesses [
	blocksBin isArray
		ifTrue: [ ^ self ].
	blocksBin
		submorphsDo: [ :each | 
			each isBlockMorph
				ifTrue: [ each clearProcess.
					each litUp: false ] ]
]

{ #category : #accessing }
KneadScript >> subHatBlockNamed: aString [
	^ self subBlocks
		detect: [ :each | each subName = aString ]
		ifNone: [ nil ]
]

{ #category : #testing }
KneadScript >> useVariableWatcher [
	^ false
]

{ #category : #'argument menus' }
KneadScript >> varNames [
	^ vars keys sorted
]

{ #category : #variables }
KneadScript >> variableNameInUse: aString [
	^ (self varNames includes: aString) or: [ listVarNames includes: aString ]
]

{ #category : #'block specs' }
KneadScript >> variablesBlocks [
	^ #(
		'list'
			('add %n to %L'									-	append:toList: 10 'list')
			('delete %n of %L'								-	deleteLine:ofList: 1 'list')
			('replace item %n of %L with %n'		-	setLine:ofList:to: 1 'list' 10)
			('clear list %L'									-	clearList: 'list')
			-
			('item %n of %L'									r	getLine:ofList: 1 'list')
			('length of %L'									r	lineCountOfList: 'list')
			('%L contains %n'								b	list:contains: 'list' 10)
			-
			('set all nodes to %L'						- setAllNodesTo: 'list')
			('set all edges to %L'						- setAllEdgesTo: 'list')
			('adjacent nodes to %n into %L'		- adjacentNodesTo:into: 0 'list')
	)
]
