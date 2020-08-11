Class {
	#name : #SpKneadLibrary,
	#superclass : #SpPresenter,
	#instVars : [
		'buttonMain',
		'buttonSelect',
		'buttonAdd',
		'buttonDelete',
		'buttonOther'
	],
	#category : #'Knead3d-Spec2'
}

{ #category : #specs }
SpKneadLibrary class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #buttonMain;
		add: #buttonOther;
		add: #buttonAdd withConstraints: [ :c | c width: self buttonWidth ];
		add: #buttonSelect withConstraints: [ :c | c width: self buttonWidth ];
		add: #buttonDelete withConstraints: [ :c | c width: self buttonWidth ];
		yourself
]

{ #category : #private }
SpKneadLibrary >> defaultMainButtonName [
	^ 'main'
]

{ #category : #private }
SpKneadLibrary >> defaultOtherButtonName [
	^ '(none)'
]

{ #category : #initialization }
SpKneadLibrary >> initializePresenters [
	buttonMain := self newButton
		label: self defaultMainButtonName;
		icon: (self iconNamed: #page);
		yourself.
	buttonOther := self newButton
		label: self defaultOtherButtonName;
		icon: (self iconNamed: #page);
		yourself.
	buttonSelect := self newButton
		icon: (self iconNamed: #book);
		yourself.
	buttonAdd := self newButton
		icon: (self iconNamed: #add);
		yourself.
	buttonDelete := self newButton
		icon: (self iconNamed: #delete);
		yourself.
	self focusOrder
		add: buttonMain;
		add: buttonSelect;
		add: buttonAdd;
		add: buttonDelete
]

{ #category : #accessing }
SpKneadLibrary >> mainLabel [
	^ buttonMain label asString
]

{ #category : #accessing }
SpKneadLibrary >> otherLabel [
	^ buttonOther label asString
]

{ #category : #accessing }
SpKneadLibrary >> otherLabel: aString [
	buttonOther label: aString
]

{ #category : #accessing }
SpKneadLibrary >> reset [
	self otherLabel: self defaultOtherButtonName.
	self selectButton: self defaultMainButtonName
]

{ #category : #accessing }
SpKneadLibrary >> selectButton: aString [
	buttonMain state: (self mainLabel = aString).
	buttonOther state: (self otherLabel = aString)
]

{ #category : #accessing }
SpKneadLibrary >> whenAddButtonPressed: aBlock [
	buttonAdd action: aBlock
]

{ #category : #accessing }
SpKneadLibrary >> whenDeleteButtonPressed: aBlock [
	buttonDelete action: aBlock
]

{ #category : #accessing }
SpKneadLibrary >> whenMainButtonPressed: aBlock [
	buttonMain action: aBlock
]

{ #category : #accessing }
SpKneadLibrary >> whenOtherButtonPressed: aBlock [
	buttonOther action: [ aBlock cull: self otherLabel ]
]

{ #category : #accessing }
SpKneadLibrary >> whenSelectButtonPressed: aBlock [
	buttonSelect action: aBlock
]
