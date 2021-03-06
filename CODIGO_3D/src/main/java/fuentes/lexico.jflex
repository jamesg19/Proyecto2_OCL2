package fuentes;

import java_cup.runtime.Symbol;
import Interfaz.Interfaz_c3d;

//Scanner para generar C3D

%%
%{
    //Código de usuario
%}

%cup
%class scanner
%public
%line
%char
%column
%full
%ignorecase

//simbolos

PAR_A   = "("
PAR_C   = ")"
LLAV_A  = "{"
LLAV_C  = "}" 
COMA    = ","
PYCOMA  = ";"
DPUNTO  = ":" 
ASIG    = "="
INC     = "++"
DEC     = "--"

//expresion

MAS     = "+"
MENOS   = "-"
POR     = "*"
DIV     = "/"
POT     = "^"


//relacionales

BELOW  = "<"
ABOVE  = ">"
BELOWE = "<="
ABOVEE = ">="
EQUAL  = "=="
NEQUAL = "!="  

//logicos

OR      = "||"
AND     = "&&"
XOR     = "!!"
NAND    = "!&"
NOT     = "!"

//palabras reservadas

INT1     = "int"
CHAR1    = "char"

//sentencias

MIENTRAS = "while"
REPETIR   = "repetir"
HASTA    = "hasta"
PARA     = "para"
SI       = "if"
SINO     = "else"
SELEC    = "switch"
HACER    = "do"
DETENER  = "break"
CONTINUA = "continue"
CASO     = "case"
DEFECTO  = "default"  

//expresiones

ENTERO  = [0-9]+
DECIMAL = [0-9]+[.][0-9]+     
ID      = [A-Za-zñÑ][_0-9A-Za-zñÑ]*

SPACE   = [\ \r\t\f\t]
ENTER   = [\ \n]

%%

<YYINITIAL> {INT1}      { return new Symbol(sym.INT1, yyline, yycolumn,yytext());}
<YYINITIAL> {CHAR1}     { return new Symbol(sym.CHAR1, yyline, yycolumn,yytext());}
<YYINITIAL> {MIENTRAS}  { return new Symbol(sym.MIENTRAS, yyline, yycolumn,yytext());}
<YYINITIAL> {HASTA}     { return new Symbol(sym.HASTA, yyline, yycolumn,yytext());}
<YYINITIAL> {REPETIR}   { return new Symbol(sym.REPETIR, yyline, yycolumn,yytext());}
<YYINITIAL> {PARA}      { return new Symbol(sym.PARA, yyline, yycolumn,yytext());}
<YYINITIAL> {SI}        { return new Symbol(sym.SI, yyline, yycolumn,yytext());}
<YYINITIAL> {SINO}      { return new Symbol(sym.SINO, yyline, yycolumn,yytext());}
<YYINITIAL> {SELEC}     { return new Symbol(sym.SELEC, yyline, yycolumn,yytext());}
<YYINITIAL> {CASO}      { return new Symbol(sym.CASO, yyline, yycolumn,yytext());}
<YYINITIAL> {HACER}     { return new Symbol(sym.HACER, yyline, yycolumn,yytext());}
<YYINITIAL> {DETENER}   { return new Symbol(sym.DETENER, yyline, yycolumn,yytext());}
<YYINITIAL> {CONTINUA}  { return new Symbol(sym.CONTINUA, yyline, yycolumn,yytext());}
<YYINITIAL> {DEFECTO}   { return new Symbol(sym.DEFECTO, yyline, yycolumn,yytext());}


<YYINITIAL> {PAR_A}     {return new Symbol(sym.PAR_A, yyline, yycolumn,yytext());}
<YYINITIAL> {PAR_C}     {return new Symbol(sym.PAR_C, yyline, yycolumn,yytext());}
<YYINITIAL> {LLAV_A}    {return new Symbol(sym.LLAV_A, yyline, yycolumn,yytext());}
<YYINITIAL> {LLAV_C}    {return new Symbol(sym.LLAV_C, yyline, yycolumn,yytext());}
<YYINITIAL> {COMA}      {return new Symbol(sym.COMA, yyline, yycolumn,yytext());}
<YYINITIAL> {PYCOMA}    {return new Symbol(sym.PYCOMA, yyline, yycolumn,yytext());}
<YYINITIAL> {DPUNTO}    {return new Symbol(sym.DPUNTO, yyline, yycolumn,yytext());}
<YYINITIAL> {ASIG}      {return new Symbol(sym.ASIG, yyline, yycolumn,yytext());}
<YYINITIAL> {INC}       {return new Symbol(sym.INC, yyline, yycolumn,yytext());}
<YYINITIAL> {DEC}       {return new Symbol(sym.DEC, yyline, yycolumn,yytext());}

//logicos
<YYINITIAL> {OR}    {return new Symbol(sym.OR, yyline, yycolumn,yytext());}
<YYINITIAL> {AND}   {return new Symbol(sym.AND, yyline, yycolumn,yytext());}
<YYINITIAL> {XOR}   {return new Symbol(sym.XOR, yyline, yycolumn,yytext());}
<YYINITIAL> {NAND}  {return new Symbol(sym.NAND, yyline, yycolumn,yytext());}
<YYINITIAL> {NOT}   {return new Symbol(sym.NOT, yyline, yycolumn,yytext());}

//relacionales
<YYINITIAL> {ABOVE}  {return new Symbol(sym.ABOVE, yyline, yycolumn,yytext());}
<YYINITIAL> {BELOW}  {return new Symbol(sym.BELOW, yyline, yycolumn,yytext());}
<YYINITIAL> {ABOVEE} {return new Symbol(sym.ABOVEE, yyline, yycolumn,yytext());}
<YYINITIAL> {BELOWE} {return new Symbol(sym.BELOWE, yyline, yycolumn,yytext());}
<YYINITIAL> {EQUAL}  {return new Symbol(sym.EQUAL, yyline, yycolumn,yytext());}
<YYINITIAL> {NEQUAL} {return new Symbol(sym.NEQUAL, yyline, yycolumn,yytext());}

//expresion

<YYINITIAL> {MAS}    { return new Symbol(sym.MAS, yyline, yycolumn,yytext());}
<YYINITIAL> {MENOS}    { return new Symbol(sym.MENOS, yyline, yycolumn,yytext());}
<YYINITIAL> {POR}    { return new Symbol(sym.POR, yyline, yycolumn,yytext());}
<YYINITIAL> {DIV}    { return new Symbol(sym.DIV, yyline, yycolumn,yytext());}
<YYINITIAL> {POT}    { return new Symbol(sym.POT, yyline, yycolumn,yytext());}


<YYINITIAL> {ENTERO}    { return new Symbol(sym.ENTERO, yyline, yycolumn,yytext());}
<YYINITIAL> {DECIMAL}   { return new Symbol(sym.DECIMAL, yyline, yycolumn,yytext());}
<YYINITIAL> {ID}        {return new Symbol(sym.ID, yyline, yycolumn,yytext());}
<YYINITIAL> {SPACE}     { /*Espacios en blanco, ignorados*/ }
<YYINITIAL> {ENTER}     { /*Saltos de linea, ignorados*/}

<YYINITIAL> . {
        String errLex = "Error léxico : '"+yytext()+"' en la línea: "+(yyline+1)+" y columna: "+(yycolumn+1);
        Interfaz_c3d.notificar_er(errLex);
}
