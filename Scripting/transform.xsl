<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  exclude-result-prefixes="xd"
  version="1.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on:</xd:b> Feb 4, 2011</xd:p>
      <xd:p><xd:b>Author:</xd:b> systemsgroup</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template name="toc">
    <xsl:param name="what"/>
    <ol>
      <xsl:for-each select="$what/div1">
        <li><a href="#{@id}"><xsl:value-of select="head"/></a>
          <xsl:call-template name="toc"><xsl:with-param name="what" select="."/>
          </xsl:call-template>
        </li>
      </xsl:for-each>
    </ol>
    <ol>
      <xsl:for-each select="$what/div2">
        <li><a href="#{@id}"><xsl:value-of select="head"/></a>
        </li>
      </xsl:for-each>
    </ol>
  </xsl:template>
  <xsl:template name="rule">
    <xsl:param name="name"/>
    <xsl:if test="$name = 'MainModule'" xml:space="preserve">
0 - <a name="MainModule" class="ext">MainModule</a> ::= <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-Prolog" class="new">Prolog</a> <a href="Program" class="new">Program</a>
    </xsl:if>
    <xsl:if test="$name = 'Program'" xml:space="preserve">
1 - <a name="Program" class="ext">Program</a> ::= <a href="#StatementsAndOptionalExpr" class="new">StatementsAndOptionalExpr</a>
    </xsl:if>
    <xsl:if test="$name = 'Statements'" xml:space="preserve">
2 - <a name="Statements" class="new">Statements</a> ::= <a href="#Statement" class="new">Statement</a>*
    </xsl:if>
    <xsl:if test="$name = 'StatementsAndOptionalExpr'" xml:space="preserve">
3 - <a name="StatementsAndOptionalExpr" class="new">StatementsAndOptionalExpr</a> ::= <a href="#Statements" class="new">Statements</a> <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-Expr" class="un">Expr</a>?
    </xsl:if>
    <xsl:if test="$name = 'Statement'" xml:space="preserve">
4 - <a name="Statement" class="new">Statement</a> ::=
      <a href="#ApplyStatement" class="new">ApplyStatement</a>
    | <a href="#AssignStatement" class="new">AssignStatement</a>
    | <a href="#BlockStatement" class="new">BlockStatement</a>
    | <a href="#BreakStatement" class="new">BreakStatement</a>
    | <a href="#ContinueStatement" class="new">ContinueStatement</a>
    | <a href="#ExitStatement" class="new">ExitStatement</a>
    | <a href="#FLWORStatement" class="new">FLWORStatement</a>
    | <a href="#IfStatement" class="new">IfStatement</a>
    | <a href="#SwitchStatement" class="new">SwitchStatement</a>
    | <a href="#TryCatchStatement" class="new">TryCatchStatement</a>
    | <a href="#TypeswitchStatement" class="new">TypeswitchStatement</a>
    | <a href="#VarDeclStatement" class="new">VarDeclStatement</a>
    | <a href="#WhileStatement" class="new">WhileStatement</a>
    | <a href="#VoidStatement" class="new">VoidStatement</a>
    </xsl:if>
    <xsl:if test="$name = 'ApplyStatement'" xml:space="preserve">
5 - <a name="ApplyStatement" class="new">ApplyStatement</a> ::= <a href="#ExprSimple" class="new">ExprSimple</a> ";"
    </xsl:if>
    <xsl:if test="$name = 'AssignStatement'" xml:space="preserve">
6 - <a name="AssignStatement" class="new">AssignStatement</a> ::= "$" <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-VarName" class="un">VarName</a> ":=" <a href="#ExprSingle" class="ext">ExprSingle</a> ";"
    </xsl:if>
    <xsl:if test="$name = 'BlockStatement'" xml:space="preserve">
7 - <a name="BlockStatement" class="new">BlockStatement</a> ::= "{" <a href="#Statements" class="new">Statements</a> "}"
    </xsl:if>
    <xsl:if test="$name = 'BreakStatement'" xml:space="preserve">
8 - <a name="BreakStatement" class="new">BreakStatement</a> ::= "break" "loop" ";"
    </xsl:if>
    <xsl:if test="$name = 'ContinueStatement'" xml:space="preserve">
9 - <a name="ContinueStatement" class="new">ContinueStatement</a> ::= "continue" "loop" ";"
    </xsl:if>
    <xsl:if test="$name = 'ExitStatement'" xml:space="preserve">
