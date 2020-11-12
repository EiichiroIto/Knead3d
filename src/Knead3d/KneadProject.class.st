Class {
	#name : #KneadProject,
	#superclass : #ScratchProject,
	#category : #'Knead3d-Project'
}

{ #category : #accessing }
KneadProject class >> appVersion [
	^ 1
]

{ #category : #accessing }
KneadProject class >> appVersionTag [
	^ 'Knead3DV'
]

{ #category : #accessing }
KneadProject >> addScriptNamed: aString [
	| script |
	script := KneadScript new
		project: self;
		objName: aString;
		yourself.
	self addScript: script.
	^ script
]

{ #category : #accessing }
KneadProject >> application: anApplication [
	super application: anApplication.
	scripts isEmpty
		ifTrue: [ self addScriptNamed: anApplication mainScriptName ]
]

{ #category : #accessing }
KneadProject >> assureExistsBreed: each [
	((self scripts collect: #objName) includes: each)
		ifTrue: [ ^ self ].
	self addScriptNamed: each
]

{ #category : #accessing }
KneadProject >> buildObject: aWorld active: aScript [
	(self scripts copyWithout: aScript)
		do: [ :each | each buildObject: aWorld isActive: false ].
	aScript buildObject: aWorld isActive: true
]

{ #category : #accessing }
KneadProject >> clearAll [
	scripts do: #clearObjects
]

{ #category : #testing }
KneadProject >> needBuild [
	^ self scripts anySatisfy: [ :each | each needBuild ]
]

{ #category : #testing }
KneadProject >> needBuild: aBoolean [
	scripts do: [ :each | each needBuild: aBoolean ]
]

{ #category : #private }
KneadProject >> newObjStream [
	^ STONObjStream new
]

{ #category : #accessing }
KneadProject >> objects [
	| stream |
	stream := WriteStream on: Array new.
	self scripts do: [ :each | stream nextPutAll: each builder objects ].
	^ stream contents
]

{ #category : #printing }
KneadProject >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(;
		nextPutAll: self identityHash asString;
		nextPut: $)
]

{ #category : #processes }
KneadProject >> stopAllProcesses [
	scripts do: #stopAllProcesses
]
