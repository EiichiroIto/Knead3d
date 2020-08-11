Class {
	#name : #SpKneadFrame,
	#superclass : #SpScratchFrame,
	#instVars : [
		'logo',
		'buttonOpen',
		'buttonSave',
		'buttonExport',
		'menu'
	],
	#category : #'Knead3d-Spec2'
}

{ #category : #specs }
SpKneadFrame class >> defaultSpec [
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				spacing: 4;
				add: #logo withConstraints: [ :c | c width: 200 ];
				add: #buttonOpen
					withConstraints: [ :c | c width: self iconWidth ];
				add: #buttonSave
					withConstraints: [ :c | c width: self iconWidth ];
				add: #buttonExport
					withConstraints: [ :c | c width: self iconWidth ];
				add: #menu;
				yourself)
			withConstraints: [ :c | c height: self toolbarHeight ];
		add:
			(SpBoxLayout newHorizontal
				add: #viewerPane
					withConstraints: [ :c | c width: self viewerPaneWidth ];
				add:
					(SpPanedLayout newHorizontal
						add: #editorPane;
						add:
							(SpBoxLayout newVertical
								add: #titlePane
									withConstraints: [ :c | c height: self titleButtonHeight ];
								add: #stageFrame;
								add: #libraryPane
									withConstraints: [ :c | c height: self libraryPaneHeight ];
								yourself);
						yourself);
				yourself);
		yourself
]

