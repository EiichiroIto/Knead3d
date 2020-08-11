Class {
	#name : #Kn3DExample3,
	#superclass : #Object,
	#instVars : [
		'presenter',
		'builder'
	],
	#category : #'Knead3d-Examples'
}

{ #category : #api }
Kn3DExample3 >> build1 [
	self builder
		clear;
		directionX: 1 y: 0 z: 0;
		forward: 20;
		rotate: 120;
		forward: 20;
		rotate: 120;
		forward: 20.
	self presenter updateDisplay
]

{ #category : #api }
Kn3DExample3 >> build2 [
	self builder
		directionX: 0 y: 1 z: 0;
		forward: 10;
		mold;
		forward: 10;
		mold.
	self presenter updateDisplay
]

{ #category : #api }
Kn3DExample3 >> build3 [
	5 to: 1 by: -1 do: [ :each | 
		self builder
			forward: each;
			shrink: 1;
			mold ].
	1 to: 5 by: 1 do: [ :each | 
		self builder
			forward: each;
			shrink: -2;
			mold ].
	self presenter updateDisplay
]

{ #category : #api }
Kn3DExample3 >> build3b [
	self builder
		forward: 10;
		directionX: 1 y: 1 z: 0;
		forward: 5;
		mold;
		forward: 10;
		directionX: 2 y: 0 z: 0;
		forward: 5;
		mold;
		forward: 10;
		directionX: 2 y: -1 z: 0;
		forward: 5;
		mold;
		forward: 10;
		directionX: 1 y: -1 z: 0;
		forward: 5;
		mold;
		forward: 10;
		directionX: 0 y: -1 z: 0;
		forward: 5;
		mold;
		forward: 5;
		mold.
	self presenter updateDisplay
]

{ #category : #accessing }
Kn3DExample3 >> builder [
	^ builder
]

{ #category : #private }
Kn3DExample3 >> newBuilder [
	^ Kn3DObjectBuilder new
]

{ #category : #private }
Kn3DExample3 >> newParam [
	^ KnViewingParameter new
		viewReferencePoint: (self newVecX: 0 y: 0 z: 0);
		viewPlaneNormal: (self newVecX: 0 y: 0 z: -1);
		viewDistance: 0;
		viewUp: (self newVecX: 0 y: 1 z: 0);
		frontDistance: nil;
		backDistance: nil;
		window: #(-0.5 0.5 -0.5 0.5);
		yourself
]

{ #category : #private }
Kn3DExample3 >> newPresenter [
	^ SpKneadStage new
]

{ #category : #private }
Kn3DExample3 >> newVecX: x y: y z: z [
	^ KnVec4 x: x y: y z: z
]

{ #category : #private }
Kn3DExample3 >> newWorld [
	^ Kn3DWorld new
]

{ #category : #api }
Kn3DExample3 >> open [
	| w |
	w := self newWorld.
	w parameter: self newParam.
	presenter := self newPresenter.
	presenter viewer extent: 200 @ 200.
	presenter knWorld: w.
	self setup.
	builder := self newBuilder.
	presenter whenBuildObject: [ :w1 | builder buildObject: w1 ].
	presenter openWithSpec.
	self inspect
]

{ #category : #accessing }
Kn3DExample3 >> presenter [
	^ presenter
]

{ #category : #api }
Kn3DExample3 >> setup [
	self world parameter viewReferencePoint: (KnVec4 x: 0.1 y: 0.1 z: -0.1).
	self presenter setPerspectiveView.
	self presenter resetView
]

{ #category : #accessing }
Kn3DExample3 >> world [
	^ presenter knWorld
]
