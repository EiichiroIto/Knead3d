Extension { #name : #Number }

{ #category : #'*Knead3d' }
Number >> divideByVec4: vec4 [
	^ vec4 class 
		fromArray: (vec4 array collect: [ :each | each / self ])
]

{ #category : #'*Knead3d' }
Number >> multiplyByVec4: vec4 [
	^ vec4 class 
		fromArray: (vec4 array collect: [ :each | each * self ])
]
