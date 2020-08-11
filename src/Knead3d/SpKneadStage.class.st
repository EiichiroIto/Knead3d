Class {
	#name : #SpKneadStage,
	#superclass : #SpPresenter,
	#instVars : [
		'toolBar',
		'rotation',
		'whenUpdateRotation',
		'viewerMorph',
		'temporaryValues',
		'whenClearDo'
	],
	#category : #'Knead3d-Spec2'
}

{ #category : #specs }
SpKneadStage class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #toolBar withConstraints: [ :c | c height: 50 ];
		add: #viewerMorph;
		yourself
]

{ #category : #private }
SpKneadStage >> clear [
	whenClearDo ifNotNil: [ whenClearDo cull: self ]
]

{ #category : #initialization }
SpKneadStage >> connectPresenters [
	self setByAngle
]

{ #category : #accessing }
SpKneadStage >> display [
	^ self viewer
]

{ #category : #accessing }
SpKneadStage >> form [
	^ self viewer form
]

{ #category : #private }
SpKneadStage >> formExtent [
	^ 400 @ 400
]

{ #category : #initialization }
SpKneadStage >> initializePresenter [
	temporaryValues := Dictionary new.
	viewerMorph := self newMorph
		morph: self newViewerMorph
		yourself.
	toolBar := self newToolBar.
	self setupToolBar.
	self focusOrder add: toolBar
]

{ #category : #accessing }
SpKneadStage >> knWorld [
	^ self viewer knWorld
]

{ #category : #accessing }
SpKneadStage >> knWorld: aWorld [
	self viewer knWorld: aWorld
]

{ #category : #private }
SpKneadStage >> newDisplay [
	^ KnFormDisplay new
]

{ #category : #private }
SpKneadStage >> newViewerMorph [
	^ KnViewerMorph new
		stepTime: 100;
		display: self newDisplay;
		color: Color veryDarkGray;
		yourself
]

{ #category : #private }
SpKneadStage >> oldVPN [
	^ temporaryValues at: #oldVPN
]

{ #category : #private }
SpKneadStage >> oldVPN: aNumber [
	aNumber ifNil: [ temporaryValues removeKey: #oldVPN ].
	^ temporaryValues at: #oldVPN put: aNumber
]

{ #category : #private }
SpKneadStage >> oldWindowCenter [
	^ temporaryValues at: #oldWindowCenter
]

{ #category : #private }
SpKneadStage >> oldWindowCenter: aPoint [
	aPoint ifNil: [ temporaryValues removeKey: #oldWindowCenter ].
	^ temporaryValues at: #oldWindowCenter put: aPoint
]

{ #category : #'button actions' }
SpKneadStage >> resetView [
	| p |
	self viewReferencePoint: self knWorld parameter viewReferencePoint.
	p := Point r: 1 degrees: 30.
	self viewPlaneNormal: (KnVec4 x: p x y: 0 z: p y).
	self knWorld
		setPerspective: self viewReferencePoint - (self viewPlaneNormal * 4).
	self knWorld setWindowCenter: 0 @ 0.2
]

{ #category : #'button actions' }
SpKneadStage >> setByAngle [
	self viewer
		whenStartDragDo: [ self oldVPN: self knWorld getViewPlaneNormal ];
		whenDraggingDo: [ :f :t | self updateViewPlaneNormal: t - f ];
		whenDraggedDo: [ self updateDisplay ]
]

{ #category : #'button actions' }
SpKneadStage >> setByViewport [
	self viewer
		whenStartDragDo: [ self oldWindowCenter: self windowCenter ];
		whenDraggingDo: [ :f :t | 
			self
				windowCenter: f - t;
				updateDisplay ];
		whenDraggedDo: [ self updateDisplay ]
]

{ #category : #accessing }
SpKneadStage >> setPerspectiveView [
	self whenUpdateRotation: [ :v | self knWorld setPerspective: v ]
]

{ #category : #initialization }
SpKneadStage >> setupToolBar [
	toolBar
		addItem:
			(SpToolBarButton new
				label: 'window';
				icon: (ScratchTheme formAt: #setWindow);
				action: [ self setByViewport ]);
		addItem:
			(SpToolBarButton new
				label: 'angle';
				icon: (Smalltalk ui iconNamed: #glamorousRefresh);
				action: [ self setByAngle ]);
		addItem:
			(SpToolBarButton new
				label: 'reset';
				icon: (Smalltalk ui iconNamed: #smallHome);
				action: [ self resetView.
					self updateDisplay ]);
		addItem:
			(SpToolBarButton new
				label: 'clear';
				icon: (Smalltalk ui iconNamed: #smallDelete);
				action: [ self clear.
					self updateDisplay ])
]

{ #category : #api }
SpKneadStage >> updateDisplay [
	self viewer updateDisplay
]

{ #category : #private }
SpKneadStage >> updateViewPlaneNormal: aPoint [
	| org degrees p v |
	org := self oldVPN.
	degrees := (org x @ org z) degrees.
	p := Point
		r: org r
		degrees: degrees - (aPoint x * Float pi * 2) radiansToDegrees.
	v := (org x: p x) z: p y.
	degrees := (org x @ org y) degrees.
	p := Point
		r: org r
		degrees: degrees + (aPoint y * Float pi * 2) radiansToDegrees.
	v := v y: p y.
	self viewPlaneNormal: v.
	self knWorld setPerspective: self viewReferencePoint - (v * 4).
	self updateDisplay
]

{ #category : #accessing }
SpKneadStage >> viewPlaneNormal [
	^ self knWorld getViewPlaneNormal
]

{ #category : #accessing }
SpKneadStage >> viewPlaneNormal: aVector [
	self knWorld setViewPlaneNormal: aVector
]

{ #category : #accessing }
SpKneadStage >> viewReferencePoint [
	^ self knWorld getViewReferencePoint
]

{ #category : #accessing }
SpKneadStage >> viewReferencePoint: aVector [
	self knWorld setViewReferencePoint: aVector
]

{ #category : #accessing }
SpKneadStage >> viewer [
	^ viewerMorph morph
]

{ #category : #accessing }
SpKneadStage >> whenBuildObject [
	^ self viewer whenBuildObject
]

{ #category : #accessing }
SpKneadStage >> whenBuildObject: aBlock [
	self viewer whenBuildObject: aBlock
]

{ #category : #accessing }
SpKneadStage >> whenClearDo [
	^ whenClearDo
]

{ #category : #accessing }
SpKneadStage >> whenClearDo: aBlock [
	whenClearDo := aBlock
]

{ #category : #accessing }
SpKneadStage >> whenStepsDo: aBlock [
	self viewer
		whenStepsDo: aBlock;
		startStepping
]

{ #category : #accessing }
SpKneadStage >> whenUpdateRotation [
	^ whenUpdateRotation
]

{ #category : #accessing }
SpKneadStage >> whenUpdateRotation: aBlock [
	whenUpdateRotation := aBlock
]

{ #category : #private }
SpKneadStage >> windowCenter [
	^ self knWorld getWindowCenter
]

{ #category : #private }
SpKneadStage >> windowCenter: aPoint [
	| p |
	p := self oldWindowCenter.
	p := (p x @ p y negated) + aPoint.
	self knWorld setWindowCenter: p x @ p y negated
]
