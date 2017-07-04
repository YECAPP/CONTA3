PROCEDURE ArrayFromList2
LPARAMETERS taArray,tcList
	**Ejemplo de uso:
	**LOCAL Arreglo
	**ArrayFromList(@Arreglo,"Item1,Item2,Item3,Item4,Item5")

	**contar numero de comas en la expresion
	DIMENSION taArray(1)
	
	R=1
	DO WHILE !ATC(",",tcList,R)=0
		R = R + 1 
	ENDDO 
	
	**Separar expresiones para los titulos
*	DIMENSION taArray(R)
	lnStartPosition=1
	lnEndPosition=0
	lnCharReturn=0
	FOR N=1 TO R &&ALEN(taArray)
		lnEndPosition=IIF(ATC(",",tcList,N)=0,LEN(tcList)+1,ATC(",",tcList,N))
		lnCharReturn=lnEndPosition-lnStartPosition
		
		lcRowItem=ALLTRIM(SUBSTR(tcList,lnStartPosition,lnCharReturn))
		C=1
		DO WHILE !ATC(":",lcRowItem,C)=0
			C= C+ 1 
		ENDDO 
		
		IF C>ALEN(taArray,2)
			DIMENSION taArray(R,C)
		ENDIF 

		lnStartPosition=lnEndPosition+1
	ENDFOR

	
	**asignar
	lnStartPosition=1
	lnEndPosition=0
	lnCharReturn=0
	FOR N=1 TO R &&ALEN(taArray)
		lnEndPosition=IIF(ATC(",",tcList,N)=0,LEN(tcList)+1,ATC(",",tcList,N))
		lnCharReturn=lnEndPosition-lnStartPosition
		
		lcRowItem=ALLTRIM(SUBSTR(tcList,lnStartPosition,lnCharReturn))
*!*			C=1
*!*			DO WHILE !ATC(":",lcRowItem,C)=0
*!*				C= C+ 1 
*!*			ENDDO 
*!*			
*!*			IF C>ALEN(taArray,2)
*!*				DIMENSION taArray(R,C)
*!*			ENDIF 

		lnStartPosition2=1
		lnEndPosition2=0
		lnCharReturn2=0
		lcItem=""
		FOR M=1 TO ALEN(taArray,2)
			lnEndPosition2=IIF(ATC(":",lcRowItem,M)=0,LEN(lcRowItem)+1,ATC(":",lcRowItem,M))
			lnCharReturn2=lnEndPosition2-lnStartPosition2
			lcItem=ALLTRIM(SUBSTR(lcRowItem,lnStartPosition2,lnCharReturn2))
			taArray(N,M)=lcItem
			lnStartPosition2=lnEndPosition2+1
		ENDFOR 
		&&DISPLAY MEMORY like Arreglo

		lnStartPosition=lnEndPosition+1
	ENDFOR
	RETURN .t.

	
	
ENDPROC 