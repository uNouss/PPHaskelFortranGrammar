Class {
	#name : #PPHaskelFortranGrammar,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'file',
		'metaInfo',
		'listOfNode',
		'node',
		'interval',
		'lines',
		'integer',
		'position',
		'nodeClassName',
		'arguments',
		'line',
		'string',
		'pair'
	],
	#category : #HaskelFortran
}

{ #category : #edges }
PPHaskelFortranGrammar >> arguments [
	^ $( asPParser, $) asPParser
]

{ #category : #edges }
PPHaskelFortranGrammar >> file [
	^ 'ProgramFile' asPParser, metaInfo, listOfNode
]

{ #category : #edges }
PPHaskelFortranGrammar >> integer [
	^ #digit asPParser plus token 
		"==> [ :token | token value asNumber ]"
	
]

{ #category : #edges }
PPHaskelFortranGrammar >> interval [
	^ position, $- asPParser, position
		"==> [ :tokens | { tokens first. tokens third } ]"
]

{ #category : #edges }
PPHaskelFortranGrammar >> line [
	^ listOfNode / string / pair
]

{ #category : #edges }
PPHaskelFortranGrammar >> lines [
	^ line star
]

{ #category : #edges }
PPHaskelFortranGrammar >> listOfNode [
	^ $[ asPParser, $] asPParser /
		($[ asPParser, node,($, asPParser , node) star,  $] asPParser)
]

{ #category : #edges }
PPHaskelFortranGrammar >> metaInfo [
	^ $( asPParser, $) asPParser negate star, $) asPParser 
]

{ #category : #edges }
PPHaskelFortranGrammar >> node [
	^ nodeClassName trim, arguments trim, interval trim, lines
]

{ #category : #edges }
PPHaskelFortranGrammar >> nodeClassName [
	^ #letter asPParser plus trim token, (#letter asPParser plus trim optional)
]

{ #category : #edges }
PPHaskelFortranGrammar >> pair [
	^ $( asPParser, #word asPParser plus token,
		(
			($, asPParser, #space asPParser star, #word asPParser plus token) / 
			(#space asPParser star, string)
		),
		 $) asPParser 
]

{ #category : #edges }
PPHaskelFortranGrammar >> position [
	^ $( asPParser, integer, $: asPParser , integer,  $) asPParser
		"==> [ :tokens | tokens second @ tokens fourth ]"
		
]

{ #category : #accessing }
PPHaskelFortranGrammar >> start [
	"Answer the production to start this parser with."
	
	^ interval end
]

{ #category : #edges }
PPHaskelFortranGrammar >> string [
	^ ($" asPParser, $" asPParser negate star, $" asPParser) token
]
