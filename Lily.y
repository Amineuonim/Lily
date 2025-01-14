%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    #include<ctype.h>
    
    void yyerror(const char *s);
    int yylex();
    int yywrap();

    void add(char);
    void insert_type();
    int search(char *);
    void insert_type();

    struct TableEntry {
        char * id_name;
        char * data_type;
        char * type;
        int line_no;
    } symbol_table[500];

    int count=0;
    int q;
    char type[10];
    extern int countn;
%}

%token OPEN_PARENTHESIS CLOSED_PARENTHESIS VIDE 
STRING_LITERAL THEN PROGRAM CONST VAR 
CHAR INT FLOAT STRING
RECORD END BEGIN_T IF ENDIF ELSE REPETER JUSQUA NUMBER FLOAT_NUM 
LETTRE IDENTIFIER EXPONENT COLUMN COMMA ASSIGN 
ADD_OP MULTIPLY_OP SUBTRACT_OP DIVIDE_OP
SEMI_COLUMN DOT UNDER_SCORE LOGICAL_OPERATOR
OPEN_CURLY CLOSED_CURLY

%%
  LiLy: PROGRAM IDENTIFIER SEMI_COLUMN Body DOT
  {printf("LiLy parsed!\n");}

  Body: Constants Variables Instructions_Body | Instructions_Body
        | Constants Instructions_Body| Variables Instructions_Body

  {printf("Body parsed.\n");}

  Constants: CONST OPEN_CURLY ConstDefinition CLOSED_CURLY
  {printf("Constants Definition parsed.\n");}

  id : IDENTIFIER ASSIGN
  ConstDefinition: id NUMBER SEMI_COLUMN| id NUMBER SEMI_COLUMN ConstDefinition
               | id LETTRE SEMI_COLUMN| id LETTRE SEMI_COLUMN ConstDefinition
  {printf("Sub Constant Declaration parsed .\n");}


  Variables: VAR OPEN_CURLY VarDefinition CLOSED_CURLY
  {printf("Variables Definition parsed.\n");}

  VarDefinition: GroupVariable COLUMN Datatype SEMI_COLUMN
  {printf("Sub Variables Declaration parsed .\n");}


  GroupVariable: IDENTIFIER | IDENTIFIER COMMA GroupVariable
  {printf("variables group parsed .\n");}

  Instructions_Body: BEGIN_T OPEN_CURLY Instructions CLOSED_CURLY
  {printf("Instructions Body parsed.\n");}

  Instructions: Instruction SEMI_COLUMN Instructions | Instruction SEMI_COLUMN
  {printf("Instructions parsed.\n");}

  Instruction: AssignIns | CondIns | LoopIns
  {printf("Instruction parsed.\n");}

  AssignIns: IDENTIFIER ASSIGN Expression
  {printf("Assign Instruction parsed.\n");}
  ArithmaticOperation: ADD_OP | SUBTRACT_OP | MULTIPLY_OP | DIVIDE_OP
  
  Value: FLOAT_NUM | NUMBER | IDENTIFIER | LETTRE

  Expression: Expression ArithmaticOperation Expression
              | OPEN_PARENTHESIS Expression CLOSED_PARENTHESIS 
              | Value
  {printf("Expression was parsed.\n");}

  CondIns: IF Condition THEN OPEN_CURLY Instructions  Condi
  {printf("Conditional instruction parsed.\n");}


  Condi: CLOSED_CURLY | CLOSED_CURLY ELSE OPEN_CURLY Instructions CLOSED_CURLY 
  {printf("SUB Instructions Body parsed.\n");}


  Condition: OPEN_PARENTHESIS Expression LOGICAL_OPERATOR Expression CLOSED_PARENTHESIS
  {printf("Condition parsed.\n");}


  LoopIns: REPETER OPEN_CURLY Instructions CLOSED_CURLY JUSQUA Condition
  {printf("LOOP Instruction Body parsed.\n");}


  Datatype : INT | FLOAT | STRING





%%

int main() {
  yyparse();
}

void yyerror(const char* msg) {
    fprintf(stderr, "%s\n", msg);
}
