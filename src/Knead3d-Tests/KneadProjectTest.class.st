"
A KneadProjectTest is a test class for testing the behavior of KneadProject
"
Class {
	#name : #KneadProjectTest,
	#superclass : #TestCase,
	#category : #'Knead3d-Tests'
}

{ #category : #private }
KneadProjectTest >> newApplication [
	^ Knead3D new
]

{ #category : #private }
KneadProjectTest >> newProject [
	^ KneadProject new
]

{ #category : #test }
KneadProjectTest >> testAddScriptNamed [
	| p |
	p := self newProject.
	self assert: p scripts isEmpty.
	p addScriptNamed: 'abc'.
	self assert: p scripts size equals: 1.
	self assert: p scripts first objName equals: 'abc'.
	p addScriptNamed: 'def'.
	self assert: p scripts size equals: 2.
	self assert: p scripts second objName equals: 'def'
]

{ #category : #test }
KneadProjectTest >> testApplication [
	| p a |
	p := self newProject.
	self assert: p application isNil.
	self assert: p scripts isEmpty.
	a := self newApplication.
	p application: a.
	self assert: p application equals: a.
	self assert: p scripts size equals: 1.
	self assert: p scripts first objName equals: 'main'
]

{ #category : #test }
KneadProjectTest >> testAssureExistsBreed [
	| p |
	p := self newProject.
	self assert: p scripts isEmpty.
	p assureExistsBreed: 'abc'.
	self assert: p scripts size equals: 1.
	self assert: p scripts first objName equals: 'abc'.
	p assureExistsBreed: 'abc'.
	self assert: p scripts size equals: 1.
	p assureExistsBreed: 'def'.
	self assert: p scripts size equals: 2.
	self assert: p scripts second objName equals: 'def'
]

{ #category : #test }
KneadProjectTest >> testNeedBuild [
	| s |
	s := self newProject.
	s addScriptNamed: 'abc'.
	self assert: s needBuild.
	s needBuild: false.
	self deny: s needBuild.
	s needBuild: true.
	self assert: s needBuild
]

{ #category : #test }
KneadProjectTest >> testNewObjStream [
	| p |
	p := self newProject.
	self assert: (p newObjStream isKindOf: STONObjStream)
]

{ #category : #test }
KneadProjectTest >> testPrintOn [
	| p s |
	p := self newProject.
	s := WriteStream on: String new.
	p printOn: s.
	self assert: s contents isString
]
