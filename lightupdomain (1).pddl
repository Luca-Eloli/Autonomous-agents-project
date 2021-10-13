(define (domain lightup)
(:requirements :adl :universal-preconditions :existential-preconditions :conditional-effects :derived-predicates :strips :negative-preconditions)
(:types grid block num) ;;establishes types to be later used in predicate definitions

(:predicates 
 	(left ?x7 ?y7 - grid) ;; directional predicate between two grid objects, not between a grid and block
	(adjl ?x ?y ) ;; initial directional predicate used for problem domain
 	(adja ?x ?y ) ;; initial directional predicate used for problem domain
 	(badj ?x - grid  ?y - block) ;;derived predicate for a grid adjacent to a block, direction omitted for simplicity
 	(right ?x8 ?y8 - grid) ;; derived directional predicate for grid spaces
 	(above ?x9 ?y9 - grid) ;; derived directional predicate for grid spaces
 	(below ?x1 ?y1 - grid) ;; "" ""
 	(blast ?b - block ?n - num) ;; predicate to determine the number of bulbs surrounding block squares
    	(lit ?x - grid) ;; predicate to determine if a square is lit
 	(inc ?n1 ?n2 - num) ;; predicate used to increment block numbers
 	(bulb ?x - grid))  ;; predicate to keep track of squares that bulbs are placed in
  
  
(:derived (left ?x ?y - grid) ;; derived predicates to further determine grid layout, these can only be between grid types
          (adjl ?x ?y))
(:derived (above ?x ?y - grid)
          (adja ?x ?y))
(:derived (right ?y5 ?x5 - grid)
    (left ?x5 ?y5 ))
(:derived (below ?y6 ?x6 - grid)
    (above ?x6 ?y6 ))
(:derived (left ?x ?y) ;; derived predicates to connect adjacent squares to help light travel down squares
        (exists (?z - grid)(and (left ?x ?z)(left ?z ?y))))
(:derived (above ?x ?y)
        (exists (?z - grid)(and (above ?x ?z)(above ?z ?y))))
(:derived (right ?x ?y)
       (exists (?z - grid)(and (right ?x ?z)(right ?z  ?y))))
(:derived (below ?x ?y)
        (exists (?z - grid)(and (below ?x ?z)(below ?z ?y))))
  
(:derived (badj ?x ?y) ;; derived predicates to determine adjacent squares to black blocks, no directions for simplicity
         (adjl ?x  ?y)) 
(:derived (badj ?x ?y)
          (adja ?x ?y))
(:derived (badj ?x ?y)
          (adjl ?y ?x))
(:derived (badj ?x ?y)
          (adja ?y ?x))

(:action place-bulb ;; the singular action of this domain
    :parameters (?x - grid) ;; takes one paramter, the square for the bulb
    :precondition (not (lit ?x)) ;; with the precondition that the current square is not lit, by bulb or travelled light
    :effect (and
		 (forall (?y - grid)(when(left ?x ?y)(lit ?y))) ;; lights all connected squares to the parameter square
                (forall (?y - grid)(when(right ?x ?y)(lit ?y)))
                (forall (?y - grid)(when(below ?y ?x)(lit ?y)))
                (forall (?y - grid)(when(above ?y ?x)(lit ?y)))     
    		 (lit ?x)(bulb ?x)
      		 (forall (?b - block ?n1 ?n2 - num) (when(badj ?x ?b) ;; uses a nested forall loop to determine both a possible adjacent square to paramter ?x
			(forall (?n1 - num) (when(and(inc ?n1 ?n2)(blast ?b ?n1)) ;; and to determine what the state of the black block is in
				(not(blast ?b ?n1)) ;; removes the previous black block state 
                ))))
             (forall (?b - block ?n1 ?n2 - num) (when(badj ?x ?b)
			(forall (?n1 - num) (when(and(inc ?n1 ?n2)(blast ?b ?n1))
				(blast ?b ?n2) ;; adds the next state
                ))))

))

)
