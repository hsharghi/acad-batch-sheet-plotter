; ver. 0.8.7


(defun c:plotter ()
(setq CMDE (getvar "cmdecho")) ; Get cmdecho variable
(setvar "cmdecho" 0)
(setq wucs (getvar "WORLDUCS"))
(if (/= wucs 1)
  (command "ucs" "W")
)

  (princ "\nSpecify sheet plot area: \n select first  corner:")
  (setq firstPoint (getpoint))
  (setq secondPoint (getcorner firstPoint "\n select second corner:" ))
  (if (= hoff nil)
    (setq hoff 0))
  (if (= voff nil)
    (setq voff 0))
  (princ "\nselect Hor offset: < ")
  (princ hoff)
  (princ " > ")
  (setq temp (getdist))
    (if (= temp nil)
    (setq temp hoff)
  )
  (setq hoff temp)
  (princ "\nselect Ver offset: < ")
  (princ voff)
  (princ " > ")
  (setq temp (getdist))
    (if (= temp nil)
    (setq temp voff)
  )
  (setq voff temp)

  (setq width (- (car secondPoint) (car firstPoint)))
  (setq width (abs width))
  (setq height (- (cadr secondPoint) (cadr firstPoint)))
  (setq height (abs height))
  (setq hDist (- hoff width))
  (setq vDist (- voff height))

  (princ "\nspecify plot area\n select first point")
  (setq firstPlotArea (getpoint))
  (setq secondPlotArea (getcorner firstPlotArea "\n select second point" ))
  (setq widthPlotArea (- (car secondPlotArea) (car firstPlotArea)))
  (setq widthPlotArea (abs widthPlotArea))
  (setq heightPlotArea (- (cadr secondPlotArea) (cadr firstPlotArea)))
  (setq heightPlotArea (abs heightPlotArea))

  (setq numH 1)
  (setq numV 1)

  (if (/= 0 hoff) (setq numH (/ (+ widthPlotArea hDist) hoff)))
  (if (/= 0 voff) (setq numV (/ (+ heightPlotArea vDist) voff)))

  (setq i 0)
  (setq j 0)

  (while (< j numV)
    (while (< i numH)
      (setq ll (list (+ (car firstPoint) (* i hoff))
	     	    (- (cadr firstPoint) (* j voff))
		     ))

      (setq ur (list (+ (car secondPoint) (* i hoff))
	     	    (- (cadr secondPoint) (* j voff))
		     ))

	(command "-plot"
          	  "y"
		  ""
		  ""
		  ""
		  "M"
		  ""
		  ""
		  "W"
		  ll
		  ur
		  "1=0.1"
		  ""
		  ""
		  ""
		  ""
		  ""
		  ""
		  ""
		  "y"
)

      (setq i (1+ i))
    )
    (setq j (1+ j))
    (setq i 0)
  )


(setvar "cmdecho" CMDE)

)
