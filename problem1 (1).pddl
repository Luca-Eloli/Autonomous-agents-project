(define (problem grid1)
(:domain lightup) ;; calls domain
(:objects sq11 sq13 sq14 sq15 sq21 sq23 sq31 sq32 sq33 sq34 sq35 sq41 sq43 sq45 sq51 sq52 sq53 sq54 sq55 - grid ;; establishes squares to be lit up, white grid
          sq12 sq22 sq24 sq25 sq42 sq44 - block ;; establishes black blocks
	0 1 2 3 4 - num) ;; number increments
(:init (inc 0 1)(inc 1 2)(inc 2 3)(inc 3 4) ;; number increments
       (adjl sq11 sq12)(adjl sq12 sq13)(adjl sq13 sq14)(adjl sq14 sq15) ;; establishes squares left of each other
       (adja sq11 sq21)(adja sq12 sq22)(adja sq13 sq23)(adja sq14 sq24)(adja sq15 sq25) ;; establishes squares above each other
       (adjl sq21 sq22)(adjl sq22 sq23)(adjl sq23 sq24)(adjl sq24 sq25)
       (adja sq21 sq31)(adja sq22 sq32)(adja sq23 sq33)(adja sq24 sq34)(adja sq25 sq35)
       (adjl sq31 sq32)(adjl sq32 sq33)(adjl sq33 sq34)(adjl sq34 sq35)
       (adja sq31 sq41)(adja sq32 sq42)(adja sq33 sq43)(adja sq34 sq44)(adja sq35 sq45)
       (adjl sq41 sq42)(adjl sq42 sq43)(adjl sq43 sq44)(adjl sq44 sq45)
       (adja sq41 sq51)(adja sq42 sq52)(adja sq43 sq53)(adja sq44 sq54)(adja sq45 sq55)
       (adjl sq51 sq52)(adjl sq52 sq53)(adjl sq53 sq54)(adjl sq54 sq55)
	(blast sq22 0)(blast sq24 0)(blast sq42 0)(blast sq44 0) ;; initialises black block states
)
(:goal (and (forall (?x - grid)(lit ?x))(blast sq22 1)(blast sq24 2)(blast sq42 2)(blast sq44 2))) ;; goal state includes, all ?x grid squares lit up, and 1 adajcent bulb for square 22 and 2 for squares 24 42 and 44
  )