PUBLIC gcIcoForm
PUBLIC 	gc0000000001,gc0000000002,gc0000000003,gc0000000004,gc0000000005,gc0000000004,;
		gc0000000005,gc0000000006,gc0000000007,gc0000000008,gc0000000009,gc0000000010,;
		gc0000000011,gc0000000012,gc0000000013,gc0000000014,gc0000000015,gc0000000016,;
		gc0000000017,gc0000000018,gc0000000019,gc0000000020

&&20 de mayo de 2014 se agregó function por que s eusará en ygridra para refilar los combos 
IF VARTYPE(_screen.functions1)="U"
	_screen.NewObject("functions1","functions","lib1.0\_vars.vcx")
ENDIF 

*!*			gcPictureBarraLogo="\icons\barralogo (2).jpg"
gcIcoForm="ICO\newwicons\Logo.ico"
*!*			gcPictureLogo="\icons\PYME.bmp"
*!*			LCICO=FULLPATH("")+gcIcoForm
*!*		    _SCREEN.Icon=LCICO


**13/10/2015 PARAMETROS DE CONTA SE INTEGRARON PRODUCTO DE LA FUSION DE AMBOS SISTEMAS 
IF VARTYPE(_screen.utilityconta1)="U"
	_screen.NewObject("utilityconta1","utilityconta","lib1.0\_conta.vcx")
ENDIF
**13/10/2015 PARAMETROS DE CONTA SE INTEGRARON PRODUCTO DE LA FUSION DE AMBOS SISTEMAS 

lbClose=.t.
IF !USED("INFOAPP")
	USE DATA\INFOAPP.DBF IN 0 
ELSE
	lbClose=.f.	
ENDIF 

**17 10 se agregaron las variables globales almacenadas en tabla parametros, 
**estas variables se almacenan en infoapp.dbf 

gc0000000001=ALLTRIM(_SCREEN.UTIlityconta1.GETparam("0000000001"))&&ANCHO DE CUENTAS DE MAYOR EN STRICT MODE
gc0000000002=ALLTRIM(_SCREEN.UTIlityconta1.GETparam("0000000002"))&&CUENTAS DEUDORAS                        
gc0000000003=ALLTRIM(_SCREEN.UTIlityconta1.GETparam("0000000003"))&&vacio
gc0000000004=ALLTRIM(_SCREEN.UTIlityconta1.GETparam("0000000004"))&&Cuenta de Gastos                        
gc0000000005=ALLTRIM(_SCREEN.UTIlityconta1.GETparam("0000000005"))&&Cuenta de Gastos                        
gc0000000006=ALLTRIM(_SCREEN.UTIlityconta1.GETparam("0000000006"))&&Cuenta de Resultados                    
gc0000000007=ALLTRIM(_SCREEN.UTIlityconta1.GETparam("0000000007"))&&Cuenta de Contingencia                  
gc0000000008=ALLTRIM(_SCREEN.UTIlityconta1.GETparam("0000000008"))&&Cuenta de Presupuestos                  
gc0000000009=ALLTRIM(_SCREEN.UTIlityconta1.GETparam("0000000009"))&&Cuenta de Activo                        
gc0000000010=ALLTRIM(_SCREEN.UTIlityconta1.GETparam("0000000010"))&&Cuenta de Pasivos                       
gc0000000011=ALLTRIM(_SCREEN.UTIlityconta1.GETparam("0000000011"))&&Cuenta de Capital                       
gc0000000012=ALLTRIM(_SCREEN.UTIlityconta1.GETparam("0000000012"))&&Cuentas de Costo de Venta               
gc0000000013=ALLTRIM(_SCREEN.UTIlityconta1.GETparam("0000000013"))&&Cuentas Utilidades                      
gc0000000014=ALLTRIM(_SCREEN.UTIlityconta1.GETparam("0000000014"))&&FIRMA REPORTES CONTAS HECHO 
gc0000000015=ALLTRIM(_SCREEN.UTIlityconta1.GETparam("0000000015"))&&FIRMA REPORTES CONTAS REVISADO  
gc0000000016=ALLTRIM(_SCREEN.UTIlityconta1.GETparam("0000000016"))&&FIRMA REPORTES CONTAS AUDITADO 
gc0000000017=ALLTRIM(_SCREEN.UTIlityconta1.GETparam("0000000017"))&&TIPO DE PDA 1:COMPACTA 2:DETALLADA

**nuevas variables para contabilidad
gc0000000018=ALLTRIM(_SCREEN.UTIlityconta1.GETparam("0000000018"))&&FIRMA DE REP LEGAL 
gc0000000019=ALLTRIM(_SCREEN.UTIlityconta1.GETparam("0000000019"))&&TIPO DE LIBRO MAYOR 1:ULTIMA LINEA 2:MOVIMIENTOS DIARIOS 3:MOVIMIENTO POR MOVIMIENTO
gc0000000020=ALLTRIM(_SCREEN.UTIlityconta1.GETparam("0000000020"))&&IMPRIMIR FECHA Y HORA DE IMPRESION EN LOS REPORTES CONTABLES 


IF lbClose
	SELECT INFOAPP 
	USE
ENDIF 

SET REPORTBEHAVIOR 80

