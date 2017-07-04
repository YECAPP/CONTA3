DO cleanbd 
DO restoreBds

PROCEDURE cleanbd
	IF INPUTBOX("Ingrese su Clave","Clave","Clave")="admin"
		IF MESSAGEBOX("Esta seguro que desea borrar todas la informacion de la base de datos",20,"Atencion")=6
			IF MESSAGEBOX("Esta operacion no puede deshacerse",20,"Atencion")=6
				DO backupBd WITH "C1"
				DELETE FROM c1 
				DO backupBd WITH "C2"
				DELETE FROM c2
				DO backupBd WITH "C2_M"
				DELETE FROM C2_M
				MESSAGEBOX("Base de Datos reseteada",16,"Información")
			ELSE
				MESSAGEBOX("Operación Abortada",16,"Proceso Cancelado")
			ENDIF 
		ELSE
			MESSAGEBOX("Operación Abortada",16,"Proceso Cancelado")
		ENDIF 
	ELSE
		MESSAGEBOX("Clave no es valida ",16,"Error")
	ENDIF 
ENDPROC 

PROCEDURE BackupBds
	DO backupBd WITH "C1"
	DO backupBd WITH "C2"
	DO backupBd WITH "C2_M"
	MESSAGEBOX("Base de Datos Respaldada",16,"Información",1700)
ENDPROC 


PROCEDURE backupBd
LPARAMETERS tcTB
	lcBckDir="BackUp"
	IF !USED(tcTB)
		USE (tcTB) IN 0 		
	ENDIF 
	
	SELECT (tcTB) 
	WAIT "Respaldando tabla "+lower(tcTB)+".dbf" WINDOW NOWAIT
	
	IF !DIRECTORY(lcBckDir) 
		MD BACKUP
	ENDIF
	
	COPY TO FULLPATH("")+lcBckDir+"\"+ALIAS()+"_"+STRTRAN(STRTRAN(ttoc(DATEtime()),"/","_"),":","_")
	
ENDPROC 

PROCEDURE restoreBds
	**selecionadno el directorio desde donde restaurar
	lcDirectorio= GETDIR("","Seleccione una carpeta","Carpetas",64+16384)
	IF !EMPTY(lcDirectorio)
		DO 	restoreBd WITH "c1", lcDirectorio
		DO 	restoreBd WITH "c2", lcDirectorio
		DO 	restoreBd WITH "c2_M", lcDirectorio
	ENDIF 
	
ENDPROC 

PROCEDURE restoreBd
LPARAMETERS tcTB,tcDirectory
	lcList=CreateListField(tcTB)
	IF !USED(tcTB)
		USE (tcTB) IN 0
	ENDIF
	
	SELECT (tcTB)
	WAIT "Restaurando tabla "+lower(tcTB)+".dbf" WINDOW NOWAIT
	lcTable=ALLTRIM(tcDirectory)+ alltrim(tcTB)
	
	IF !EMPTY(lcTable)

		IF FILE(lcTable+".dbf")
			APPEND FROM (lcTable) FIELDS &lcList
		ELSE
			MESSAGEBOX("No existe la tabla:"+tcTb+".dbf" +CHR(13)+" en el directorio: "+tcDirectory,16,"Error")
		endif
	ELSE 
		MESSAGEBOX("No seleciono ninguna Tabla",16,"Error al copiar")
	ENDIF

ENDPROC

*=====================================
*procedimientos auxiliares 

PROCEDURE CreateListField
LPARAMETERS tcTb
	lcReturn=""

	IF !USED(tcTB)
		USE (tcTB) IN 0
	ENDIF
	
	AFIELDS(lafields,tcTB)
	lnFields=ALEN(lafields,1)
	
	FOR lnField=1 TO lnFields
		lcField=lafields(lnField,1)
		lcTerminator =""
		
		IF lnField=lnFields
			lcTerminator =""
		ELSE 
			lcTerminator =","
		ENDIF 

		IF UPPER(lcField)="LINE"
			lcTerminator =""
		ELSE 
			lcReturn = lcReturn + lcField 
		ENDIF 
		

		lcReturn = lcReturn + lcTerminator 
		
	ENDFOR 

	IF SUBSTR(ALLTRIM(lcReturn),LEN(ALLTRIM(lcReturn)),1)=","
		lcReturn = SUBSTR(lcReturn,1,LEN(lcReturn)-1)
	ENDIF 
	
	RETURN lcReturn 
ENDPROC 