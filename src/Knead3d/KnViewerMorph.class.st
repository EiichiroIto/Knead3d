Class {
	#name : #KnViewerMorph,
	#superclass : #Morph,
	#instVars : [
		'world',
		'display',
		'whenBuildObject',
		'clickedEvent',
		'whenClickedDo',
		'whenDraggingDo',
		'whenDraggedDo',
		'whenStartDragDo',
		'stepBlock',
		'stepTime'
	],
	#category : #'Knead3d-Morphic'
}

{ #category : #'event handling' }
KnViewerMorph >> clickedAt: aPoint [
	world ifNil: [ ^ self ].
	whenClickedDo ifNil: [ ^ self ].
	whenClickedDo cull: (self normalizedPoint: aPoint)
]

{ #category : #accessing }
KnViewerMorph >> display [
	^ display
]

{ #category : #accessing }
KnViewerMorph >> display: aDisplay [
	display := aDisplay
]

{ #category : #'event handling' }
KnViewerMorph >> draggedFrom: aPoint1 to: aPoint2 [
	world ifNil: [ ^ self ].
	whenDraggedDo ifNil: [ ^ self ].
	whenDraggedDo
		cull: (self normalizedPoint: aPoint1)
		cull: (self normalizedPoint: aPoint2)
]

{ #category : #'event handling' }
KnViewerMorph >> draggingFrom: aPoint1 to: aPoint2 [
	world ifNil: [ ^ self ].
	whenDraggingDo ifNil: [ ^ self ].
	whenDraggingDo
		cull: (self normalizedPoint: aPoint1)
		cull: (self normalizedPoint: aPoint2)
]

{ #category : #drawing }
KnViewerMorph >> drawOn: aCanvas [
	| offset |
	super drawOn: aCanvas.
	(display isNil or: [ display form isNil ])
		ifTrue: [ ^ self ].
	offset := (self extent - display form extent) // 2.
	aCanvas drawImage: display form at: self topLeft + offset
]

{ #category : #geometry }
KnViewerMorph >> extent: aPoint [
	super extent: aPoint.
	display ifNil: [ ^ self ].
	display form: (Form extent: 1 @ 1 * self extent min depth: 32).
	world ifNil: [ ^ self ].
	world parameter viewport: display viewport.
	self updateDisplay
]

{ #category : #accessing }
KnViewerMorph >> form [
	^ display form
]

{ #category : #'event handling' }
KnViewerMorph >> handlesMouseDown: anEvent [
	^ true
]

{ #category : #'event handling' }
KnViewerMorph >> handlesMouseMove: anEvent [
	^ true
]

{ #category : #accessing }
KnViewerMorph >> knWorld [
	^ world
]

{ #category : #accessing }
KnViewerMorph >> knWorld: aWorld [
	world := aWorld.
	(aWorld notNil and: [ display notNil ])
		ifFalse: [ ^ self ].
	world parameter viewport: display viewport
]

{ #category : #api }
KnViewerMorph >> modelBounds [
	^ bounds
]

{ #category : #'event handling' }
KnViewerMorph >> mouseDown: anEvent [
	clickedEvent := anEvent.
	self startDragAt: clickedEvent cursorPoint
]

{ #category : #'event handling' }
KnViewerMorph >> mouseMove: anEvent [
	clickedEvent ifNil: [ ^ self ].
	self draggingFrom: clickedEvent cursorPoint to: anEvent cursorPoint
]

{ #category : #'event handling' }
KnViewerMorph >> mouseUp: anEvent [
	clickedEvent ifNil: [ ^ self ].
	(anEvent cursorPoint - clickedEvent cursorPoint) r < 5
		ifTrue: [ self clickedAt: clickedEvent cursorPoint ]
		ifFalse: [ self draggedFrom: clickedEvent cursorPoint to: anEvent cursorPoint ].
	clickedEvent := nil
]

{ #category : #private }
KnViewerMorph >> normalizedPoint: aPoint [
	^ (aPoint - self topLeft) / self extent
]

{ #category : #'event handling' }
KnViewerMorph >> startDragAt: aPoint [
	world ifNil: [ ^ self ].
	whenStartDragDo ifNil: [ ^ self ].
	whenStartDragDo cull: (self normalizedPoint: aPoint)
]

{ #category : #'stepping and presenter' }
KnViewerMorph >> step [
	stepBlock ifNotNil: [ stepBlock value ]
]

{ #category : #'stepping and presenter' }
KnViewerMorph >> stepTime [
	^ stepTime
]

{ #category : #accessing }
KnViewerMorph >> stepTime: anInteger [
	stepTime := anInteger
]

{ #category : #api }
KnViewerMorph >> updateDisplay [
	display ifNil: [ ^ self ].
	display form ifNil: [ self error ].
	world parameter viewport ifNil: [ ^ self ].
	world newView.
	whenBuildObject ifNotNil: [ whenBuildObject cull: world ].
	display needErase: true.
	display interpret: world displayFile.
	self changed
]

{ #category : #'stepping and presenter' }
KnViewerMorph >> wantsSteps [
	^ stepTime notNil
]

{ #category : #accessing }
KnViewerMorph >> whenBuildObject [
	^ whenBuildObject
]

{ #category : #accessing }
KnViewerMorph >> whenBuildObject: aBlock [
	whenBuildObject := aBlock
]

{ #category : #accessing }
KnViewerMorph >> whenClickedDo [
	^ whenClickedDo
]

{ #category : #accessing }
KnViewerMorph >> whenClickedDo: aBlock [
	whenClickedDo := aBlock
]

{ #category : #accessing }
KnViewerMorph >> whenDraggedDo [
	^ whenDraggedDo
]

{ #category : #accessing }
KnViewerMorph >> whenDraggedDo: aBlock [
	whenDraggedDo := aBlock
]

{ #category : #accessing }
KnViewerMorph >> whenDraggingDo [
	^ whenDraggingDo
]

{ #category : #accessing }
KnViewerMorph >> whenDraggingDo: aBlock [
	whenDraggingDo := aBlock
]

{ #category : #accessing }
KnViewerMorph >> whenStartDragDo [
	^ whenStartDragDo
]

{ #category : #accessing }
KnViewerMorph >> whenStartDragDo: aBlock [
	whenStartDragDo := aBlock
]

{ #category : #accessing }
KnViewerMorph >> whenStepsDo: aBlock [
	stepBlock := aBlock
]
