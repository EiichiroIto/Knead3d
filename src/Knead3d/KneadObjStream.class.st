Class {
	#name : #KneadObjStream,
	#superclass : #ObjStream,
	#category : #'Knead3d-Project'
}

{ #category : #'class initialization' }
KneadObjStream class >> initialize [
	"self initialize"
	self setupVariables
]

{ #category : #private }
KneadObjStream class >> userClasses [
	^ super userClasses, #(
		"id		class"
		(111		KneadProject)
		(112		KneadScript)
	)
]

{ #category : #'entry points' }
KneadObjStream >> readObjFrom: aStream showProgress: aBoolean [
	| str |
	str := aStream upToEnd asString.
	^ STON fromString: str
]

{ #category : #'entry points' }
KneadObjStream >> storeObj: anObject on: aStream [
	| str |
	str := STON toString: anObject.
	aStream nextPutAll: str asByteArray
]
