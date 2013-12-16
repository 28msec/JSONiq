<?xml version="1.0" encoding="utf-8"?>

<!--
 * Copyright (c) 2002 World Wide Web Consortium,
 * (Massachusetts Institute of Technology, Institut National de
 * Recherche en Informatique et en Automatique, Keio University). All
 * Rights Reserved. This program is distributed under the W3C's Software
 * Intellectual Property License. This program is distributed in the
 * hope that it will be useful, but WITHOUT ANY WARRANTY; without even
 * the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
 * PURPOSE.
 * See W3C License http://www.w3.org/Consortium/Legal/ for more details.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0"
  xmlns:g="http://www.w3.org/2001/03/XPath/grammar" 
  exclude-result-prefixes="g xlink"
  xmlns:xlink="http://www.w3.org/1999/xlink">
  
  <xsl:param name="spec" select="'xpath'"/>
  <xsl:param name="not-spec" select="''"/>
  <xsl:param name="grammar-file" select="'xpath-grammar.xml'"/>
  <xsl:param name="grammar-map-file-name">grammar-map.xml</xsl:param>
  
  <!-- xsl:variable name="grammar" select="document($grammar-file)"/ -->
  <xsl:variable name="sourceTree" select="/"/>
  <xsl:variable name="prodrecaps" select="//prodrecap"/>
  
<!-- Generate a comment that identifies as much as we can about the XSLT processor being used -->
  <xsl:template match="/">
    <xsl:variable name="XSLTprocessor">
      <xsl:text>XSLT Processor: </xsl:text>
      <xsl:value-of select="system-property('xsl:vendor')"/>
      <xsl:if test="system-property('xsl:version') = '2.0'">
        <xsl:text> </xsl:text>
        <xsl:value-of select="system-property('xsl:product-name')"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="system-property('xsl:product-version')"/>
      </xsl:if>
    </xsl:variable>
    <xsl:message><xsl:value-of select="$XSLTprocessor"/></xsl:message>
    <xsl:comment><xsl:value-of select="$XSLTprocessor"/></xsl:comment>
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="@*|node()[not(self::g:*)]" priority="-10000">
    <xsl:if test="self::node()[not(normalize-space($not-spec)=@role)]">
      <xsl:copy>
        <xsl:apply-templates select="@*|node()"/>
      </xsl:copy>
    </xsl:if>
  </xsl:template>

  <xsl:include href="grammar2spec.xsl"/>

  <xsl:template name="get-gfn">
    <!-- Assumes predrecap context -->
    <xsl:variable name="k" select="@orig"/>
    <xsl:choose>
      <xsl:when test="$k">
        <xsl:variable name="gfn" select="document($grammar-map-file-name,.)//*[string(@name)=string($k)]"/>
        <xsl:value-of select="$gfn"/>
	<!--
        <xsl:message>
          <xsl:text>grammar file: </xsl:text><xsl:value-of select="$gfn"/>
          <xsl:text>, k: '</xsl:text><xsl:value-of select="$k"/><xsl:text>'</xsl:text>
	</xsl:message>
	-->
      </xsl:when>
      <xsl:when test="@at">
	<!--
        <xsl:message>
          <xsl:text>grammar file: </xsl:text><xsl:value-of select="@at"/>
          <xsl:text>, @at</xsl:text>
	</xsl:message>
	-->
	<xsl:value-of select="@at"/>
      </xsl:when>
      <xsl:otherwise>
	<!--
        <xsl:message>
          <xsl:text>grammar file: </xsl:text><xsl:value-of select="$grammar-file"/>
          <xsl:text>, global</xsl:text>
	</xsl:message>
	-->
        <xsl:value-of select="$grammar-file"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="get-gnotation">
    <!-- Assumes predrecap context -->
    <xsl:variable name="k" select="@orig"/>
    <xsl:choose>
      <xsl:when test="$k">
        <xsl:variable name="gfn" select="document($grammar-map-file-name,.)//*[string(@name)=string($k)]"/>
        <xsl:value-of select="$gfn/@notation"/>
        <!-- xsl:message>
          <xsl:text>grammar file: </xsl:text><xsl:value-of select="$gfn"/>
          <xsl:text>, k: '</xsl:text><xsl:value-of select="$k"/><xsl:text>'</xsl:text>
        </xsl:message -->
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template match="prodrecap[@id='DefinedLexemes' or @role='DefinedLexemes']">
    <xsl:variable name="fn"><xsl:call-template name="get-gfn"/></xsl:variable>
    <xsl:variable name="grammar" select="document($fn,.)"/>
    <xsl:variable name="orig">
      <xsl:call-template name="get-gnotation"/>
    </xsl:variable>
    <xsl:variable name="name-prefix">
      <xsl:text>prod-</xsl:text>
      <xsl:if test="$orig">
        <xsl:value-of select="$grammar/g:grammar/g:language/@id"/>
        <xsl:text>-</xsl:text>
      </xsl:if>
    </xsl:variable>
    <xsl:for-each select="$grammar/g:grammar">
      <xsl:call-template name="add-terminals">
        <xsl:with-param name="orig" select="$orig"/>
        <xsl:with-param name="name-prefix" select="$name-prefix"/>
      </xsl:call-template>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="prodrecap[@id='LocalTerminalSymbols' or @role='LocalTerminalSymbols']">
    <xsl:variable name="fn"><xsl:call-template name="get-gfn"/></xsl:variable>
    <xsl:variable name="grammar" select="document($fn,.)"/>
    <xsl:variable name="orig">
      <xsl:call-template name="get-gnotation"/>
    </xsl:variable>
    <xsl:variable name="name-prefix">
      <xsl:text>prod-</xsl:text>
      <xsl:if test="$orig">
        <xsl:value-of select="$grammar/g:grammar/g:language/@id"/>
        <xsl:text>-</xsl:text>
      </xsl:if>
    </xsl:variable>
    <xsl:for-each select="$grammar/g:grammar">
      <xsl:call-template name="add-local-terminals">
        <xsl:with-param name="orig" select="$orig"/>
        <xsl:with-param name="name-prefix" select="$name-prefix"/>
      </xsl:call-template>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="prodrecap[@id='BNF-Grammar-prods' or @role='BNF-Grammar-prods']">
    <xsl:variable name="fn"><xsl:call-template name="get-gfn"/></xsl:variable>
    <xsl:variable name="grammar" select="document($fn,.)"/>
    <xsl:variable name="orig">
      <xsl:call-template name="get-gnotation"/>
    </xsl:variable>

    <xsl:variable name="name-prefix">
      <xsl:text>prod-</xsl:text>
      <xsl:if test="$orig">
        <xsl:value-of select="$grammar/g:grammar/g:language/@id"/>
        <xsl:text>-</xsl:text>
      </xsl:if>
    </xsl:variable>
    
    <xsl:for-each select="$grammar/g:grammar">
      <xsl:call-template name="add-non-terminals">
        <xsl:with-param name="orig" select="$orig"/>
        <xsl:with-param name="name-prefix" select="$name-prefix"/>
      </xsl:call-template>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template match="prodrecap">
