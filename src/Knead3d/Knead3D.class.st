Class {
	#name : #Knead3D,
	#superclass : #SpScratchApp,
	#instVars : [
		'runningBlocks',
		'inProcessStep',
		'recorder'
	],
	#category : #'Knead3d-Spec2'
}

{ #category : #accessing }
Knead3D class >> appFolderName [
	^ 'knead'
]

{ #category : #accessing }
Knead3D class >> appName [
	^ 'Knead3D'
]

{ #category : #accessing }
Knead3D class >> extension [
	^ 'kn'
]

{ #category : #'class initialization' }
Knead3D class >> initialize [
	"self initialize"
	ScratchDirectory current appName: self appFolderName.
	ScratchTheme
		themesURL: self themesURL;
		setupThemeNamed: self appFolderName.
	"workaround for travis test errors"
	ObjStream setupVariables.
]

{ #category : #'world menu' }
Knead3D class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self appName asSymbol)
		order: 0.5;
		target: self;
		action: [self new open]; 
		icon: self icon
]

{ #category : #accessing }
Knead3D class >> recodingExtent [
	^ 400 @ 400
]

{ #category : #private }
Knead3D class >> themesURL [
	^ 'https://raw.githubusercontent.com/EiichiroIto/Knead3D/master/Themes.zip'
]

{ #category : #private }
Knead3D >> aboutAppString [
	^ self appName
		,
			'
Copyright © 2020 Eiichiro Ito (ghc02331@nifty.com)
All rights reserved.

Based on Scratch from the MIT Media Lab, v' , self basedVersion
		,
			'
Copyright © 2009 Massachusetts Institute of Technology.
All rights reserved.
'
]

{ #category : #'menu actions' }
Knead3D >> addScript [
	| name script |
	name := UIManager default
		request: 'Enter script name' localized
		initialAnswer: ''.
	(name isNil or: [ name isEmpty ])
		ifTrue: [ ^ self ].
	(project findObjName: name)
		ifNotNil: [ ^ self inform: 'Already exists' localized ].
	script := project addScriptNamed: name.
	presenter
		otherLabel: name;
		target: script
]

{ #category : #private }
Knead3D >> buildObject: aWorld [
	self project buildObject: aWorld active: self target
]

{ #category : #accessing }
Knead3D >> builder [
	^ self target builder
]

{ #category : #'menu actions' }
Knead3D >> clearAll [
	project clearAll
]

{ #category : #private }
Knead3D >> createProject [
	^ KneadProject new
]

{ #category : #'menu actions' }
Knead3D >> deleteScript [
	| list index name script |
	list := self otherScriptNames.
	list isEmpty
		ifTrue: [ ^ self ].
	list size = 1
		ifTrue: [ index := 1 ]
		ifFalse: [ index := UIManager default
				chooseFrom: list
				title: 'Select script name to delete' localized.
			index = 0
				ifTrue: [ ^ self ] ].
	name := list at: index.
	(self confirm: 'Delete script? - ' localized , name)
		ifFalse: [ ^ self ].
	script := project findObjName: name.
	project deleteScript: script.
	presenter
		otherLabel: '(none)';
		target: project scripts first
]

{ #category : #'menu actions' }
Knead3D >> exportSTL [
	self export: STLExporter new extension: self stlExtension isBinary: true
]

{ #category : #'menu actions' }
Knead3D >> exportSexpCode [
	self export: (ScratchSexpExporter appName: self appName) extension: self sexpExtension
]

{ #category : #private }
Knead3D >> imageExtension [
	^ 'png'
]

{ #category : #'menu actions' }
Knead3D >> importSTL [
	self import: STLImporter new extension: self stlExtension isBinary: true.
	self project needBuild: true
]

{ #category : #'menu actions' }
Knead3D >> importSexpCode [
	self import: (ScratchSexpImporter appName: self appName) extension: self sexpExtension
]

{ #category : #initialization }
Knead3D >> initialize [
	super initialize.
	runningBlocks := OrderedCollection new.
	inProcessStep := false
]

{ #category : #private }
Knead3D >> installNewProject: aProject [
	self stopAllProcesses.
	presenter knWorld: self newWorld.
	project := aProject.
	project application: self.
	self setupView.
	Smalltalk garbageCollect.
	project modified: false.
	project needBuild: true.
	presenter updateDisplay
]

{ #category : #processes }
Knead3D >> isProcessRunning [
	^ runningBlocks notEmpty
]

{ #category : #testing }
Knead3D >> isRecording [
	^ recorder notNil
]

{ #category : #accessing }
Knead3D >> knWorld [
	^ presenter knWorld
]

{ #category : #private }
Knead3D >> mainScriptName [
	^ 'main'
]

{ #category : #testing }
Knead3D >> needBuild [
	^ self project needBuild
]

{ #category : #testing }
Knead3D >> needBuild: aBoolean [
	self project needBuild: aBoolean
]

{ #category : #private }
Knead3D >> newCode [
	^ KneadCode new
		yourself
]

{ #category : #private }
Knead3D >> newParam [
	^ KnViewingParameter new
		viewReferencePoint: (KnVec4 x: 0 y: 0.1 z: 0);
		"viewReferencePoint: (KnVec4 x: 0 y: 0 z: 0);"
		viewPlaneNormal: (KnVec4 x: 0 y: 0 z: -1);
		viewDistance: 0;
		viewUp: (KnVec4 x: 0 y: 1 z: 0);
		frontDistance: nil;
		backDistance: nil;
		window: #(-0.5 0.5 -0.3 0.7);
		yourself
]

{ #category : #private }
Knead3D >> newPresenter [
	^ SpKneadFrame basicNew
		application: self;
		initialize;
		whenStepsDo: [ self stepProcesses ];
		whenBuildObject: [ :w | self buildObject: w ];
		yourself
]

{ #category : #private }
Knead3D >> newVecX: x y: y z: z [
	^ KnVec4 x: x y: y z: z
]

{ #category : #private }
Knead3D >> newWorld [
	^ Kn3DWorld new
		parameter: self newParam;
		yourself
]

{ #category : #private }
Knead3D >> otherScriptNames [
	^ 	(project scripts collect: #objName) copyWithout: self mainScriptName
]

{ #category : #processes }
Knead3D >> processesToRun [
	"Answer a collection of processes to run. Filter out any processes for objects have been picked up. Always return a copy of the processes list."

	| result |
	result := runningBlocks collect: #scratchProc.
	result := result select: #notNil.
	"ActiveHand submorphs notEmpty
		ifTrue: [ m := ActiveHand submorphs first.
			result := result reject: [ :proc | proc includesReceiver: m ] ]."
	^ result
]

{ #category : #processes }
Knead3D >> removeTerminatedProcesses [
	"Remove terminated processes from the process list."

	| newRunning proc |
	newRunning := runningBlocks species new: 100.
	runningBlocks
		do: [ :b | 
			(proc := b scratchProc)
				ifNotNil: [ proc isRunning
						ifTrue: [ newRunning addLast: b ]
						ifFalse: [ proc errorFlag
								ifFalse: [ b stop ] ] ] ].
	runningBlocks := newRunning
]

{ #category : #private }
Knead3D >> restoreProject [
	"do nothing"
]

{ #category : #'menu actions' }
Knead3D >> saveStageAsImage [
	| fName saveForm pngExt |
	pngExt := self imageExtension.
	saveForm := presenter stageShotExtent: presenter display extent truncated.
	saveForm ifNil: [ ^ self ].
	fName := self
		chooseNewFileDefault: self projectName
		extension: pngExt
		title: 'Save Stage Snapshot'
		type: #scriptsSnapshot.
	fName ifNil: [ ^ self ].
	fName := fName withExtension: pngExt.
	fName isFile
		ifTrue: [ (UIManager default
				confirm: 'Overwrite existing ' , fName basename , '?')
				ifFalse: [ ^ self ].
			fName delete ].
	saveForm writePNGFileNamed: fName pathString
]

{ #category : #'menu actions' }
Knead3D >> selectScript [
	| list index name script |
	list := self otherScriptNames.
	list isEmpty
		ifTrue: [ ^ self ].
	list size = 1
		ifTrue: [ index := 1 ]
		ifFalse: [ index := UIManager default
				chooseFrom: list
				title: 'Select script to view' localized.
			index = 0
				ifTrue: [ ^ self ] ].
	name := list at: index.
	script := project findObjName: name.
	presenter
		otherLabel: script objName;
		target: script
]

{ #category : #'menu actions' }
Knead3D >> selectScript: aString [
	| script |
	script := project findObjName: aString.
	script ifNil: [ ^ self ].
	presenter target: script
]

{ #category : #private }
Knead3D >> sexpExtension [
	^ 'kns'
]

{ #category : #processes }
Knead3D >> startProcessFor: topBlock [
	"Start a process to run the given block or stack of blocks. Return the  
	new process."

	| sequence proc |
	sequence := topBlock blockSequence.
	sequence first isHatBlock
		ifTrue: [ sequence := sequence allButFirst ].
	topBlock scratchProc ifNotNil: [ topBlock stop ].
	proc := ScratchStackProcess new.
	proc
		topBlock: topBlock;
		expression: sequence.
	topBlock scratchProc: proc.
	(runningBlocks includes: topBlock)
		ifFalse: [ runningBlocks addLast: topBlock ].
	^ proc
]

{ #category : #'menu actions' }
Knead3D >> startStageRecording [
	| ext fName |
	ext := 'gif'.
	fName := self
		chooseNewFileDefault: ''
		extension: ext
		title: 'Start Stage Recording'
		type: #snapshot.
	fName ifNil: [ ^ self ].
	fName := fName withExtension: ext.
	fName exists
		ifTrue: [ (self
				confirm: 'Are you sure you want to overwrite the file''' , fName basename , '''?')
				ifFalse: [ ^ self ].
			fName delete ].
	recorder := ScratchRecorder new
		openFileNamed: fName;
		model: presenter;
		extent: self class recodingExtent.
	self updateStatus
]

{ #category : #processes }
Knead3D >> stepProcesses [
	"Run each Scratch process until it gives up control, then filter out any processes that have terminated."

	"Details: Iterate over a copy of processes to allow processes to stop themselves. During development, the error catcher makes it difficult to track down errors, so it can be disabled."

	| proc |
	presenter updateDisplay.
	self isRecording ifTrue: [ recorder writeForced: false ].
	inProcessStep
		ifTrue: [ ^ self ].
	inProcessStep := true.
	proc := nil.
	self class
		try: [ self processesToRun do: [ :p | (proc := p) runStepFor: self ] ]
		onFailure: [ proc errorFlag: true ].
	self removeTerminatedProcesses.
	inProcessStep := false
]

{ #category : #private }
Knead3D >> stlExtension [
	^ 'stl'
]

{ #category : #processes }
Knead3D >> stopAllProcesses [
	"Stop all running Scratch processes."

	project ifNotNil: [ project stopAllProcesses ].
	runningBlocks := OrderedCollection new.
	inProcessStep := false
]

{ #category : #'menu actions' }
Knead3D >> stopStageRecording [
	recorder ifNil: [ ^ self ].
	recorder close.
	recorder := nil.
	self updateStatus
]

{ #category : #'menu actions' }
Knead3D >> toggleStageRecording [
	self isRecording
		ifTrue: [ self stopStageRecording ]
		ifFalse: [ self startStageRecording ]
]

{ #category : #private }
Knead3D >> updateStatus [
	| str |
	str := ''.
	self isRecording
		ifTrue: [ str := str, ' (Recording)' ].
	presenter status: str
]

{ #category : #accessing }
Knead3D >> viewer [ 
	^ presenter viewer
]
