Class {
	#name : #BaselineOfDPP,
	#superclass : #BaselineOf,
	#category : #BaselineOfDPP
}

{ #category : #baselines }
BaselineOfDPP >> baseline: spec [
  <baseline>
	spec
		for: #(common)
		do: [ 
			spec 
				package: 'DPP';
				package: 'DPP-Tests'	with: [ spec requires: #(DPP) ].
			spec 
				group: 'Core' 						with: #('DPP');
				group: 'Tests' 						with: #('DPP' 'DPP-Tests');
				group: 'default' 					with: #('Core' 'Tests') ]
]