<!-- 20081231: Jim added "or contains($spec, @role)" to allow prodrecaps
                  with role="xpath" to be picked up when the spec = "xpath21"
                  (also role="xquery" with spec="xquery11" -->
<!--
<xsl:message>DEBUG: Starting template prodrecap. </xsl:message>
<xsl:message>DEBUG: template prodrecap ~~ $spec = <xsl:value-of select="$spec"/>. </xsl:message>
<xsl:message>DEBUG: template prodrecap ~~ @id = <xsl:value-of select="@id"/>. </xsl:message>
<xsl:message>DEBUG: template prodrecap ~~ @ref = <xsl:value-of select="@ref"/>. </xsl:message>
<xsl:message>DEBUG: template prodrecap ~~ @role = <xsl:value-of select="@role"/>. </xsl:message>
-->
    <xsl:if test="not(@role) or contains(@role, $spec) or contains($spec, @role) or contains($spec, 'shared')">
    <xsl:variable name="name">
      <xsl:choose>
        <xsl:when test="starts-with(@ref, 'xquery')">
          <xsl:value-of select="substring-after(@ref, 'xquery')"/>
         </xsl:when>
         <xsl:when test="starts-with(@ref, 'xpath')">
           <xsl:value-of select="substring-after(@ref, 'xpath')"/>
         </xsl:when>
         <xsl:otherwise>
           <xsl:value-of select="@ref"/>
         </xsl:otherwise>
       </xsl:choose>
     </xsl:variable>
<!--
<xsl:message>DEBUG: template prodrecap ~~ $name = <xsl:value-of select="$name"/>. </xsl:message>
-->

     <xsl:variable name="positionX">
       <!-- xsl:number level="any"/ -->
       <xsl:if test="not(@role='xno-number')">
         <xsl:variable name="fn"><xsl:call-template name="get-gfn"/></xsl:variable>
<!--
<xsl:message>LOAD: <xsl:value-of select="$fn"/></xsl:message>
-->
         <xsl:variable name="grammar" select="document($fn,.)"/>
         <xsl:for-each select="$grammar">
           <xsl:call-template name="make-absolute-nt-number">
             <xsl:with-param name="name" select="$name"/>
           </xsl:call-template>
         </xsl:for-each>
       </xsl:if>
     </xsl:variable>
     <xsl:variable name="position" select="number($positionX)"/>
<!--
<xsl:message>DEBUG: template prodrecap ~~ $positionX = <xsl:value-of select="$positionX"/>. </xsl:message>
<xsl:message>DEBUG: template prodrecap ~~ $position = <xsl:value-of select="$position"/>. </xsl:message>
-->

     <xsl:variable name="fn"><xsl:call-template name="get-gfn"/></xsl:variable>
     <xsl:variable name="grammar" select="document($fn,.)"/>
     <xsl:variable name="orig">
       <xsl:call-template name="get-gnotation"/>
     </xsl:variable>
<!--
<xsl:message>DEBUG: template prodrecap ~~ $fn = <xsl:value-of select="$fn"/>. </xsl:message>
<xsl:message>DEBUG: template prodrecap ~~ $orig = <xsl:value-of select="$orig"/>. </xsl:message>
-->

     <xsl:variable name="name-prefix">
       <xsl:choose>
         <xsl:when test="starts-with(@id, 'prod-')">
           <xsl:text>prod-</xsl:text>
         </xsl:when>
         <xsl:otherwise>
           <xsl:text>doc-</xsl:text>
         </xsl:otherwise>
       </xsl:choose>
       <xsl:if test="$orig">
         <xsl:value-of select="$grammar/g:grammar/g:language/@id"/>
         <xsl:text>-</xsl:text>
       </xsl:if>
     </xsl:variable>

     <xsl:variable name="ref-prefix">
       <xsl:choose>
         <xsl:when test="starts-with(@id, 'prod-')">
           <xsl:text>doc-</xsl:text>
         </xsl:when>
         <xsl:otherwise>
           <xsl:text>prod-</xsl:text>
         </xsl:otherwise>
       </xsl:choose>
       <xsl:if test="$orig">
         <xsl:value-of select="$grammar/g:grammar/g:language/@id"/>
         <xsl:text>-</xsl:text>
       </xsl:if>
     </xsl:variable>

     <!-- <xsl:variable name="real-id" select="@id"/> -->
     <xsl:variable name="real-id">
       <xsl:choose>
         <xsl:when test="@id and not(starts-with(@id, 'test-'))">
           <xsl:value-of select="@id"/>
         </xsl:when>
         <xsl:otherwise>
           <xsl:text>_no-id</xsl:text>
         </xsl:otherwise>
       </xsl:choose>
     </xsl:variable>

     <xsl:variable name="real-id-node" select="."/>
<!--
<xsl:message>DEBUG: template prodrecap ~~ $name-prefix = <xsl:value-of select="$name-prefix"/>. </xsl:message>
<xsl:message>DEBUG: template prodrecap ~~ $ref-prefix = <xsl:value-of select="$ref-prefix"/>. </xsl:message>
<xsl:message>DEBUG: template prodrecap ~~ $real-id = <xsl:value-of select="$real-id"/>. </xsl:message>
-->

<!--
<xsl:message>
 <xsl:text>In prodrecap for: </xsl:text><xsl:value-of select="$name"/>
 <xsl:text>, position=</xsl:text><xsl:value-of select="$position"/>
 <xsl:text>, positionx=</xsl:text><xsl:value-of select="$positionX"/>
</xsl:message>
-->

     <xsl:for-each select="$grammar">
       <xsl:variable name="production" select="key('ref', $name)
                              [not(@alias-for and not(@inline='false'))]"/>
<!--
<xsl:message>DEBUG: template prodrecap ~~ $production = <xsl:value-of select="$production"/>. </xsl:message>
-->
       <xsl:if test="not($production)">
         <xsl:message>
           <xsl:text>WARNING!! prodrecap not found for: </xsl:text>
           <xsl:value-of select="$name"/>
           <xsl:text> in </xsl:text>
           <xsl:value-of select="$fn"/>
         </xsl:message>
       </xsl:if>
<!--
<xsl:message>
 <xsl:text>Applying template </xsl:text><xsl:value-of select="$production"/>
 <xsl:text> with name = </xsl:text><xsl:value-of select="$name"/>
 <xsl:text>, position = </xsl:text><xsl:value-of select="$position"/>
 <xsl:text>, orig = </xsl:text><xsl:value-of select="$orig"/>
 <xsl:text>, name-prefix = </xsl:text><xsl:value-of select="$name-prefix"/>
 <xsl:text>, ref-prefix = </xsl:text><xsl:value-of select="$ref-prefix"/>
 <xsl:text>, real-id = </xsl:text><xsl:value-of select="$real-id"/>
 <xsl:text>, and real-id-node = </xsl:text><xsl:value-of select="$real-id-node"/>
</xsl:message>
-->

       <xsl:apply-templates select="$production" mode="g:tableCells">
         <xsl:with-param name="name" select="$name"/>
         <xsl:with-param name="position" select="$position"/>
         <xsl:with-param name="orig" select="$orig"/>
         <xsl:with-param name="name-prefix" select="$name-prefix"/>
         <xsl:with-param name="ref-prefix" select="$ref-prefix"/>
         <xsl:with-param name="real-id" select="$real-id"/>
         <xsl:with-param name="real-id-node" select="$real-id-node"/>
       </xsl:apply-templates>
    </xsl:for-each>
   </xsl:if>  
<!--
<xsl:message>DEBUG: Exiting template prodrecap. </xsl:message>
-->
  </xsl:template>

  <xsl:template match="p[@role='lexical-state-tables']">
    <xsl:variable name="fn"><xsl:call-template name="get-gfn"/></xsl:variable>
    <xsl:variable name="grammar" select="document($fn,.)"/>
    <xsl:for-each select="$grammar">
      <xsl:call-template name="show-tokens-transition-to-state"/>
    </xsl:for-each>
  </xsl:template>

<!-- This template "fills in" a paragraph in the EBNF section of document source files -->
  <xsl:template match="phrase[@role='defined-tokens-delimiting']">
<!--
<xsl:message>DEBUG: Starting template phrase[@role='defined-tokens-delimiting']. </xsl:message>
-->
    <xsl:variable name="fn"><xsl:call-template name="get-gfn"/></xsl:variable>
<!--
<xsl:message>DEBUG: template phrase[...delimiting] ~~ $fn = <xsl:value-of select="$fn"/>. </xsl:message>
-->
    <xsl:variable name="grammar" select="document($fn,.)"/>
    <xsl:for-each select="$grammar">
      <xsl:call-template name="show-defined-tokens">
        <xsl:with-param name="type" select="'delimiting'"/>
      </xsl:call-template>
    </xsl:for-each>
<!--
<xsl:message>DEBUG: Exiting template phrase[@role='defined-tokens-delimiting']. </xsl:message>
-->
  </xsl:template>

<!-- This template "fills in" a paragraph in the EBNF section of document source files -->
  <xsl:template match="phrase[@role='defined-tokens-nondelimiting']">
<!--
<xsl:message>DEBUG: Starting template phrase[@role='defined-tokens-nondelimiting']. </xsl:message>
-->
    <xsl:variable name="fn"><xsl:call-template name="get-gfn"/></xsl:variable>
<!--
<xsl:message>DEBUG: template phrase[...nondelimiting] ~~ $fn = <xsl:value-of select="$fn"/>. </xsl:message>
-->
    <xsl:variable name="grammar" select="document($fn,.)"/>
    <xsl:for-each select="$grammar">
      <xsl:call-template name="show-defined-tokens">
        <xsl:with-param name="type" select="'nondelimiting'"/>
      </xsl:call-template>
    </xsl:for-each>
<!--
<xsl:message>DEBUG: Exiting template phrase[@role='defined-tokens-nondelimiting']. </xsl:message>
-->
  </xsl:template>

 <!--========= Language phrase substitution ========== -->

  <xsl:template match="title[@role='spec-conditional']/text()">
    <xsl:choose>
      <xsl:when test="$spec='xpath'">
        <xsl:text>XML Path Language (XPath)</xsl:text>
      </xsl:when>
      <xsl:when test="$spec='xquery'">
        <xsl:text>XQuery 1.1: An XML Query Language</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="version[@role='spec-conditional']/text()">
    <xsl:choose>
      <xsl:when test="$spec='xpath'">
        <xsl:text>2.1</xsl:text>
      </xsl:when>
      <xsl:when test="$spec='xquery'">
        <!-- xsl:text>1.0</xsl:text -->
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--* MSM adds this to handle errataloc, 2007-01-16.  I hope it's 
      * correct... *-->
  <xsl:template match="errataloc[@role='spec-conditional']/@href">
    <xsl:attribute name="href">
      <xsl:choose>
	<xsl:when test="$spec='xpath'">
	  <xsl:text>http://www.w3.org/XML/2007/qt-errata/xpath20-errata.html</xsl:text>
	</xsl:when>
	<xsl:when test="$spec='xquery'">
	  <xsl:text>http://www.w3.org/XML/2007/qt-errata/xquery-errata.html</xsl:text>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:value-of select="."/>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:template>

  <!--* MSM adds this to handle translations, 2007-01-16.  I hope it's 
      * correct... *-->
  <xsl:template match="translationloc[@role='spec-conditional']/@href">
    <xsl:attribute name="href">
      <xsl:choose>
	<xsl:when test="$spec='xpath'">
	  <xsl:text>http://www.w3.org/2003/03/Translations/byTechnology?technology=xpath20</xsl:text>
	</xsl:when>
	<xsl:when test="$spec='xquery'">
	  <xsl:text>http://www.w3.org/2003/03/Translations/byTechnology?technology=xquery</xsl:text>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:value-of select="."/>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:template>

  <xsl:template match="phrase[@role='spec-language']">
    <xsl:choose>
      <xsl:when test="$spec='xpath'">
        <xsl:text>XPath</xsl:text>
      </xsl:when>
      <xsl:when test="$spec='xquery'">
        <xsl:text>XQuery</xsl:text>
      </xsl:when>
      <xsl:when test="$spec='xpath21'">
        <xsl:text>XPath</xsl:text>
      </xsl:when>
      <xsl:when test="$spec='xquery11'">
        <xsl:text>XQuery</xsl:text>
      </xsl:when>
      <xsl:when test="$spec='pathx1'">
        <xsl:text>XPath 1.0</xsl:text>
      </xsl:when>
      <xsl:when test="$spec='xquery-FT'">
        <xsl:text>XQuery 1.0 and XPath 2.0 Full-Text</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>[XPath/XQuery]</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="phrase[@role='spec-language-version']">
    <xsl:choose>
      <xsl:when test="$spec='xpath'">
        <xsl:text>XPath 2.0</xsl:text>
      </xsl:when>
      <xsl:when test="$spec='xquery'">
        <xsl:text>XQuery 1.0</xsl:text>
      </xsl:when>
      <xsl:when test="$spec='xpath21'">
        <xsl:text>XPath 2.1</xsl:text>
      </xsl:when>
      <xsl:when test="$spec='xquery11'">
        <xsl:text>XQuery 1.1</xsl:text>
      </xsl:when>
      <xsl:when test="$spec='joint11'">
        <xsl:text>[XPath 2.1/XQuery 1.1]</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>[XPath 2.0/XQuery 1.0]</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="phrase[@role='spec-version']">
    <xsl:choose>
      <xsl:when test="$spec='xpath'">
        <xsl:text>2.0</xsl:text>
      </xsl:when>
      <xsl:when test="$spec='xquery'">
        <xsl:text>1.0</xsl:text>
      </xsl:when>
      <xsl:when test="$spec='xpath21'">
        <xsl:text>2.1</xsl:text>
      </xsl:when>
      <xsl:when test="$spec='xquery11'">
        <xsl:text>1.1</xsl:text>
      </xsl:when>
      <xsl:when test="$spec='joint11'">
        <xsl:text>[2.1/1.1]</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>[2.0/1.0]</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="phrase[@role='spec-wg']">
    <xsl:choose>
      <xsl:when test="$spec='xpath' or $spec='xpath21'">
        <xsl:text>W3C XSL Working Group</xsl:text>
      </xsl:when>
      <xsl:when test="$spec='xquery' or $spec='xquery11'">
        <xsl:text>XML Query Working Group</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>W3C [XSL/XML Query] Working Groups</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="phrase[@role='spec-query']">
    <xsl:choose>
      <xsl:when test="$spec='xpath' or $spec='xpath21'">
        <xsl:text>expression</xsl:text>
      </xsl:when>
      <xsl:when test="$spec='xquery' or $spec='xquery11'">
        <xsl:text>query</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>[expression/query]</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="spec-for-name">
    <xsl:choose>
      <xsl:when test="$spec='xpath' or $spec='xpath21'">
        <xsl:text>For</xsl:text>
      </xsl:when>
      <xsl:when test="$spec='xquery' or $spec='xquery11'">
        <xsl:text>FLWOR</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>[For/FLWOR]</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="phrase[@role='spec-for-name']">
    <xsl:call-template name="spec-for-name"/>
  </xsl:template>

  <xsl:template match="phrase[@role='spec-for-name']" mode="text">
    <xsl:call-template name="spec-for-name"/>
  </xsl:template>

  <xsl:template match="termdef">
    <xsl:choose>
      <xsl:when test="starts-with(@id,'xpath-') or starts-with(@id,'xpath21-')">
	<xsl:message>Cleaning up termdef: <xsl:value-of select="@id"/></xsl:message>
	<termdef>
	  <xsl:copy-of select="@*"/>
	  <xsl:attribute name="id">
	    <xsl:value-of select="substring(@id,7)"/>
	  </xsl:attribute>
	  <xsl:apply-templates/>
	</termdef>
      </xsl:when>
      <xsl:otherwise>
	<termdef>
	  <xsl:copy-of select="@*"/>
	  <xsl:apply-templates/>
	</termdef>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

<!--
  <xsl:template match="nt[@def]">
    <nt def="doc-{@def}">
      <xsl:apply-templates/>
    </nt>
  </xsl:template>
-->

  <xsl:template match="nt[@def]">
    <xsl:variable name="fn"><xsl:call-template name="get-gfn"/></xsl:variable>
    <xsl:variable name="grammar" select="document($fn,.)"/>
    <xsl:variable name="orig">
      <xsl:call-template name="get-gnotation"/>
    </xsl:variable>
    
    <nt>
      <xsl:attribute name="def">
        <xsl:variable name="def" select="@def"/>
        <xsl:choose>
          <!-- Bit of a hack here.  The problem is no doc def exists for some productions.  -->
          <!-- In any case, perhaps -->
          <!--   there should other criteria to decide if we link to the exposition or not! -->
          <xsl:when test="$grammar/g:grammar//g:token[@name=$def and @is-xml='yes']">
            <xsl:text>prod-</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>doc-</xsl:text>
          </xsl:otherwise>
        </xsl:choose> 
        <xsl:if test="$orig">
          <xsl:value-of select="$grammar/g:grammar/g:language/@id"/>
          <xsl:text>-</xsl:text>
        </xsl:if>
        <xsl:value-of select="@def"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </nt>
  </xsl:template>

  <xsl:template match="g:description/code">
    <code>
      <xsl:for-each select="@*">
        <xsl:copy/>
      </xsl:for-each>
      <xsl:apply-templates/>
    </code>
  </xsl:template>

  <xsl:template match="g:description/nt">
    <nt>
      <xsl:for-each select="@*">
        <xsl:copy/>
      </xsl:for-each>
      <xsl:apply-templates/>
    </nt>
  </xsl:template>

</xsl:stylesheet>

<!-- Stylus Studio meta-information - (c) 2004-2006. Progress Software Corporation. All rights reserved.
<metaInformation>
<scenarios/><MapperMetaTag><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/><MapperBlockPosition></MapperBlockPosition><TemplateContext></TemplateContext><MapperFilter side="source"></MapperFilter></MapperMetaTag>
</metaInformation>
-->