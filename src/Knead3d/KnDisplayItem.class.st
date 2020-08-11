Class {
	#name : #KnDisplayItem,
	#superclass : #Object,
	#instVars : [
		'opcode',
		'args'
	],
	#category : #'Knead3d-Core'
}

{ #category : #constants }
KnDisplayItem class >> color [
	^ -1
]

{ #category : #constants }
KnDisplayItem class >> cursor [
	^ 0
]

{ #category : #constants }
KnDisplayItem class >> line [
	^ 2
]

{ #category : #constants }
KnDisplayItem class >> move [
	^ 1
]

{ #category : #'instance creation' }
KnDisplayItem class >> opcode: anInteger arg: anObject [
	^ self new
		opcode: anInteger args: {anObject};
		yourself
]

{ #category : #'instance creation' }
KnDisplayItem class >> opcode: anInteger args: aCollection [
	^ self new
		opcode: anInteger args: aCollection;
		yourself
]

{ #category : #comparing }
KnDisplayItem >> = other [
	^ opcode = other opcode and: [ args = other args ]
]

{ #category : #accessing }
KnDisplayItem >> arg [
	^ args first
]

{ #category : #accessing }
KnDisplayItem >> args [
	^ args
]

{ #category : #accessing }
KnDisplayItem >> opcode [
	^ opcode
]

{ #category : #accessing }
KnDisplayItem >> opcode: anInteger [
	opcode := anInteger
]

{ #category : #private }
KnDisplayItem >> opcode: anInteger args: aCollection [
	self opcode: anInteger.
	args := aCollection copy asArray
]

{ #category : #printing }
KnDisplayItem >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPutAll: '(opcode=';
		nextPutAll: opcode asString;
		nextPutAll: ',args=';
		nextPutAll: args asString;
		nextPut: $)
]
