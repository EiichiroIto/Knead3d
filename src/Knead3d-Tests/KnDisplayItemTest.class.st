"
A KnDisplayItemTest is a test class for testing the behavior of KnDisplayItem
"
Class {
	#name : #KnDisplayItemTest,
	#superclass : #TestCase,
	#category : #'Knead3d-Tests'
}

{ #category : #private }
KnDisplayItemTest >> newItem [
	^ KnDisplayItem new
]

{ #category : #test }
KnDisplayItemTest >> testArgs [
	self testOpcodeArgs
]

{ #category : #test }
KnDisplayItemTest >> testOpcode [
	| i |
	i := self newItem.
	self assert: i opcode isNil.
	i opcode: 123.
	self assert: i opcode equals: 123
]

{ #category : #test }
KnDisplayItemTest >> testOpcodeArgs [
	| i |
	i := self newItem.
	i opcode: 1 args: #(1 2 3).
	self assert: i opcode equals: 1.
	self assertCollection: i args equals: #(1 2 3).
	i opcode: 2 args: #(4 5 6).
	self assert: i opcode equals: 2.
	self assertCollection: i args equals: #(4 5 6)
]
