
//james
%{ 
    var indents = [0]
    var indent = 0
    var cant_existencia = 0
    var dedents = 0
    var  val_actual = ""%}
%lex

reserved                                {keywords}|{operadores}
keywords                                "continue"|
                                        "finally"|
                                        "jison "|
                                        "global"|
                                        "assert"|
                                        "except"|
                                        "import"|
                                        "lambda"|
                                        "raise"|
                                        "class"|
                                        "print"|
                                        "break"|
                                        "while"|
                                        "yield"|
                                        "from"|
                                        "elif"|
                                        "else"|
                                        "with"|
                                        "pass"|
                                        "exec"|
                                        "and"|
                                        "del"|
                                        "not"|
                                        "def"|
                                        "for"|
                                        "try"|
                                        "as"|
                                        "or"|
                                        "if"|
                                        "input"|
                                        "in"|
                                        "is"|
                                        "range"

palabras_reservadas                     "public" | 
                                        "private" | 
                                        "class" | 
                                        "extends" | 
                                        "intinput" | 
                                        "floatinput" | 
                                        "charinput" | 
                                        "int" |
                                        "String" | 
                                        "char" | 
                                        "float" | 
                                        "boolean" | 
                                        "true" | 
                                        "false" |
                                        "else" | 
                                        "while" | 
                                        "for" | 
                                        "do" | 
                                        "break" | 
                                        "continue" |
                                        "return" | 
                                        "(" | ")" | 
                                        "{" | "}" | 
                                        "," | ":" | ";" | 
                                        "," | "void" | 
                                        "case" | 
                                        "switch" | 
                                        "default" | 
                                        "println"| 
                                        "print" 


