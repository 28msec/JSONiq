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
  version="1.0">
  
  <xsl:import href="xmlspec-override.xsl"/> 

  <xsl:param name="spec" select="'xpath'"/>

  <xsl:output method="xml" encoding="utf-8"/>

  <!-- xsl:param name="spec" select="shared"/ -->

  
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

  <!--========= Overridden Templates of XPath2.xsl ========== -->

  <xsl:template mode="toc" match="*">
    <xsl:choose>
      <xsl:when test="not($spec='shared') and @role and not(@role=$spec)">
        <!-- suppress -->
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-imports/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

<!--
  <xsl:template mode="toc" match="*[not($spec='shared') and @role and not(@role=$spec)]">
  </xsl:template>
-->

  <xsl:template match="title[@role='spec-conditional']/text()">
    <xsl:choose>
      <xsl:when test="$spec='xpath'">
        <xsl:text>XML Path Language (XPath)</xsl:text>
      </xsl:when>
      <xsl:when test="$spec='xquery'">
        <xsl:text>XQuery 1.0: An XML Query Language</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="version[@role='spec-conditional']/text()">
    <xsl:choose>
      <xsl:when test="$spec='xpath'">
        <xsl:text>2.0</xsl:text>
      </xsl:when>
      <xsl:when test="$spec='xquery'">
        <!-- xsl:text>1.0</xsl:text -->
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="phrase[@role='spec-language']">
    <xsl:choose>
      <xsl:when test="$spec='xpath'">
        <xsl:text>XPath</xsl:text>
      </xsl:when>
      <xsl:when test="$spec='xquery'">
        <xsl:text>XQuery</xsl:text>
      </xsl:when>
      <xsl:when test="$spec='pathx1'">
        <xsl:text>XPath 1.0</xsl:text>
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
      <xsl:otherwise>
        <xsl:text>[2.0/1.0]</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="phrase[@role='spec-wg']">
    <xsl:choose>
      <xsl:when test="$spec='xpath'">
        <xsl:text>W3C XSL Working Group</xsl:text>
      </xsl:when>
      <xsl:when test="$spec='xquery'">
        <xsl:text>XML Query Working Group</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>W3C [XSL/XML Query] Working Group</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="phrase[@role='spec-query']">
    <xsl:choose>
      <xsl:when test="$spec='xpath'">
        <xsl:text>expression</xsl:text>
      </xsl:when>
      <xsl:when test="$spec='xquery'">
        <xsl:text>query</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>[expression/query]</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="spec-for-name">
    <xsl:choose>
      <xsl:when test="$spec='xpath'">
        <xsl:text>For</xsl:text>
      </xsl:when>
      <xsl:when test="$spec='xquery'">
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


  <!--========= End Overridden Templates of XPath2.xsl ========== --> 

  <xsl:template name="role-template">
    <xsl:param name="ename" select="name()"/>
    <xsl:param name="role-post-string" select="''"/>
    <xsl:choose>
      <xsl:when test="@role='xquery' or @role='xpath'">
        <xsl:choose>
          <xsl:when test="normalize-space($spec)=normalize-space(@role)">
            <!-- xsl:apply-imports/ -->
            <xsl:element name="{$ename}">
              <xsl:attribute name="class">
                <xsl:value-of select="@role"/>
                <xsl:value-of select="$role-post-string"/>
              </xsl:attribute>
              <xsl:apply-templates/>
            </xsl:element>   
          </xsl:when>
          <xsl:when test="$spec='shared'">
            <xsl:element name="{$ename}">
              <xsl:attribute name="class">
                <xsl:value-of select="@role"/>
                <xsl:value-of select="$role-post-string"/>
              </xsl:attribute>
              <xsl:apply-templates/>
            </xsl:element>            
          </xsl:when>
        </xsl:choose>

      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-imports/>
      </xsl:otherwise>
    </xsl:choose>    
  </xsl:template>

  <!-- blist: list of bibliographic entries -->
  <!-- set up the list and process children -->
  <xsl:template match="blist">
    <dl>
      <xsl:apply-templates select="*">
        <xsl:sort select="@key"/>
      </xsl:apply-templates>
    </dl>
  </xsl:template>

  <xsl:template match="rhs-group">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- Added hack to avoid processing of specref by this template. -sb -->
  <xsl:template match="*[(@role='xpath' or @role='xquery') 
                       and not(local-name(.)='specref')]" priority="20">
    <xsl:param name="role-post-string" select="''"/>
    <xsl:choose>
      <xsl:when test="@role='xquery' or @role='xpath'">
        <xsl:choose>
          <xsl:when test="$spec='shared'">
            <span>
              <xsl:attribute name="class">
                <xsl:value-of select="@role"/>
                <xsl:value-of select="$role-post-string"/>
              </xsl:attribute>
              <xsl:choose>
                <xsl:when test="self::rhs-group">
                  <xsl:apply-templates/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:apply-imports/>
                </xsl:otherwise>
              </xsl:choose>
            </span>            
          </xsl:when>
          <xsl:when test="self::rhs-group">
            <xsl:apply-templates/>
          </xsl:when>
          <xsl:when test="normalize-space($spec)=normalize-space(@role)">
            <xsl:apply-imports/>
            <!-- span>
              <xsl:attribute name="class">
                <xsl:value-of select="@role"/>
                <xsl:value-of select="$role-post-string"/>
              </xsl:attribute>
              <xsl:apply-imports/>
            </span -->
          </xsl:when>
        </xsl:choose>

      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="self::rhs-group">
            <xsl:apply-templates/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-imports/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>    
  </xsl:template>

  <!-- xnt: external non-terminal -->
  <!-- xspecref: external specification reference -->
  <!-- xtermref: external term reference -->
  <!-- just link to URI provided -->
  <!-- xsl:template match="xspecref">
    <a href="{@href}">
      <xsl:if test="@id">
        <xsl:attribute name="name">
          <xsl:value-of select="@id"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </a>
  </xsl:template -->

  <!-- nt: production non-terminal -->
  <!-- make a link to the non-terminal's definition -->
  <xsl:template match="prod//nt" priority="40000">
    <a>
      <xsl:attribute name="href">
        <xsl:call-template name="href.target">
          <xsl:with-param name="target" select="key('ids', @def)"/>
        </xsl:call-template>
      </xsl:attribute> 
      <xsl:variable name="role" select="ancestor-or-self::*[@role='xpath' 
                                        or @role='xquery'][1]/@role"/>
      <xsl:if test="$role">
        <xsl:attribute name="class">
          <xsl:value-of select="$role"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:apply-templates/>
    </a>
  </xsl:template>


  <xsl:template match="olist[@role='xpath' or @role='xquery']">
    <xsl:call-template name="role-template">
      <xsl:with-param name="ename" select="'ol'"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ulist[@role='xpath' or @role='xquery']">
    <xsl:call-template name="role-template">
      <xsl:with-param name="ename" select="'ul'"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="item[@role='xpath' or @role='xquery']">
    <xsl:call-template name="role-template">
      <xsl:with-param name="ename" select="'li'"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="p[@role='xpath' or @role='xquery']">
    <xsl:call-template name="role-template">
      <xsl:with-param name="ename" select="'p'"/>
    </xsl:call-template>
  </xsl:template>
 
 <!-- xsl:template match="div1[@role='xpath' or @role='xquery']">
   <xsl:call-template name="role-template">
     <xsl:with-param name="ename" select="'div'"/>
     <xsl:with-param name="role-post-string" select="'_div1'"/>
   </xsl:call-template>
 </xsl:template>

 <xsl:template match="div2[@role='xpath' or @role='xquery']">
   <xsl:call-template name="role-template">
     <xsl:with-param name="ename" select="'div'"/>
     <xsl:with-param name="role-post-string" select="'_div2'"/>
   </xsl:call-template>
 </xsl:template>

  <xsl:template match="div3[@role='xpath' or @role='xquery']">
   <xsl:call-template name="role-template">
     <xsl:with-param name="ename" select="'div'"/>
     <xsl:with-param name="role-post-string" select="'_div3'"/>
   </xsl:call-template>
  </xsl:template -->

  <xsl:template name="css">
    <style type="text/css">
