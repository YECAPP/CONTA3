TRY 

LOCAL err as Exception 
**31 OCTUBRE 2015 ADD UTILITYCONTA PARA VERIFICAR CATALOGO 
IF VARTYPE(_screen.utilityconta1)="U"
	_screen.NewObject("utilityconta1","utilityconta","lib1.0\_conta.vcx")	
ENDIF 


SELECT COUNT(codigo) FROM c1 INTO ARRAY laCount
MESSAGEBOX("Asegurese que el Archivo de Excel sea guardado en formato de excel 95 ó 2003/97",16,"Atencion")

IF laCount=0
	lcfile=GETFILE("xls","Seleccionar el archivo")
	IF !EMPTY(lcfile)
		IF FILE(lcfile)
			**17 may 2016 caragando cusros temporal 
			CREATE CURSOR curC1Temp (codigo c(20), nombre c(80))
			SELECT curC1Temp
			APPEND FROM (lcfile) FIELDS codigo,nombre TYPE XLS 
			
			**buscando duplicados 
			*SELECT codigo, nombre FROM curC1Temp WHERE codigo in (SELECT codigo FROM curC1Temp  GROUP BY 1 HAVING COUNT(*)>1) INTO CURSOR  laArrayDuplicate
			lcMsg=""
			lnCountCuentas=0
			SCAN 
				RELEASE laCodigo
				
				lcCodigo =curC1Temp.Codigo
				lcNombre =curC1Temp.Nombre
				WAIT "Cargando : "+lcCodigo +" "+lcnombre WINDOW NOWAIT 
				lbInsert=.t.
				IF EMPTY(lcCodigo)
					lbInsert=.f.
				ENDIF 
				
				IF ALLTRIM(UPPER(lcCodigo))=="CODIGO"
					lbInsert=.f.
				ENDIF 

				IF lbInsert
					SELECT codigo FROM c1 WHERE ALLTRIM(UPPER(codigo))==ALLTRIM(UPPER(lcCodigo)) into ARRAY laCodigo
					IF VARTYPE(laCodigo)="U"
						INSERT INTO c1 (codigo, nombre ) VALUES (lcCodigo , lcnombre )
						lnCountCuentas = lnCountCuentas + 1 
					ELSE
						lcMsg=lcMsg+PADL(ALLTRIM(lcCodigo),20," ")+" "+ALLTRIM(lcnombre)+CHR(13)
					ENDIF 					
				ENDIF 
			ENDSCAN
			**17 may 2016 caragando cusros temporal 
			IF !EMPTY(lcMsg)
				MESSAGEBOX("Las siguientes cuentas no se cargarón por estar duplicadas:"+CHR(13)+lcMsg,64,"Cuentas duplicadas encontradas")
			ENDIF 
			
			IF !USED("C1")
				USE c1 IN 0 
			ENDIF 
			SELECT c1
			**DO verificacion
			_sCREEN.UTILITYCONTA1.VerificarCata()
			
			SELECT c1
			GO TOP IN c1 
			BROWSE FIELDS codigo, nombre noedit 
			SELECT c1
			USE 
			IF lnCountCuentas>0
				MESSAGEBOX(TRANSFORM(lnCountCuentas)+" Cuentas ingresadas sin problema",64,"Resultado")
			ENDIF 
		ENDIF 
	ENDIF 
ELSE
	MESSAGEBOX("Existen "+TRANSFORM(laCount)+" Cuentas en el catalogo actual"+CHR(13)+;
				"Elimine todas las cuentas antes de importar un nuevo catalogo",16,"Error al importar")
ENDIF 
CATCH TO err 
	MESSAGEBOX(TRANSFORM(err.Details) +err.ErrorNo )
	MESSAGEBOX("1-Asegurese que el Archivo de Excel sea guardado en formato de excel 95 ó 2003/97"+CHR(13)+;
			"2-asegurese que el archivo que esta importando este cerrado y no este en uso por ningun otro usuario",16,"Error")
ENDTRY 