operadores                               ">>="
                                        |"<<="|
                                        "**="|
                                        "//="|
                                        "+="|
                                        "-="|
                                        "*="|
                                        "/="|
                                        "%="|
                                        "&="|
                                        "|="|
                                        "^="|
                                        "**"|
                                        "//"|
                                        "<<"|
                                        ">>"|
                                        "<="|
                                        ">="|
                                        "=="|
                                        "!="|
                                        "<>"|
                                        "+"|
                                        "-"|
                                        "*"|
                                        "/"|
                                        "%"|
                                        "&"|
                                        "|"|
                                        "^"|
                                        "~"|
                                        "<"|
                                        ">"|
                                        "("|")"|
                                        "["|"]"|
                                        "{"|"}"|
                                        "@"|","|":"|"."|"`"|
                                        "="|";"|"'"|"""|"#"|"\"          

identificador_python                              ("_"|{letter})({letter}|{digit}|"_")*
letter                                  {lowercase}|{uppercase}
lowercase                               [a-z]
uppercase                               [A-Z]
digit                                   ([0]|[1-9][0-9]*)
inicio_python                         "%%PYTHON"
inicio_java                           "%%JAVA"

/** strings **/
longstring                              {longstring_double}|{longstring_single}
longstring_double                       '"""'{longstringitem}*'"""'
longstring_single                       "'''"{longstringitem}*"'''"
longstringitem                          {longstringchar}|{escapeseq}
longstringchar                          [^\\]

shortstring                             {shortstring_double}|{shortstring_single}
shortstring_double                      '"'{shortstringitem_double}*'"'
shortstring_single                      "'"{shortstringitem_single}*"'"
shortstringitem_double                  {shortstringchar_double}|{escapeseq}
shortstringitem_single                  {shortstringchar_single}|{escapeseq}
shortstringchar_single                  [^\\\n\']
shortstringchar_double                  [^\\\n\"]
escapeseq                               \\.

/** floats **/
float                                   ([0]|[1-9][0-9]*)("."[0-9]+)

/** reserved **/                            

%s INITIAL PYTHON DEDENT INDENT JAVA PROGRAMA

%%
<INITIAL>[\ \n]+                        %{ console.log("eninicio"); %}
<INITIAL>[\t]                           %{ console.log("tabulacion"); %}
<INITIAL>{inicio_python}              %{ this.begin("PYTHON"); return 'PYTHON'; %}
<PYTHON>[\ ]+                           %{ /*espacios en blanco*/ %}
<PYTHON>\t                              %{ /*tabulacion*/ %}
<PYTHON>(\r?\n)+                     	%{ cant_existencia = 0; this.begin("INDENT"); return 'SALTO'; %}
<PYTHON>{inicio_java}                 %{ this.begin("JAVA"); return 'JAVA' %}
<PYTHON>'if'                              %{ return 'IF'; %}
<PYTHON>'else'                            %{ return 'ELSE'; %}
<PYTHON>'elif'                            %{ return 'ELIF'; %}
<PYTHON>'+='                               %{ return 'MAS_ASIGNAR'; %}
<PYTHON>'++'                               %{ return 'MAS'; %}
<PYTHON>'--'                               %{ return 'MENOS'; %}
<PYTHON>'+'                               %{ return 'SUMA'; %}
<PYTHON>'-'                               %{ return 'RESTA'; %}
<PYTHON>'*'                               %{ return 'POR'; %}
<PYTHON>'/'                               %{ return 'ENTRE'; %}
<PYTHON>'^'                               %{ return 'POT'; %}
<PYTHON>'&&'                               %{ return 'AND'; %}
<PYTHON>'||'                               %{ return 'OR'; %}
<PYTHON>'!'                               %{ return 'NOT'; %}
<PYTHON>'='                               %{ return 'ASIGNAR'; %}
<PYTHON>'=='                               %{ return 'IGUAL_IGUAL'; %}
<PYTHON>'!='                               %{ return 'DIFERENTE'; %}
<PYTHON>'>'                               %{ return 'MAYOR'; %}
<PYTHON>'>='                               %{ return 'MAYOR_IGUAL'; %}
<PYTHON>'<'                               %{ return 'MENOR'; %}
<PYTHON>'<='                               %{ return 'MENOR_IGUAL'; %}
<PYTHON>{reserved}                      %{ return yytext; %}
<PYTHON>{digit}                         %{ return 'INT'; %}
<PYTHON>{float}                         %{ return 'FLOAT'; %}
<PYTHON>{shortstring_double}                   %{ return 'STRING'; %}
<PYTHON>{shortstring_single}                   %{ return 'CHAR'; %}
<PYTHON>{identificador_python}                    %{ return 'IDENTIFICADOR'; %}
<INDENT>\t                               %{ cant_existencia += 1; %}
<INDENT>\t                               %{ cant_existencia += 1; %}
<INDENT>(\r?\n)+                     	%{ cant_existencia = 0; %}
<INDENT>.                               %{ 
                                            var cant = indent - cant_existencia;
                                            this.unput(yytext);
                                            if (cant==-1){
                                                indent = cant_existencia;
                                                this.begin('PYTHON');
                                                return 'INDENT';
                                            } else if (cant > 0){
                                                indent = cant_existencia;
                                                dedents = cant;
                                                this.begin('DEDENT');
                                            } else if (cant==0){
                                                dedents = 0;
                                                this.begin('PYTHON');
                                            } else {
                                                var cuantos = (cant*-1)-1;
                                                this.begin('PYTHON');
                                                indent++;
                                                return 'INDENT';
                                            } 
                                        %}
<DEDENT>.                              %{
                                            this.unput(yytext);
                                            if (dedents!=0){
                                                dedents--;
                                                return 'DEDENT';
                                            } else {
                                                this.begin("PYTHON");
                                            }
                                        %}
<JAVA>[\ \n\t\s\r]+                     %{  %}
<JAVA>'%%PROGRAMA'                      %{ this.begin("PROGRAMA"); return 'PROGRAMA'; %}
<JAVA>'if'                              %{ return 'IF'; %}
<JAVA>'else'                            %{ return 'ELSE'; %}
<JAVA>'+='                               %{ return 'MAS_ASIGNAR'; %}
<JAVA>'-='                               %{ return 'MENOS_ASIGNAR'; %}
<JAVA>'++'                               %{ return 'MAS'; %}
<JAVA>'--'                               %{ return 'MENOS'; %}
<JAVA>'+'                               %{ return 'SUMA'; %}
<JAVA>'-'                               %{ return 'RESTA'; %}
<JAVA>'*'                               %{ return 'POR'; %}
<JAVA>'/'                               %{ return 'ENTRE'; %}
<JAVA>'^'                               %{ return 'POT'; %}
<JAVA>'&&'                               %{ return 'AND'; %}
<JAVA>'||'                               %{ return 'OR'; %}
<JAVA>'!'                               %{ return 'NOT'; %}
<JAVA>'='                               %{ return 'ASIGNAR'; %}
<JAVA>'=='                               %{ return 'IGUAL_IGUAL'; %}
<JAVA>'!='                               %{ return 'DIFERENTE'; %}
<JAVA>'>'                               %{ return 'MAYOR'; %}
<JAVA>'>='                               %{ return 'MAYOR_IGUAL'; %}
<JAVA>'<'                               %{ return 'MENOR'; %}
<JAVA>'<='                               %{ return 'MENOR_IGUAL'; %}
<JAVA>{palabras_reservadas}                      %{ return yytext; %}
<JAVA>{float}                           %{ return 'FLOAT'; %}
<JAVA>{digit}                           %{ return 'INT'; %}
<JAVA>{shortstring_double}                   %{ return 'STRING'; %}
<JAVA>{shortstring_single}                   %{ return 'CHAR'; %}
<JAVA>{identificador_python}                      %{ return 'IDENTIFICADOR'; %}
<PROGRAMA>[\ \n\t\s\r]+                     %{ /*nada*/ %}
<PROGRAMA>'hola'                        %{ return 'HOLA'; %}
<<EOF>>                        %{ return 'EOF'; %}

/lex

/* operator associations and precedence */
%left MAS MENOS
%left SUMA RESTA
%left POR ENTRE
%left POT
%left OR
%left AND
%left IGUAL_IGUAL DIFERENTE MAYOR MAYOR_IGUAL MENOR MENOR_IGUAL
%right NOT
%left UMINUS

%start expressions

%% /* language grammar */

expressions
    : EOF
        {console.log("Vacio");}
    |   PYTHON codigo_python 
        JAVA codigo_java 
        PROGRAMA HOLA EOF
        {console.log("Encontrados bloques de python y de java")}
;
//---------------------------------------------CLASES JAVA--------------------------------------------
//---------------------------------------------CLASES JAVA--------------------------------------------
//---------------------------------------------CLASES JAVA--------------------------------------------
codigo_java:
    |   clases
;

clases:
    clases clase
    | clase
;
clase:
    'public' 'class' IDENTIFICADOR herencia '{' body_class '}'
;

body_class:
    body_class parte_java
    | parte_java
;

parte_java:
    declaracion_global_java
    | metodo_java
    | constructorl
;
//------------------------------------------DECLARACION GLOBAL JAVA-----------------------------------------
//------------------------------------------DECLARACION GLOBAL JAVA-----------------------------------------
//------------------------------------------DECLARACION GLOBAL JAVA-----------------------------------------

declaracion_global_java:
    modificador_java tipo_java IDENTIFICADOR ';'
;
//-----------------------------------------------METODOS JAVA---------------------------------------------
//-----------------------------------------------METODOS JAVA---------------------------------------------
//-----------------------------------------------METODOS JAVA---------------------------------------------
metodo_java:
    modificador_java tipo_java IDENTIFICADOR '(' lista_parametros_java ')' '{' listado_java '}'
    | modificador_java 'void' IDENTIFICADOR '(' lista_parametros_java ')' '{' listado_java '}'
;

modificador_java:
    'public'
    | 'private'
;

sentencias_java:
    sentencias_java sentencia_java
    | sentencia_java
;

sentencia_java:
    if_java
    | declaracion_java
    | for_java
    | while_java
    | do_while_java
    | asignacion_java
    | switch_java
    | 'continue' ';'
    | 'break' ';'
    | 'return' expr ';'
        {console.log("Retorna "+$2);}
    | imprimir_java
        {console.log("Imprime");}
;
//-----------------------------------------------IMPRIMIR-----------------------------------------------
//-----------------------------------------------IMPRIMIR-----------------------------------------------
//-----------------------------------------------IMPRIMIR-----------------------------------------------
imprimir_java:
    'print' '(' cadena_imprimir ')' ';'
    | 'println' '(' cadena_imprimir ')' ';' 
;

cadena_imprimir:
    cadena_imprimir ',' expr
    | expr
;
//-----------------------------------------------SWITCH-----------------------------------------------
//-----------------------------------------------SWITCH-----------------------------------------------
//-----------------------------------------------SWITCH-----------------------------------------------
switch_java:
    'switch' '(' IDENTIFICADOR ')' '{' lista_casos_java default_java '}'
;

lista_casos_java:
    lista_casos_java caso_java
    | caso_java
;

caso_java:
    'case' valor ':' sentencias_java
;

default_java:
    | 'default' ':' sentencias_java
;
//---------------------------------------------DECLARACION JAVA--------------------------------------------
//---------------------------------------------DECLARACION JAVA--------------------------------------------
//---------------------------------------------DECLARACION JAVA--------------------------------------------
declaracion_java:
    tipo_java IDENTIFICADOR declaracion_simple ';'
    | tipo_java IDENTIFICADOR ASIGNAR tipo_input_java '(' ')' ';'
;

asignacion_java:
    IDENTIFICADOR ASIGNAR expr ';'
        {console.log("Asignacion normal");}
    | IDENTIFICADOR MAS_ASIGNAR expr ';'
        {console.log("Asignacion incremencial +=");}
    | IDENTIFICADOR MENOS_ASIGNAR expr ';'
    {console.log("Asignacion decremental -=");}
    | IDENTIFICADOR MAS ';'
        {console.log("Asignacion ++");}
    | IDENTIFICADOR MENOS ';'
        {console.log("Asignacion --");}
    | IDENTIFICADOR ASIGNAR tipo_input_java '(' ')' ';'
;
declaracion_simple:
    | ASIGNAR expr
;
//---------------------------------------------INPUT JAVA--------------------------------------------
tipo_input_java:
    'intinput'
    |   'floatinput'
    |   'charinput'
;

//------------------------------------------------IF-------------------------------------------------
//------------------------------------------------IF-------------------------------------------------
//------------------------------------------------IF-------------------------------------------------
if_java:
    IF '(' expr ')' '{' listado_java '}'
        {console.log("encuentra if");}
    | IF '(' expr ')' '{' listado_java '}' ELSE '{' listado_java '}'
        {console.log("encuentra if-else");}
    | IF '(' expr ')' '{' listado_java '}' ELSE if_java
        {console.log("encuentra if-elseif");}
;
//------------------------------------------------FOR-------------------------------------------------
//------------------------------------------------FOR-------------------------------------------------
//------------------------------------------------FOR-------------------------------------------------

for_java:
    'for' '(' declaracion_for ';' expr ';' incremental_for ')' '{' listado_java '}'
;

while_java:
    'while' '(' expr ')' '{' listado_java '}'
;

do_while_java:
    'do' '{' listado_java '}' 'while' '(' expr ')' ';'
;

declaracion_for:
    'int' IDENTIFICADOR ASIGNAR INT
    |   IDENTIFICADOR ASIGNAR INT
;

incremental_for:
    IDENTIFICADOR MAS
    | IDENTIFICADOR MENOS
;


listado_java:
    | sentencias_java
;

constructorl:
    'public' IDENTIFICADOR '(' lista_parametros_java ')' '{' listado_java '}'
;

lista_parametros_java:
    |   parametros_java
;

parametros_java:
    parametros_java ',' parametro_java
    | parametro_java
;

parametro_java:
    tipo_java IDENTIFICADOR
;

tipo_java:
    'int'
    | 'String'
    | 'float'
    | 'char'
    | 'boolean'
;

herencia:
    | 'extends' IDENTIFICADOR
;


expr:
    expr SUMA expr
    | expr POR expr
    | expr ENTRE expr
    | expr POT expr
    | expr RESTA expr
    | RESTA expr
    %prec UMINUS
    | expr AND expr
    | expr OR expr
    | NOT expr
    | expr IGUAL_IGUAL expr
    | expr DIFERENTE expr
    | expr MAYOR expr
    | expr MAYOR_IGUAL expr
    | expr MENOR expr
    | expr MENOR_IGUAL
    | '(' expr ')'
    | IDENTIFICADOR
    | INT
    | STRING
    | FLOAT
    | CHAR
    | IDENTIFICADOR '(' ')'
;

codigo_python:
    |   SALTO
    |   SALTO funciones_python
;

funciones_python:
        funciones_python funcion_python
        {console.log("otra funcion");}
    |   funcion_python
        {console.log("una funcion"); } 
    ;

funcion_python:
    'def' IDENTIFICADOR '(' lista_parametros_python ')' ':' SALTO INDENT sentencias_python DEDENT
    ;

lista_parametros_python:
    | parametros_python
;

parametros_python:
    IDENTIFICADOR parametros_pythonp
;

parametros_pythonp:
    | ',' IDENTIFICADOR
;

sentencias_python:
    sentencia_python sentencias_pythonp
;

sentencias_pythonp:
    | sentencias_python
;

sentencia_python:
    asignar
    |   if_python
    |   for_python
    |   print_python
    |   while_python
;

print_python:
    'print' '(' cadena_imprimir ')' SALTO
    |   'println' '(' cadena_imprimir ')' SALTO
;

asignar:
    IDENTIFICADOR ASIGNAR valor SALTO
		{console.log("una asignacion");}
    |   IDENTIFICADOR ASIGNAR 'input' '(' ')' SALTO
        {console.log("input");}
    ;

valor:
    STRING
    |   FLOAT
    |   INT
    |   CHAR
        {console.log("Encuentra char");}
    ;

for_python:
    'for' IDENTIFICADOR 'in' 'range' '(' ')' ':' SALTO INDENT sentencias_python DEDENT
        {console.log("Encontrado for");}
;

while_python:
    'while' expr ':' SALTO INDENT sentencias_python DEDENT
        {console.log("Encuentra while");}
;

if_python
    : IF expr ':' SALTO INDENT sentencias_python DEDENT               { console.log("if"); }
    | IF expr ':' SALTO INDENT sentencias_python DEDENT if_python_cola  { console.log("if-cola"); }
    ;
if_python_cola
    : ELSE ':' SALTO INDENT sentencias_python DEDENT                  { console.log("if-else"); }
    | elif_python ELSE ':' SALTO INDENT sentencias_python DEDENT     { console.log("if-elif-else"); }
    | elif_python                                           { console.log("if-elif"); }
    ;
elif_python
    : ELIF expr ':' SALTO INDENT sentencias_python DEDENT            { console.log("elif"); }
    | ELIF expr ':' SALTO INDENT sentencias_python DEDENT elif_python    { console.log("elif-elif"); }
    ;