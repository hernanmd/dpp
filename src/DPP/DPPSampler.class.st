"
# Introduction

The simplest form of sampling is known as exact sampling. In exact sampling, we compute the eigendecomposition of the kernel matrix to sample from the DPP. The eigendecomposition of a matrix is a factorization that represents the matrix as a product of its eigenvectors and eigenvalues.
"
Class {
	#name : #DPPSampler,
	#superclass : #Object,
	#category : #DPP
}

{ #category : #examples }
DPPSampler class >> exampleExactSampling [

	| groundSet kernelMatrix dpp |
	
	"Define the ground set, which represents the items or elements from which we want to sample"
	groundSet := ($A to: $E) asOrderedCollection.
	
	kernelMatrix := PMMatrix rows: #(
		#(1 0.5 0.2 0.1 0.3)
		#(0.5 1 0.4 0.3 0.2)
		#(0.2 0.4 1 0.3 0.1)
		#(0.1 0.3 0.3 1 0.4)
		#(0.3 0.2 0.1 0.4 1) ).
		
	"Define the similarity kernel matrix, which quantifies the pairwise similarity between the elements of the ground set."
	dpp := DPPSampler fromGroundSet: groundSet matrix: kernelMatrix.
	
	"Answer the resulting sample which is a subset of the ground set"
	^ dpp sample.
]

{ #category : #'as yet unclassified' }
DPPSampler >> eigh: aKernelMatrix [
	"Perform eigendecomposition of the kernel matrix"
	

]

{ #category : #'as yet unclassified' }
DPPSampler >> sampleDPP: eValues eigenvectors: eVectors k: k oneHot: oneHotValue [

	| size kValue subset eigenValues eigenVectors |

	kValue := k.
	eigenValues := eValues.
	eigenVectors := eVectors.
	size := eigenValues size.

	kValue 
		ifNil: [ kValue := size ].
	subset := Set new.
	[ subset size < kValue ] whileTrue: [
		| probs index |
		probs := (eigenValues collect: [ :val | val / (1 + val) ]) asArray.
		index := probs indexOf: probs max.
		subset add: index.
		eigenValues := self
			               updateEigenvalues: eigenValues
			               eigenvectors: eigenVectors
			               index: index.
		eigenVectors := self updateEigenvectors: eigenVectors index: index ].
	oneHotValue ifTrue: [
		^ subset collect: [ :val | (1 to: size) collect: [ :i | i = val ] ] ].
	^ subset asArray
]