.wsspec      { font-family: monospace; font-size: small; font-style: italic }      
<xsl:if test="$spec='shared'">
<xsl:text>.xpath         { color: red; background-color: white }
.xquery      { color: green; background-color: white }

.xpath:link { color: red; background-color: white }
.xpath:visited { color: red; background-color: white }

.shared:link { color: black; background-color: white }
.shared:visited { color: black; background-color: white }

.xquery:link { color: green; background-color: white }
.xquery:visited { color: green; background-color: white }

</xsl:text>
</xsl:if>

<xsl:text>
code           { font-family: monospace; }

div.constraint,
div.issue,
div.note,
div.notice     { margin-left: 2em; }

ol.enumar      { list-style-type: decimal; }
ol.enumla      { list-style-type: lower-alpha; }
ol.enumlr      { list-style-type: lower-roman; }
ol.enumua      { list-style-type: upper-alpha; }
ol.enumur      { list-style-type: upper-roman; }

li p           { margin-top: 0.3em;
                 margin-bottom: 0.3em; }

</xsl:text>
      <xsl:if test="$tabular.examples = 0">
        <xsl:text>
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
</xsl:text>
      </xsl:if>

      <xsl:value-of select="$additional.css"/>

    </style>

    <link rel="stylesheet" type="text/css">
      <xsl:attribute name="href">
        <xsl:text>http://www.w3.org/StyleSheets/TR/</xsl:text>
        <xsl:choose>
          <xsl:when test="/spec/@role='editors-copy'">base</xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="/spec/@w3c-doctype='wd'">W3C-WD</xsl:when>
              <xsl:when test="/spec/@w3c-doctype='rec'">W3C-REC</xsl:when>
              <xsl:when test="/spec/@w3c-doctype='pr'">W3C-PR</xsl:when>
              <xsl:when test="/spec/@w3c-doctype='per'">W3C-PER</xsl:when>
              <xsl:when test="/spec/@w3c-doctype='cr'">W3C-CR</xsl:when>
              <xsl:when test="/spec/@w3c-doctype='note'">W3C-NOTE</xsl:when>
              <xsl:when test="/spec/@w3c-doctype='wgnote'">W3C-WG-NOTE</xsl:when>
              <xsl:when test="/spec/@w3c-doctype='memsub'">W3C-Member-SUBM</xsl:when>
              <xsl:when test="/spec/@w3c-doctype='teamsub'">W3C-Team-SUBM</xsl:when>
              <xsl:otherwise>base</xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>.css</xsl:text>
      </xsl:attribute>
    </link>
    
  </xsl:template>

<xsl:template match="errorref">
  <xsl:variable name="error" select="key('error', concat(@class,@code))"/>

  <xsl:choose>
    <xsl:when test="$error">
      <!-- hack fix for apply-imports param problem -->
      <xsl:for-each select="$error[1]">
        <xsl:call-template name="make-error-ref"/>
      </xsl:for-each>
     </xsl:when>
    <xsl:otherwise>
      <xsl:message>Warning: Error <xsl:value-of select="@code"/> not found.</xsl:message>
      <xsl:text>[ERROR </xsl:text>
      <xsl:value-of select="@code"/>
      <xsl:text> NOT FOUND]</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2006. Progress Software Corporation. All rights reserved.
<metaInformation>
<scenarios/><MapperMetaTag><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/><MapperBlockPosition></MapperBlockPosition><TemplateContext></TemplateContext><MapperFilter side="source"></MapperFilter></MapperMetaTag>
</metaInformation>
-->