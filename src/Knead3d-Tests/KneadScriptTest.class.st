"
A KneadScriptTest is a test class for testing the behavior of KneadScript
"
Class {
	#name : #KneadScriptTest,
	#superclass : #TestCase,
	#category : #'Knead3d-Tests'
}

{ #category : #private }
KneadScriptTest >> newBuilder [
	^ Kn3DObjectBuilder new
]

{ #category : #private }
KneadScriptTest >> newProject [
	^ KneadProject new
]

{ #category : #private }
KneadScriptTest >> newScript [
	^ KneadScript new
]

{ #category : #test }
KneadScriptTest >> testAddList [
	| s |
	s := self newScript.
	self assert: s listVarNames isEmpty.
	s addList: 'abc'.
	self assert: s listVarNames size equals: 1.
	s addList: 'def'.
	self assert: s listVarNames size equals: 2.
	self assert: s listVarNames first equals: 'abc'.
	self assert: s listVarNames second equals: 'def'
]

{ #category : #test }
KneadScriptTest >> testAddVariable [
	| s |
	s := self newScript.
	self assert: s varNames isEmpty.
	s addVariable: 'abc'.
	self assert: s varNames size equals: 1.
	s addVariable: 'def'.
	self assert: s varNames size equals: 2.
	self assert: s varNames first equals: 'abc'.
	self assert: s varNames second equals: 'def'
]

{ #category : #test }
KneadScriptTest >> testBlocks [
	| s |
	s := self newScript.
	self assert: s blocks isArray
]

{ #category : #test }
KneadScriptTest >> testBuilder [
	| p |
	p := self newScript.
	self assert: (p builder isKindOf: Kn3DObjectBuilder)
]

{ #category : #test }
KneadScriptTest >> testDeleteList [
	| s |
	s := self newScript.
	s addList: 'abc'.
	s addList: 'def'.
	s addList: 'ghi'.
	s deleteList: 'def'.
	self assert: s listVarNames size equals: 2.
	self assert: s listVarNames first equals: 'abc'.
	self assert: s listVarNames second equals: 'ghi'
]

{ #category : #test }
KneadScriptTest >> testDeleteVariable [
	| s |
	s := self newScript.
	s addVariable: 'abc'.
	s addVariable: 'def'.
	s addVariable: 'ghi'.
	s deleteVariable: 'def'.
	self assert: s varNames size equals: 2.
	self assert: s varNames first equals: 'abc'.
	self assert: s varNames second equals: 'ghi'
]

{ #category : #test }
KneadScriptTest >> testEvaluator [
	| s p |
	s := self newScript.
	p := self newProject.
	s project: p.
	self assert: (s evaluator isKindOf: KneadEvaluator)
]

{ #category : #test }
KneadScriptTest >> testInitialize [
	| s |
	s := self newScript.
	self assert: s varNames isCollection.
	self assert: s listVarNames isCollection
]

{ #category : #test }
KneadScriptTest >> testListVarNames [
	self testAddList
]

{ #category : #test }
KneadScriptTest >> testNeedBuild [
	| s |
	s := self newScript.
	self assert: s needBuild.
	s needBuild: false.
	self deny: s needBuild.
	s needBuild: true.
	self assert: s needBuild
]

{ #category : #test }
KneadScriptTest >> testNewBuilder [
	| p |
	p := self newScript.
	self assert: (p newBuilder isKindOf: Kn3DObjectBuilder)
]

{ #category : #test }
KneadScriptTest >> testNewEvaluator [
	| p |
	p := self newScript.
	self assert: (p newEvaluator isKindOf: KneadEvaluator)
]

{ #category : #test }
KneadScriptTest >> testObjName [
	| s |
	s := self newScript.
	self assert: s objName isNil.
	s objName: 'abc'.
	self assert: s objName equals: 'abc'.
	s objName: 'def'.
	self assert: s objName equals: 'def'
]

{ #category : #test }
KneadScriptTest >> testSetupBlockCategory [
	| s |
	s := self newScript.
	s blockDef.
	s setupBlockCategory.
	self assert: (s blockDef blockColorAt: #basic) isColor
]

{ #category : #test }
KneadScriptTest >> testUseVariableWatcher [
	| s |
	s := self newScript.
	self deny: s useVariableWatcher
]

{ #category : #test }
KneadScriptTest >> testVarNames [
	self testAddVariable
]

{ #category : #test }
KneadScriptTest >> testVariableNameInUse [
	| s |
	s := self newScript.
	s addVariable: 'abc'.
	s addList: 'def'.
	self assert: (s variableNameInUse: 'abc').
	self assert: (s variableNameInUse: 'def').
	self deny: (s variableNameInUse: 'ghi')
]

{ #category : #test }
KneadScriptTest >> testVariablesBlocks [
	| s |
	s := self newScript.
	self assert: s variablesBlocks isArray
]
