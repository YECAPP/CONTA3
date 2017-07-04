lcMisDocs = ""
*-- Mis Documentos
oWsh = CREATEOBJECT("WScript.Shell")
lcMisDocs = oWsh.SpecialFolders("MyDocuments")
oWsh = NULL

lcArchivo = GetFileX(lcMisDocs)
MESSAGEBOX(lcArchivo )
*lcDir = GETDIR(lcMisDocs, "Mis Documentos","")


*-----------------------------------------
FUNCTION GetFileX(tcRuta, tcExtension, tcLeyenda, tcBoton, tnBoton,tcTitulo)
LOCAL lcDirAnt, lcGetPict
tcRuta = IIF(NOT EMPTY(tcRuta) AND DIRECTORY(tcRuta,1),tcRuta,"")
tcExtension = IIF(EMPTY(tcExtension), "", tcExtension)
tcLeyenda = IIF(EMPTY(tcLeyenda), "", tcLeyenda)
tcBoton = IIF(EMPTY(tcBoton), "", tcBoton)
tnBoton = IIF(EMPTY(tnBoton), 0, tnBoton)
tcTitulo = IIF(EMPTY(tcTitulo), "", tcTitulo)
lcDirAnt = FULLPATH("")
SET DEFAULT TO (tcRuta)
lcGetPict = GETFILE(tcExtension, tcLeyenda, tcBoton, tnBoton, tcTitulo)
SET DEFAULT TO (lcDirAnt)
RETURN lcGetPict
ENDFUNC