10 - <a name="ExitStatement" class="new">ExitStatement</a> ::= "exit" "returning" <a href="#ExprSingle" class="ext">ExprSingle</a> ";"
    </xsl:if>
    <xsl:if test="$name = 'FLWORStatement'" xml:space="preserve">
11 - <a name="FLWORStatement" class="new">FLWORStatement</a> ::= <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-InitialClause" class="un">InitialClause</a> <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-IntermediateClause" class="un">IntermediateClause</a>* <a href="#DoStatement" class="new">ReturnStatement</a>
    </xsl:if>
    <xsl:if test="$name = 'ReturnStatement'" xml:space="preserve">
12 - <a name="ReturnStatement" class="new">ReturnStatement</a> ::= "return" <a href="#Statement" class="new">Statement</a>
    </xsl:if>
    <xsl:if test="$name = 'IfStatement'" xml:space="preserve">
13 - <a name="IfStatement" class="new">IfStatement</a> ::= "if" "(" <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-Expr" class="un">Expr</a> ")" "then" <a href="#Statement" class="new">Statement</a> ("else" <a href="#Statement" class="new">Statement</a>)?
    </xsl:if>
    <xsl:if test="$name = 'SwitchStatement'" xml:space="preserve">
14 - <a name="SwitchStatement" class="new">SwitchStatement</a> ::= "switch" "(" <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-Expr" class="un">Expr</a> ")" <a href="#SwitchCaseStatement" class="new">SwitchCaseStatement</a>+ "default" "return" <a href="#Statement" class="new">Statement</a>
    </xsl:if>
    <xsl:if test="$name = 'SwitchCaseStatement'" xml:space="preserve">
15 - <a name="SwitchCaseStatement" class="new">SwitchCaseStatement</a> ::= ("case" <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-SwitchCaseOperand" class="un">SwitchCaseOperand</a>)+ "return" <a href="#Statement" class="new">Statement</a>
    </xsl:if>
    <xsl:if test="$name = 'TryCatchStatement'" xml:space="preserve">
16 - <a name="TryCatchStatement" class="new">TryCatchStatement</a> ::= "try" <a href="#BlockStatement" class="new">BlockStatement</a> <a href="#CatchStatement" class="new">CatchStatement</a>+
    </xsl:if>
    <xsl:if test="$name = 'CatchStatement'" xml:space="preserve">
17 - <a name="CatchStatement" class="new">CatchStatement</a> ::= "catch" <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-CatchErrorList" class="un">CatchErrorList</a> <a href="#BlockStatement" class="new">BlockStatement</a>
    </xsl:if>
    <xsl:if test="$name = 'TypeswitchStatement'" xml:space="preserve">
18 - <a name="TypeswitchStatement" class="new">TypeswitchStatement</a> ::= "typeswitch" "(" <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-Expr" class="un">Expr</a> ")" <a href="#CaseStatement" class="new">CaseStatement</a>+ "default" ("$" <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-VarName" class="un">VarName</a>)? "return" <a href="#Statement" class="new">Statement</a>
    </xsl:if>
    <xsl:if test="$name = 'CaseStatement'" xml:space="preserve">
19 - <a name="CaseStatement" class="new">CaseStatement</a> ::= "case" ("$" <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-VarName" class="un">VarName</a> "as")? <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-SequenceType" class="un">SequenceType</a> "return" <a href="#Statement" class="new">Statement</a>
    </xsl:if>
    <xsl:if test="$name = 'VarDeclStatement'" xml:space="preserve">
20 - <a name="VarDeclStatement" class="new">VarDeclStatement</a> ::= <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-Annotation" class="un">Annotation</a>* "variable" "$" <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-VarName" class="un">VarName</a> <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-TypeDeclaration" class="un">TypeDeclaration</a>? (":=" <a href="#ExprSingle" class="ext">ExprSingle</a>)?
    ("," "$" <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-VarName" class="un">VarName</a> <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-TypeDeclaration" class="un">TypeDeclaration</a>? (":=" <a href="#ExprSingle" class="ext">ExprSingle</a>)?)* ";"
    </xsl:if>
    <xsl:if test="$name = 'WhileStatement'" xml:space="preserve">
21 - <a name="WhileStatement" class="new">WhileStatement</a> ::= "while" "(" <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-Expr" class="un">Expr</a> ")" <a href="#Statement" class="new">Statement</a>
    </xsl:if>
    <xsl:if test="$name = 'VoidStatement'" xml:space="preserve">
