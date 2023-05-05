# Compiler Design for B-- 

## About

B-- is a toy programming language based on BASIC programming language. It is made using **lex** and **bison**.

## Variables

1. Variable Names: Single Upper-Case Letter (A – Z) followed by an optional single digit (0 – 9). Example: A, F, H, A0, Z9
2. Data Types: Numeric – Integer (%), Single Precision (!), Double Precision (#) & Strings ($).
3. Type declaration uses special characters along with variable names as given above. Example: P1# (double precision), N$ (string), A9 (integer), M! (single precision)

## Precedence of Operators
### Arithematic Operators:
| Operator | Operation | Example |
| --- | --- | --- |
| () | Parenthesis | (X + Y) |
| ^ | Exponentiation | X ^ Y |
| - | Negation | -X |
| *, / | Multiplication / Division | X * Y, X / Y |
| +, - | Addition / Subtraction | X + Y, X - Y |
### Realtional Operators:
| Operator | Operation | Example |
| --- | --- | --- |
| = | Equality | X = Y |
| <> | Inequality | X <> Y |
| < | Less Than | X < Y |
| > | Greater Than | X > Y |
| <= | Less than or equal to | X <= Y |
| >= | Greater than or equal to | X >= Y |
### Logical Operators: 
NOT, AND, OR, XOR
<b>NOTE:</b>In case of equal precedence evaluation for operators is done from left-to-right.
## Statements
1. The **DATA** statement is used to contain values that will be later used by the <b>READ</b> statement. Example:

      `DATA 3.14159, “PI”`
      
2. The <b>DEF</b> statement is used to define a user-defined function of one numeric variable or a pseudo-constant. Example:

      `DEF FNF(X) = X^4 – 1`
      `DEF FNP = 3.14159`
      
3. The <b>DIM</b> statement is used to specify non-default sizes of numeric arrays. Example:

      `DIM A(6), B(10,20)`
      
4. The <b>END</b> statement is used to specify the end of the source program.

      `END`
      
5. The <b>FOR</b> statement is used for coding pre-test loops that use an index numeric variable. Example:

       10 FOR X=1 TO 9 STEP 4
      
       20 PRINT X
       
       30 NEXT X
       
       40 PRINT "AFTER LOOP X IS"; X
       
       50 END
       
6. The <b>GOSUB</b> statement is used to call a subroutine.

7. The <b>IF</b> statement is used to branch conditionally to a new statement. Example:

      `IF F<>1 THEN 260`
      
      `IF A$="Y" THEN 170`
      
8. The <b>LET</b> statement is used to assign a value to a variable. Examples:

      `LET A(X,3) = X*Y – 1`
      
      `LET A$ = “ABC”`
      
9. The <b>INPUT</b> statement is used to read data into one or more variables from the keyboard. Example:

      `INPUT X`
      
10. The <b>PRINT</b> statement is used to send output to the terminal. Example:

      `PRINT “X = ”, 10`
      
11. The <b>REM</b> statement is used to add a comment to the source code of the program.

12. The <b>RETURN</b> statement is used to exit a subroutine that was entered with <b>GOSUB</b> and continue execution on the
line immediately following the <b>GOSUB</b> that invoked the subroutine.

13. The <b>STOP</b> statement will halt execution of the program immediately.

## How to Compile and Run the Program


## Authors
  Ajaybeer Singh (2021CSB1063)
  
  Akanksh Caimi (2021CSB1064)
  