{ #category : #private }
SpKneadFrame class >> libraryPaneHeight [
	^ self buttonHeight + 10
]

{ #category : #initialization }
SpKneadFrame >> connectPresenters [
	buttonOpen action: [ application openProject ].
	buttonSave action: [ application saveProject ].
	buttonExport action: [ application exportSTL ].
	libraryPane
		whenMainButtonPressed: [ application selectScript: application mainScriptName.
			stageFrame updateDisplay ];
		whenOtherButtonPressed: [ :name | 
			application selectScript: name.
			stageFrame updateDisplay ];
		whenAddButtonPressed: [ application addScript.
			stageFrame updateDisplay ];
		whenDeleteButtonPressed: [ application deleteScript.
			stageFrame updateDisplay ];
		whenSelectButtonPressed: [ application selectScript.
			stageFrame updateDisplay ].
	stageFrame whenClearDo: [ application clearAll ]
]

{ #category : #private }
SpKneadFrame >> defaultExtent [
	^ 1024 @ 768
]

{ #category : #private }
SpKneadFrame >> exportMenu [
	^ self newMenu
		addItem: [ :item | 
			item
				name: 'Export S-expression' localized;
				action: [ application exportSexpCode ] ];
		addItem: [ :item | 
			item
				name: 'Export STL' localized;
				action: [ application exportSTL ] ];
		addItem: [ :item | 
			item
				name: 'Export PNG' localized;
				action: [ application saveStageAsImage ] ];
		addItem: [ :item | 
			item
				name: [ application isRecording
						ifTrue: [ 'Stop Stage Recording' localized ]
						ifFalse: [ 'Start Stage Recording' localized ] ];
				autoRefresh: true;
				action: [ application toggleStageRecording ] ];
		yourself
]

{ #category : #private }
SpKneadFrame >> fileMenu [
	^ self newMenu
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'New' localized;
						action: [ application newProject ] ];
				addItem: [ :item | 
					item
						name: 'Open' localized;
						action: [ application openProject ] ];
				addItem: [ :item | 
					item
						name: 'Project Notes' localized;
						action: [ application editNotes ] ];
				addItem: [ :item | 
					item
						name: 'Save' localized;
						action: [ application saveProjectNoDialog ] ];
				addItem: [ :item | 
					item
						name: 'Save As' localized;
						action: [ application saveProject ] ] ];
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'Import ...' localized;
						subMenu: self importMenu ];
				addItem: [ :item | 
					item
						name: 'Export ...' localized;
						subMenu: self exportMenu ] ];
		addItem: [ :item | 
			item
				name: 'Close' localized;
				action: [ application close ] ];
		addItem: [ :item | 
			item
				name: 'Quit' localized;
				action: [ application quit ] ];
		yourself
]

{ #category : #private }
SpKneadFrame >> helpMenu [
	^ self newMenu
		addItem: [ :item | 
			item
				name: ('About ' , application appName) localized;
				action: [ owner window showAbout ] ];
		addItem: [ :item | 
			item
				name: 'Restart' localized;
				action: [ self viewer startStepping ] ];
		addItem: [ :item | 
			item
				name: 'Inspect' localized;
				action: [ application inspect ] ];
		addItem: [ :item | 
			item
				name: 'Settings' localized;
				subMenu: self settingsMenu ];
		yourself
]

{ #category : #private }
SpKneadFrame >> importMenu [
	^ self newMenu
		addItem: [ :item | 
			item
				name: 'Import S-expression' localized;
				action: [ application importSexpCode ] ];
		addItem: [ :item | 
			item
				name: 'Import STL' localized;
				action: [ application importSTL ] ];
		yourself
]

{ #category : #initialization }
SpKneadFrame >> initializePresenters [
	logo := self newImage
		image: (ScratchTheme formAt: #logo);
		yourself.
	buttonOpen := self newButton
		icon: (Smalltalk ui iconNamed: #smallOpen);
		help: 'Open project' localized;
		yourself.
	buttonSave := self newButton
		icon: (Smalltalk ui iconNamed: #smallSave);
		help: 'Save this project' localized;
		yourself.
	buttonExport := self newButton
		icon: (Smalltalk ui iconNamed: #smallExport);
		help: 'Export STL' localized;
		yourself.
	menu := self newMenuBar.
	self setupMenu.
	viewerPane := self instantiate: SpScratchListViewer.
	editorPane := self instantiate: SpScratchEditor.
	titlePane := self instantiate: SpScratchTitle.
	libraryPane := self instantiate: SpKneadLibrary.
	stageFrame := self instantiate: SpKneadStage.
	self focusOrder add: editorPane
]

{ #category : #initialization }
SpKneadFrame >> initializeWindow: aWindow [
	aWindow whenResizingDo: [ :arg |  ]
]

{ #category : #accessing }
SpKneadFrame >> knWorld [
	^ stageFrame knWorld
]

{ #category : #accessing }
SpKneadFrame >> knWorld: aWorld [
	stageFrame knWorld: aWorld.
	aWorld ifNil: [ ^ self ].
	stageFrame
		setPerspectiveView;
		resetView.
	libraryPane reset
]

{ #category : #accessing }
SpKneadFrame >> otherLabel: aString [
	libraryPane otherLabel: aString
]

{ #category : #initialization }
SpKneadFrame >> setupMenu [
	menu
		addItem: [ :item | 
			item
				name: 'File' localized;
				subMenu: self fileMenu ];
		addItem: [ :item | 
			item
				name: 'Help' localized;
				subMenu: self helpMenu ].
	menu applyTo: self
]

{ #category : #accessing }
SpKneadFrame >> stageFrame [
	^ stageFrame
]

{ #category : #accessing }
SpKneadFrame >> status: aString [ 
	editorPane status: aString
]

{ #category : #api }
SpKneadFrame >> updateDisplay [
	application needBuild
		ifFalse: [ ^ self ].
	application needBuild: false.
	stageFrame updateDisplay
]

{ #category : #accessing }
SpKneadFrame >> viewer [
	^ stageFrame viewer
]

{ #category : #accessing }
SpKneadFrame >> whenBuildObject: aBlock [
	stageFrame whenBuildObject: aBlock
]

{ #category : #accessing }
SpKneadFrame >> whenStepsDo: aBlock [
	stageFrame whenStepsDo: aBlock
]