22 - <a name="VoidStatement" class="new">VoidStatement</a> ::= ";"
    </xsl:if>
    <xsl:if test="$name = 'ExprSingle'" xml:space="preserve">
23 - <a name="ExprSingle" class="ext">ExprSingle</a> ::=
      <a href="#ExprSimple" class="new">ExprSimple</a>
  |   <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-FLWORExpr" class="un">FLWORExpr</a>
  |   <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-IfExpr" class="un">IfExpr</a>
  |   <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-SwitchExpr" class="un">SwitchExpr</a>
  |   <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-TryCatchExpr" class="un">TryCatchExpr</a>
  |   <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-TypeswitchExpr" class="un">TypeswitchExpr</a>
    </xsl:if>
    <xsl:if test="$name = 'ExprSimple'" xml:space="preserve">
24 - <a name="ExprSimple" class="new">ExprSimple</a> ::=
      <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-QuantifiedExpr" class="un">QuantifiedExpr</a>
  |   <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-OrExpr" class="un">OrExpr</a>
  |   <a href="http://www.w3.org/TR/xquery-update-10/#prod-xquery-InsertExpr" class="up">InsertExpr</a>
  |   <a href="http://www.w3.org/TR/xquery-update-10/#prod-xquery-DeleteExpr" class="up">DeleteExpr</a>
  |   <a href="http://www.w3.org/TR/xquery-update-10/#prod-xquery-RenameExpr" class="up">RenameExpr</a>
  |   <a href="http://www.w3.org/TR/xquery-update-10/#prod-xquery-ReplaceExpr" class="up">ReplaceExpr</a>
  |   <a href="http://www.w3.org/TR/xquery-update-10/#prod-xquery-TransformExpr" class="up">TransformExpr</a>    </xsl:if>
    <xsl:if test="$name = 'CommonContent'" xml:space="preserve">
25 - <a name="CommonContent" class="ext">CommonContent</a> ::= <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-PredefinedEntityRef" class="un">PredefinedEntityRef</a> | <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-CharRef" class="un">CharRef</a> | "{{" | "}}" | <a href="#BlockExpr" class="new">BlockExpr</a>
    </xsl:if>
    <xsl:if test="$name = 'CompDocConstructor'" xml:space="preserve">
26 - <a name="CompDocConstructor" class="ext">CompDocConstructor</a> ::= "document" <a href="#BlockExpr" class="new">BlockExpr</a>
    </xsl:if>
    <xsl:if test="$name = 'CompElemConstructor'" xml:space="preserve">
27 - <a name="CompElemConstructor" class="ext">CompElemConstructor</a> ::= "element" (<a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-EQName" class="un">EQName</a> | <a href="#BlockExpr" class="new">BlockExpr</a>) <a href="#BlockExpr" class="new">BlockExpr</a>
    </xsl:if>
    <xsl:if test="$name = 'CompAttrConstructor'" xml:space="preserve">
28 - <a name="CompAttrConstructor" class="ext">CompAttrConstructor</a> ::= "attribute" (<a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-EQName" class="un">EQName</a> | <a href="#BlockExpr" class="new">BlockExpr</a>) <a href="#BlockExpr" class="new">BlockExpr</a>
    </xsl:if>
    <xsl:if test="$name = 'CompPIConstructor'" xml:space="preserve">
29 - <a name="CompPIConstructor" class="ext">CompPIConstructor</a> ::= "processing-instruction" (<a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-NCName" class="un">NCName</a> | <a href="#BlockExpr" class="new">BlockExpr</a>) <a href="#BlockExpr" class="new">BlockExpr</a>
    </xsl:if>
    <xsl:if test="$name = 'CompCommentConstructor'" xml:space="preserve">
30 - <a name="CompCommentConstructor" class="ext">CompCommentConstructor</a> ::= "comment" <a href="#BlockExpr" class="new">BlockExpr</a>
    </xsl:if>
    <xsl:if test="$name = 'CompTextConstructor'" xml:space="preserve">
31 - <a name="CompTextConstructor" class="ext">CompTextConstructor</a> ::= "text" <a href="#BlockExpr" class="new">BlockExpr</a>
    </xsl:if>
    <xsl:if test="$name = 'CompNamespaceConstructor'" xml:space="preserve">
32 - <a name="CompNamespaceConstructor" class="ext">CompNamespaceConstructor</a> ::= "namespace" (<a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-Prefix" class="un">Prefix</a> | <a href="#BlockExpr" class="new">BlockExpr</a>) <a href="#BlockExpr" class="new">BlockExpr</a>
    </xsl:if>
    <xsl:if test="$name = 'PrimaryExpr'" xml:space="preserve">
33 - <a name="PrimaryExpr" class="ext">PrimaryExpr</a> ::=
      <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-Literal" class="un">Literal</a>
  |   <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-VarRef" class="un">VarRef</a>
  |   <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-ParenthesizedExpr" class="un">ParenthesizedExpr</a>
  |   <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-ContextItemExpr" class="un">ContextItemExpr</a>
  |   <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-FunctionCall" class="un">FunctionCall</a>
  |   <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-OrderedExpr" class="un">OrderedExpr</a>
  |   <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-UnorderedExpr" class="un">UnorderedExpr</a>
  |   <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-Constructor" class="un">Constructor</a>
  |   <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-FunctionItemExpr" class="un">FunctionItemExpr</a>
  |   <a href="#BlockExpr" class="new">BlockExpr</a>
    </xsl:if>
    <xsl:if test="$name = 'BlockExpr'" xml:space="preserve">
34 - <a name="BlockExpr" class="new">BlockExpr</a> ::= "{" <a href="#StatementsAndExpr" class="new">StatementsAndOptionalExpr</a> "}
    </xsl:if>
    <xsl:if test="$name = 'FunctionDecl'" xml:space="preserve">
35 - <a name="FunctionDecl" class="ext">FunctionDecl</a> ::= "function" <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-EQName" class="un">EQName</a> "(" <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-ParamList" class="un">ParamList</a>? ")"
                      ("as" <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-SequenceType" class="un">SequenceType</a>)? (<a href="#BlockExpr" class="new">BlockExpr</a> | "external")
    </xsl:if>
    <xsl:if test="$name = 'TryCatchExpr'" xml:space="preserve">
36 - <a name="TryCatchExpr" class="ext">TryCatchExpr</a> ::= "try" <a href="#BlockExpr" class="new">BlockExpr</a> <a href="#CatchClause" class="new">CatchClause</a>+
    </xsl:if>
    <xsl:if test="$name = 'CatchClause'" xml:space="preserve">
37 - <a name="CatchClause" class="ext">CatchClause</a> ::= "catch" <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-CatchErrorList" class="un">CatchErrorList</a> <a href="#BlockExpr" class="new">BlockExpr</a>
    </xsl:if>
    <xsl:if test="$name = 'ValidateExpr'" xml:space="preserve">
38 - <a name="ValidationExpr" class="ext">ValidateExpr</a> ::= "validate" (<a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-ValidationMode" class="un">ValidationMode</a> | ("type" <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-TypeName" class="un">TypeName</a>))? <a href="#BlockExpr" class="new">BlockExpr</a>
    </xsl:if>
    <xsl:if test="$name = 'ExtensionExpr'" xml:space="preserve">
39 - <a name="ExtensionExpr" class="ext">ExtensionExpr</a> ::= <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-Pragma" class="un">Pragma</a>+ <a href="#BlockExpr" class="new">BlockExpr</a>
    </xsl:if>
    <xsl:if test="$name = 'OrderedExpr'" xml:space="preserve">
40 - <a name="OrderedExpr" class="ext">OrderedExpr</a> ::= "ordered" <a href="#BlockExpr" class="new">BlockExpr</a>
    </xsl:if>
    <xsl:if test="$name = 'OrderedExpr'" xml:space="preserve">
41 - <a name="UnorderedExpr" class="ext">UnorderedExpr</a> ::= "unordered" <a href="#BlockExpr" class="new">BlockExpr</a>
    </xsl:if>
    <xsl:if test="$name = 'IfExpr'" xml:space="preserve">
42 - <a name="IfExpr" class="new">IfExpr</a> ::=
    "if" "(" <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-Expr" class="un">Expr</a> ")" "then" (<a href="#ExprSingle" class="new">ExprSingle</a>|<a href="#Statement" class="new">Statement</a>) "else" (<a href="#ExprSingle" class="new">ExprSingle</a>|<a href="#Statement" class="new">Statement</a>)
    </xsl:if>
    <xsl:if test="$name = 'SwitchExpr'" xml:space="preserve">
43 - <a name="SwitchExpr" class="new">SwitchExpr</a> ::=
    "switch" "(" <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-Expr" class="un">Expr</a> ")" (<a href="#SwitchCaseStatement" class="new">SwitchCaseStatement</a>|<a href="#SwitchCaseClause" class="new">SwitchCaseClause</a>)+ "default" "return" (<a href="#ExprSingle" class="new">ExprSingle</a>|<a href="#Statement" class="new">Statement</a>)
    </xsl:if>
    <xsl:if test="$name = 'TypeswitchExpr'" xml:space="preserve">
44 - <a name="TypeswitchExpr" class="new">TypeswitchExpr</a> ::=
    "typeswitch" "(" <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-Expr" class="un">Expr</a> ")" (<a href="#CaseStatement" class="new">CaseStatement</a>|<a href="#CaseClause" class="new">CaseClause</a>)+ "default"("$" <a href="http://www.w3.org/TR/xquery-30/#doc-xquery30-VarName" class="un">VarName</a>)?  "return" (<a href="#ExprSingle" class="new">ExprSingle</a>|<a href="#Statement" class="new">Statement</a>)
    </xsl:if>
    <xsl:if test="$name = 'ForkExpr'" xml:space="preserve">
45 - <a name="ForkExpr" class="new">ForkExpr</a> ::= "fork" <a href="#BlockExpr" class="new">BlockExpr</a>
    </xsl:if>
    <xsl:if test="$name = 'Annotated'" xml:space="preserve">
    [unchanged] Annotation : =  "%" EQName ( "(" Literal ("," Literal)* ")" ) ?
    </xsl:if>
    <xsl:if test="$name = 'AnnotatedDecl'" xml:space="preserve">
[unchanged] AnnotatedDecl ::= "declare" Annotation* (VarDecl | FunctionDecl)
    </xsl:if>
    <xsl:if test="$name = 'VarDecl'" xml:space="preserve">
[unchanged] VarDecl	::= "variable" "$" VarName TypeDeclaration? ((":=" VarValue) | ("external" (":=" VarDefaultValue)?)))
    </xsl:if>
    <xsl:if test="$name = 'Alternative'" xml:space="preserve">
[unchanged] PrimaryExpr ::= /* as in XQuery 3.0, no standalone BlockExpr */
      Literal
  |   VarRef
  |   ParenthesizedExpr
  |   ContextItemExpr
  |   FunctionCall
  |   OrderedExpr
  |   UnorderedExpr
  |   Constructor
  |   FunctionItemExpr

Statement ::= Statement1 | Statement2

Statement1 :=
   AssignStatement
 | BlockStatement
 | BreakStatement
 | ContinueStatement
 | ExitStatement
 | VarDeclStatement
 | WhileStatement

Statement2 :=
   ApplyStatement
 | FLWORStatement
 | IfStatement
 | SwitchStatement
 | TryCatchStatement
 | TypeswitchStatement
 
StatementsAndOptionalExpr ::= Statements1 Expr?

Statements1 := Statement1*
 
    </xsl:if>
  </xsl:template>
  <xsl:template match="/">
    <html>
      <head>
        <title><xsl:value-of select="spec/header/title"/></title>
        <style type="text/css">
/*<![CDATA[*/
code           { font-family: monospace; }

div.constraint,
div.issue,
div.note,
div.notice     { margin-left: 2em; }

div.issue
p.title        { margin-left: -2em; }

ol.enumar      { list-style-type: decimal; }
ol.enumla      { list-style-type: lower-alpha; }
ol.enumlr      { list-style-type: lower-roman; }
ol.enumua      { list-style-type: upper-alpha; }
ol.enumur      { list-style-type: upper-roman; }

li p           { margin-top: 0.3em;
                 margin-bottom: 0.3em; }

sup small      { font-style: italic;
                 color: #8F8F8F;
               }
    
div.exampleInner pre { margin-left: 1em;
                       margin-top: 0em; margin-bottom: 0em}
div.exampleOuter {border: 4px double gray;
                  margin: 0em; padding: 0em}
div.exampleInner { background-color: #d5dee3;
                   border-top-width: 4px;
                   border-top-style: double;
                   border-top-color: #d3d3d3;
                   border-bottom-width: 4px;
                   border-bottom-style: double;
                   border-bottom-color: #d3d3d3;
                   padding: 4px; margin: 0em }
div.exampleWrapper { margin: 4px }
div.exampleHeader { font-weight: bold;
                    margin: 4px}

div.issue { border-bottom-color: black;
            border-bottom-style: solid;
            border-bottom-width: 1pt;
            margin-bottom: 20pt;
}

th.issue-toc-head { border-bottom-color: black;
                    border-bottom-style: solid;
                    border-bottom-width: 1pt;
}

      
table.small    { font-size: x-small; }

a.judgment:visited, a.judgment:link { font-family: sans-serif;
                                      color: black; 
                                      text-decoration: none }
a.processing:visited, a.processing:link { color: black; 
                                          text-decoration: none }
a.env:visited, a.env:link { color: black; 
                            text-decoration: none }
/*]]>*/
      </style>
        <link rel="stylesheet" type="text/css" href="http://www.w3.org/StyleSheets/TR/W3C-WD.css" />
      </head>
      <body>
        <h1><xsl:value-of select="spec/header/title"/></h1>
        <xsl:apply-templates select="spec/header/authlist"/>
        <h1>Abstract</h1>
        <xsl:apply-templates select="spec/header/abstract"/>
        <hr/>
        <h1>Table of Contents</h1>
        <xsl:call-template name="toc"><xsl:with-param name="what" select="spec/body"/></xsl:call-template>
        <hr/>
        <xsl:apply-templates select="spec/body"/>
        <hr/>
        <h1>Complete Grammar</h1>
        <h2>Grammar Proposal</h2>
        (Non-terminals without a rule correspond to those, unchanged, in XQuery 3.0/XQuery Update 1.0)
        <h3>New query body for main modules</h3>
        <pre>
          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'MainModule'"/>
          </xsl:call-template>
          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'Program'"/>
          </xsl:call-template>
      </pre>
        <h3>Mixing Expressions and Statements</h3>
        <pre xml:space="preserve">
          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'Statements'"/>
          </xsl:call-template>
          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'StatementsAndExpr'"/>
          </xsl:call-template>
          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'StatementsAndOptionalExpr'"/>
          </xsl:call-template>
      </pre>
        <h3>Statements</h3>
        <pre xml:space="preserve">
          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'Statement'"/>
          </xsl:call-template>

          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'ApplyStatement'"/>
          </xsl:call-template>

          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'AssignStatement'"/>
          </xsl:call-template>

          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'BlockStatement'"/>
          </xsl:call-template>

          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'BreakStatement'"/>
          </xsl:call-template>

          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'ContinueStatement'"/>
          </xsl:call-template>

          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'ExitStatement'"/>
          </xsl:call-template>

          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'FLWORStatement'"/>
          </xsl:call-template>
          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'ReturnStatement'"/>
          </xsl:call-template>

          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'IfStatement'"/>
          </xsl:call-template>

          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'SwitchStatement'"/>
          </xsl:call-template>
          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'SwitchCaseStatement'"/>
          </xsl:call-template>

          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'TryCatchStatement'"/>
          </xsl:call-template>
          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'CatchStatement'"/>
          </xsl:call-template>

          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'TypeswitchStatement'"/>
          </xsl:call-template>
          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'CaseStatement'"/>
          </xsl:call-template>

          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'VarDeclStatement'"/>
          </xsl:call-template>

          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'WhileStatement'"/>
          </xsl:call-template>

          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'VoidStatement'"/>
          </xsl:call-template>
      </pre>
        <h3>Expressions</h3>
        (Separating control-flow expressions)
        <pre>
          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'ExprSingle'"/>
          </xsl:call-template>

          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'ExprSimple'"/>
          </xsl:call-template>
      </pre>
        (Direct element constructors)
        <pre>
          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'CommonContent'"/>
          </xsl:call-template>
      </pre>
        (Computed element constructors)
        <pre>
          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'CompDocConstructor'"/>
          </xsl:call-template>
          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'CompElemConstructor'"/>
          </xsl:call-template>
          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'CompAttrConstructor'"/>
          </xsl:call-template>
          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'CompPIConstructor'"/>
          </xsl:call-template>
          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'CompCommentConstructor'"/>
          </xsl:call-template>
          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'CompTextConstructor'"/>
          </xsl:call-template>
          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'CompNamespaceConstructor'"/>
          </xsl:call-template>
      </pre>
        (Expressions now allowing block expressions)
        <pre>
          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'TryCatch'"/>
          </xsl:call-template>

          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'CatchClause'"/>
          </xsl:call-template>

          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'ValidateExpr'"/>
          </xsl:call-template>

          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'ExtensionExpr'"/>
          </xsl:call-template>

          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'OrderedExpr'"/>
          </xsl:call-template>

          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'UnorderedExpr'"/>
          </xsl:call-template>
      </pre>
        (Block expression)
        <pre>
          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'PrimaryExpr'"/>
          </xsl:call-template>

          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'BlockExpr'"/>
          </xsl:call-template>
      </pre>
        (Fork expression)
        <pre>
          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'ForkExpr'"/>
          </xsl:call-template>
      </pre>
        (Control flow expressions)
        <pre>
          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'IfExpr'"/>
          </xsl:call-template>
          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'SwitchExpr'"/>
          </xsl:call-template>
          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'TypeswitchExpr'"/>
          </xsl:call-template>
      </pre>
        <h3>Function body</h3>
        <pre>
          <xsl:call-template name="rule">
            <xsl:with-param name="name" select="'FunctionDecl'"/>
          </xsl:call-template>
        </pre>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="authlist">
    <h2>Authors</h2>
    <ul>
    <xsl:for-each select="author">
      <li><xsl:value-of select="name"/>, <xsl:value-of select="affiliation"/>, <xsl:value-of select="email"/></li>
    </xsl:for-each>
    </ul>
  </xsl:template>
  <xsl:template match="abstract">
    <xsl:apply-templates select="p"/>
  </xsl:template>
  <xsl:template match="p">
    <p><xsl:apply-templates select="node()"/></p>
  </xsl:template>
  <xsl:template match="bibref">
    <xsl:variable name="ref" select="@ref"/>
    <xsl:value-of select="//bibl[@id=$ref]/@key"/>
  </xsl:template>
  <xsl:template match="body">
    <xsl:apply-templates select="div1"/>
  </xsl:template>
  <xsl:template match="div1">
    <h1><a name="{@id}"/><xsl:number/>. <xsl:value-of select="head"/></h1>
    <xsl:apply-templates select="node()"/>
  </xsl:template>
  <xsl:template match="div2">
    <h2><a name="{@id}"/><xsl:number level="multiple" count="div1|div2|div3"/>. <xsl:value-of select="head"/></h2>
    <xsl:apply-templates select="node()"/>
  </xsl:template>
  <xsl:template match="div3">
    <h3><a name="{@id}"/><xsl:number level="multiple" count="div1|div2|div3"/>. <xsl:value-of select="head"/></h3>
    <xsl:apply-templates select="node()"/>
  </xsl:template>
  <xsl:template match="label">
    <h3><xsl:value-of select="head"/></h3>
    <xsl:apply-templates select="node()"/>
  </xsl:template>
  <xsl:template match="head"></xsl:template>
  <xsl:template match="termdef">
    [<xsl:apply-templates select="node()"/>]
  </xsl:template>
  <xsl:template match="term">
    <b><xsl:value-of select="."/></b>
  </xsl:template>
  <xsl:template match="ulist">
    <ul>
      <xsl:apply-templates select="item"/>
    </ul>
  </xsl:template>
  <xsl:template match="olist">
    <ol>
      <xsl:apply-templates select="item"/>
    </ol>
  </xsl:template>
  <xsl:template match="item">
    <li>
      <xsl:apply-templates select="node()"/>
    </li>
  </xsl:template>
  <xsl:template match="eg">
    <pre>
      <xsl:apply-templates select="node()"/>
    </pre>
  </xsl:template>
  <xsl:template match="glist">
    <xsl:apply-templates select="node()"/>
  </xsl:template>
  <xsl:template match="gitem">
    <b><xsl:value-of select="label"/></b>
    <xsl:apply-templates select="def"/>
  </xsl:template>
  <xsl:template match="def">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="scrap">
    <xsl:for-each select="prodrecap">
      <pre><xsl:call-template name="rule"><xsl:with-param name="name" select="@ref"/></xsl:call-template></pre>
    </xsl:for-each>
  </xsl:template>
  <xsl:template match="note">
    <hr/>
    <p><b>Note:</b></p>
    <xsl:apply-templates/>
    <hr/>
  </xsl:template>
</xsl:stylesheet>