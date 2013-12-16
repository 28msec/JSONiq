<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

<xsl:import href="xmlspec.xsl"/>

<xsl:output method="xml" indent="no" encoding="utf-8"/>

<xsl:key name="error" match="error" use="concat(@class,@code)"/>
<xsl:key name="bibrefs" match="bibref" use="@ref"/>


<xsl:param name="specdoc" select="'XX'"/>

<xsl:variable name="default.specdoc">
  <xsl:choose>
    <xsl:when test="$specdoc != 'XX'">
      <xsl:value-of select="$specdoc"/>
      <xsl:message>specdoc is <xsl:value-of select="$specdoc"/> (override)</xsl:message>
    </xsl:when>
    <xsl:when test="contains(/spec/header/title, 'Data Model') and
                    contains(/spec/header/title, '1.0')">
      <xsl:value-of select="'DM'"/>
      <xsl:message>specdoc is DM</xsl:message>
    </xsl:when>
    <xsl:when test="contains(/spec/header/title, 'Functions and Operators') and
                    contains(/spec/header/title, '1.0')">
      <xsl:value-of select="'FO'"/>
      <xsl:message>specdoc is FO</xsl:message>
    </xsl:when>
    <xsl:when test="contains(/spec/header/title, 'XPath') and
                    contains(/spec/header/title, '2.0')">
      <xsl:value-of select="'XP'"/>
      <xsl:message>specdoc is XP</xsl:message>
    </xsl:when>
    <xsl:when test="contains(/spec/header/title, 'XML Query Language') and
                    contains(/spec/header/title, '1.0')">
      <xsl:value-of select="'XQ'"/>
      <xsl:message>specdoc is XQ</xsl:message>
    </xsl:when>
    <xsl:when test="contains(/spec/header/title, 'Formal Semantics') and
                    contains(/spec/header/title, '1.0')">
      <xsl:value-of select="'FS'"/>
      <xsl:message>specdoc is FS</xsl:message>
    </xsl:when>
    <xsl:when test="contains(/spec/header/title, 'XQueryX') and
                    contains(/spec/header/title, '1.0')">
      <xsl:value-of select="'XQX'"/>
      <xsl:message>specdoc is XQX</xsl:message>
    </xsl:when>
    <xsl:when test="contains(/spec/header/title, 'Serialization') and
                    contains(/spec/header/title, '1.0')">
      <xsl:value-of select="'SER'"/>
      <xsl:message>specdoc is SER</xsl:message>
    </xsl:when>

    <xsl:when test="contains(/spec/header/title, 'XML Query') and
                    contains(/spec/header/title, 'Requirements')">
      <xsl:value-of select="'XQR'"/>
      <xsl:message>specdoc is XQR</xsl:message>
    </xsl:when>
    <xsl:when test="contains(/spec/header/title, 'XML Query') and
                    contains(/spec/header/title, 'Use Cases')">
      <xsl:value-of select="'XQUC'"/>
      <xsl:message>specdoc is XQUC</xsl:message>
    </xsl:when>

    <xsl:when test="contains(/spec/header/title, 'Data Model') and
                    contains(/spec/header/title, '1.1')">
      <xsl:value-of select="'DM11'"/>
      <xsl:message>specdoc is DM11</xsl:message>
    </xsl:when>
    <xsl:when test="contains(/spec/header/title, 'Functions and Operators') and
                    contains(/spec/header/title, '1.1')">
      <xsl:value-of select="'FO11'"/>
      <xsl:message>specdoc is FO11</xsl:message>
    </xsl:when>
    <xsl:when test="contains(/spec/header/title, 'XPath') and
                    contains(/spec/header/title, '2.1')">
      <xsl:value-of select="'XP21'"/>
      <xsl:message>specdoc is XP21</xsl:message>
    </xsl:when>
    <xsl:when test="contains(/spec/header/title, 'XQuery') and
                    contains(/spec/header/title, '1.1')">
      <xsl:value-of select="'XQ11'"/>
      <xsl:message>specdoc is XQ11</xsl:message>
    </xsl:when>
    <xsl:when test="contains(/spec/header/title, 'Formal Semantics') and
                    contains(/spec/header/title, '1.1')">
      <xsl:value-of select="'FS11'"/>
      <xsl:message>specdoc is FS11</xsl:message>
    </xsl:when>
    <xsl:when test="contains(/spec/header/title, 'XQueryX') and
                    contains(/spec/header/title, '1.1')">
      <xsl:value-of select="'XQX11'"/>
      <xsl:message>specdoc is XQX11</xsl:message>
    </xsl:when>
    <xsl:when test="contains(/spec/header/title, 'Serialization') and
                    contains(/spec/header/title, '1.1')">
      <xsl:value-of select="'SER11'"/>
      <xsl:message>specdoc is SER11</xsl:message>
    </xsl:when>

    <xsl:when test="contains(/spec/header/title, 'XML Query') and
                    contains(/spec/header/title, 'Requirements') and
                    contains(/spec/header/title, '1.1')">
      <xsl:value-of select="'XQR11'"/>
      <xsl:message>specdoc is XQR11</xsl:message>
    </xsl:when>
    <xsl:when test="contains(/spec/header/title, 'XQuery') and
                    contains(/spec/header/title, 'Use Cases') and
                    contains(/spec/header/title, '1.1')">
      <xsl:value-of select="'XQUC11'"/>
      <xsl:message>specdoc is XQUC11</xsl:message>
    </xsl:when>

    <xsl:when test="contains(/spec/header/title, 'Full Text') and
                    contains(/spec/header/title, '1.0') and
                    contains(/spec/header/title, 'Requirements')">
      <xsl:value-of select="'FTR'"/>
      <xsl:message>specdoc is FTR</xsl:message>
    </xsl:when>
    <xsl:when test="contains(/spec/header/title, 'Full Text') and
                    contains(/spec/header/title, '1.0') and
                    contains(/spec/header/title, 'Use Cases')">
      <xsl:value-of select="'FTUC'"/>
      <xsl:message>specdoc is FTUC</xsl:message>
    </xsl:when>
    <xsl:when test="contains(/spec/header/title, 'Full Text') and
                    contains(/spec/header/title, '1.0')">
      <xsl:value-of select="'FT'"/>
      <xsl:message>specdoc is FT</xsl:message>
    </xsl:when>

    <xsl:when test="contains(/spec/header/title, 'Update Facility') and
                    contains(/spec/header/title, '1.0') and
                    contains(/spec/header/title, 'Requirements')">
      <xsl:value-of select="'XQUR'"/>
      <xsl:message>specdoc is XQUR</xsl:message>
    </xsl:when>
    <xsl:when test="contains(/spec/header/title, 'Update Facility') and
                    contains(/spec/header/title, '1.0') and
                    contains(/spec/header/title, 'Use Cases')">
      <xsl:value-of select="'XQUU'"/>
      <xsl:message>specdoc is XQUU</xsl:message>
    </xsl:when>
    <xsl:when test="contains(/spec/header/title, 'Update Facility') and
                    contains(/spec/header/title, '1.0')">
      <xsl:value-of select="'XQU'"/>
      <xsl:message>specdoc is XQU</xsl:message>
    </xsl:when>

    <xsl:when test="contains(/spec/header/title, 'Scripting Extension') and
                    contains(/spec/header/title, '1.0') and
                    contains(/spec/header/title, 'Requirements')">
      <xsl:value-of select="'SXR'"/>
      <xsl:message>specdoc is SXR</xsl:message>
    </xsl:when>
    <xsl:when test="contains(/spec/header/title, 'Scripting Extension') and
                    contains(/spec/header/title, '1.0') and
                    contains(/spec/header/title, 'Use Cases')">
      <xsl:value-of select="'SXU'"/>
      <xsl:message>specdoc is SXU</xsl:message>
    </xsl:when>
    <xsl:when test="contains(/spec/header/title, 'Scripting Extension') and
                    contains(/spec/header/title, '1.0')">
      <xsl:value-of select="'SX'"/>
      <xsl:message>specdoc is SX</xsl:message>
    </xsl:when>
    <xsl:when test="contains(/spec/header/title, 'XSLT') and
                    contains(/spec/header/title, '2.0')">
      <xsl:value-of select="'XSLT'"/>
      <xsl:message>specdoc is XSLT</xsl:message>
    </xsl:when>
    <xsl:otherwise>
      <xsl:message>Title: <xsl:value-of select="/spec/header/title"/></xsl:message>
      <xsl:message terminate="yes">
        <xsl:text>xsl-query.xsl says: Failed to determine which specdoc this is: use specdoc parameter!</xsl:text>
      </xsl:message>
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<!-- ====================================================================== -->

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

<xsl:template name="css">
  <style type="text/css">
    <xsl:text>
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

div.issue { border-bottom-color: black;
            border-bottom-style: solid;
	    border-bottom-width: 1pt;
	    margin-bottom: 20pt;
}

th.issue-toc-head { border-bottom-color: black;
                    border-bottom-style: solid;
                    border-bottom-width: 1pt;
}

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
	    <xsl:when test="/spec/@w3c-doctype='cr'">W3C-CR</xsl:when>
	    <xsl:when test="/spec/@w3c-doctype='pr'">W3C-PR</xsl:when>
	    <xsl:when test="/spec/@w3c-doctype='per'">W3C-PER</xsl:when>
	    <xsl:when test="/spec/@w3c-doctype='rec'">W3C-REC</xsl:when>
	    <xsl:when test="/spec/@w3c-doctype='note'">W3C-NOTE</xsl:when>
	    <xsl:otherwise>base</xsl:otherwise>
	  </xsl:choose>
	</xsl:otherwise>
      </xsl:choose>
      <xsl:text>.css</xsl:text>
    </xsl:attribute>
  </link>
</xsl:template>

<xsl:template match="br">
	<br/>
</xsl:template>

<!-- ====================================================================== -->
<!-- Automatic glossaries -->

<xsl:template match="processing-instruction('glossary')">
  <dl>
    <xsl:apply-templates select="//termdef" mode="glossary-list">
      <xsl:sort select="@term" data-type="text" order="ascending"/>
    </xsl:apply-templates>
  </dl>
</xsl:template>

<xsl:template match="termdef" mode="glossary-list">
  <dt>
    <a name="GL{@id}"/>
    <xsl:value-of select="@term"/>
  </dt>
  <dd>
    <p>
      <xsl:apply-templates/>
    </p>
  </dd>
</xsl:template>

<!-- ====================================================================== -->
<!-- Automatic lists of impl def/dep features -->

<xsl:template match="processing-instruction('imp-def-feature')">
  <ol>
    <xsl:apply-templates select="//imp-def-feature" mode="imp-def"/>
  </ol>
</xsl:template>

<xsl:template match="processing-instruction('imp-dep-feature')">
  <ol>
    <xsl:apply-templates select="//imp-dep-feature" mode="imp-def"/>
  </ol>
</xsl:template>

<xsl:template match="imp-def-feature|imp-dep-feature" mode="imp-def">
  <xsl:variable name="div" select="(ancestor::div1|ancestor::div2|ancestor::div3|ancestor::div4|ancestor::div5)[last()]"/>
  <li>
    <xsl:apply-templates/>
    <xsl:text> (See </xsl:text>
    <xsl:apply-templates select="$div" mode="specref"/>
    <xsl:text>)</xsl:text>
  </li>
</xsl:template>

<!-- ====================================================================== -->
<!-- Error Markup -->

<xsl:template match="error" name="make-error-ref">
  <xsl:param name="uri" select="''"/>

  <xsl:variable name="spec">
    <xsl:choose>
      <xsl:when test="@spec"><xsl:value-of select="@spec"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="substring($default.specdoc,1,2)"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="class">
    <xsl:choose>
      <xsl:when test="@class"><xsl:value-of select="@class"/></xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="code">
    <xsl:choose>
      <xsl:when test="@code"><xsl:value-of select="@code"/></xsl:when>
      <xsl:otherwise>??</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="type">
    <xsl:choose>
      <xsl:when test="@type"><xsl:value-of select="@type"/></xsl:when>
      <xsl:otherwise>??</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="label"> <!-- CREATES LABEL IN XQUERY STYLE -->
    <xsl:text>err:</xsl:text>
    <xsl:value-of select="$spec"/>
    <xsl:value-of select="$class"/>
    <xsl:value-of select="$code"/>
  </xsl:variable>

  <xsl:text>[</xsl:text>

  <a href="{$uri}#ERR{$spec}{$class}{$code}" title="{$label}">
    <!-- ??? 
    <xsl:if test="@label and $spec != $default.specdoc">
      <xsl:text>Error: </xsl:text>
      <xsl:value-of select="$spec"/>
      <xsl:text>: </xsl:text>
    </xsl:if>
    -->
    <xsl:value-of select="$label"/>
  </a>

  <xsl:text>]</xsl:text>
</xsl:template>

<xsl:template match="errorref">
  <xsl:variable name="error" select="key('error', concat(@class,@code))"/>

  <xsl:choose>
    <xsl:when test="$error">
      <xsl:apply-templates select="$error[1]"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:message>Warning: Error <xsl:value-of select="@code"/> not found.</xsl:message>
      <xsl:text>[ERROR </xsl:text>
      <xsl:value-of select="@code"/>
      <xsl:text> NOT FOUND]</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="error-list">
  <dl>
    <xsl:apply-templates mode="error-list"/>
  </dl>
</xsl:template>

<xsl:template match="processing-instruction('error-list')">
  <dl>
    <xsl:apply-templates select="//error" mode="error-list"/>
  </dl>
</xsl:template>

<xsl:template match="error" mode="error-list">
  <xsl:variable name="spec">
    <xsl:choose>
      <xsl:when test="@spec"><xsl:value-of select="@spec"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="substring($default.specdoc,1,2)"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="class">
    <xsl:choose>
      <xsl:when test="@class"><xsl:value-of select="@class"/></xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="code">
    <xsl:choose>
      <xsl:when test="@code"><xsl:value-of select="@code"/></xsl:when>
      <xsl:otherwise>??</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="type">
    <xsl:choose>
      <xsl:when test="@type"><xsl:value-of select="@type"/></xsl:when>
      <xsl:otherwise>??</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="label">
    <xsl:choose>
      <xsl:when test="@label"><xsl:value-of select="@label"/></xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$spec"/>
        <xsl:value-of select="$class"/>
        <xsl:value-of select="$code"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <dt>
    <a name="ERR{$spec}{$class}{$code}"/>
    <xsl:text>err:</xsl:text>
    <xsl:value-of select="concat($spec, $class, $code)"/>
    <xsl:if test="@label">
      <xsl:text>, </xsl:text>
      <xsl:value-of select="@label"/>
    </xsl:if>
  </dt>
  <dd>
    <xsl:apply-templates/>
  </dd>
</xsl:template>

<!-- ====================================================================== -->
<!-- Imp def/dep markup -->

<xsl:template match="imp-def-feature"/>
<xsl:template match="imp-dep-feature"/>

<!-- ====================================================================== -->
<!-- Cross-spec references -->

<xsl:template match="xspecref">
  <xsl:variable name="ref" select="@ref"/>
  <xsl:variable name="doc" select="document(concat('../etc/', @spec, '.xml'))"/>
  <xsl:variable name="div" select="$doc//*[@id=$ref]"/>
  <xsl:variable name="nt" select="$doc//*[@def=$ref]"/>
  <xsl:variable name="uri" select="$doc/document-summary/@uri"/>

  <xsl:choose>
    <xsl:when test="$div">
      <xsl:choose>
	<xsl:when test="$uri">
	  <a href="{$uri}#{$ref}">
	    <xsl:text>Section </xsl:text>
	    <xsl:value-of select="$div/head"/>
	  </a>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:text>Section </xsl:text>
	  <xsl:value-of select="$div/head"/>
	</xsl:otherwise>
      </xsl:choose>
      <sup><small><xsl:value-of select="@spec"/></small></sup>
    </xsl:when>
    <xsl:when test="$nt">
      <xsl:choose>
	<xsl:when test="$uri">
	  <a href="{$uri}#{$ref}">
	    <xsl:value-of select="string($nt)"/>
	  </a>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:value-of select="string($nt)"/>
	</xsl:otherwise>
      </xsl:choose>
      <sup><small><xsl:value-of select="@spec"/></small></sup>
    </xsl:when>
    <xsl:when test="node()">
      <xsl:choose>
	<xsl:when test="$uri">
	  <a href="{$uri}#{$ref}">
	    <xsl:apply-templates/>
	  </a>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:apply-templates/>
	</xsl:otherwise>
      </xsl:choose>
      <sup><small><xsl:value-of select="@spec"/></small></sup>
    </xsl:when>
    <xsl:otherwise>
      <xsl:message>
        <xsl:text>Warning: Cannot find </xsl:text>
        <xsl:value-of select="@ref"/>
        <xsl:text> in </xsl:text>
        <xsl:value-of select="@spec"/>
        <xsl:text> for xspecref </xsl:text>
      </xsl:message>
      <xsl:text>[TITLE OF </xsl:text>
      <xsl:value-of select="@spec"/>
      <xsl:text> SPEC, TITLE OF </xsl:text>
      <xsl:value-of select="@ref"/>
      <xsl:text> SECTION]</xsl:text>
      <xsl:apply-templates/>
      <sup><small><xsl:value-of select="@spec"/></small></sup>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="xnt[not(@spec)]" priority="2">
  <!-- if there's no @spec, don't try to load a document ... -->
  <xsl:call-template name="process-xnt"/>
</xsl:template>

<xsl:template match="xnt">
  <xsl:variable name="ref" select="@ref"/>
  <xsl:variable name="doc" select="document(concat('../etc/', @spec, '.xml'))"/>
  <xsl:variable name="nt" select="$doc//nt[@def=$ref]"/>
  <xsl:variable name="uri" select="$doc/document-summary/@uri"/>

  <xsl:choose>
    <xsl:when test="@spec = 'XP' and not($nt)">
      <!-- XP and XQ are a special case -->
      <xsl:variable name="ref2" select="concat('doc-xpath-',@ref)"/>
      <xsl:variable name="nt2" select="$doc//nt[@def=$ref2]"/>
      <xsl:choose>
	<xsl:when test="$uri">
	  <a href="{$uri}#{$ref2}">
	    <xsl:call-template name="process-xnt">
	      <xsl:with-param name="doc" select="$doc"/>
	      <xsl:with-param name="nt" select="$nt2"/>
	    </xsl:call-template>
	  </a>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:call-template name="process-xnt">
	    <xsl:with-param name="doc" select="$doc"/>
	    <xsl:with-param name="nt" select="$nt2"/>
	  </xsl:call-template>
	</xsl:otherwise>
      </xsl:choose>
      <sup><small><xsl:value-of select="@spec"/></small></sup>
    </xsl:when>
    <xsl:when test="@spec = 'XQ' and not($nt)">
      <!-- XP and XQ are a special case -->
      <xsl:variable name="ref2" select="concat('doc-xquery-',@ref)"/>
      <xsl:variable name="nt2" select="$doc//nt[@def=$ref2]"/>

      <xsl:choose>
	<xsl:when test="$uri">
	  <a href="{$uri}#{$ref2}">
	    <xsl:call-template name="process-xnt">
	      <xsl:with-param name="doc" select="$doc"/>
	      <xsl:with-param name="nt" select="$nt2"/>
	    </xsl:call-template>
	  </a>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:call-template name="process-xnt">
	    <xsl:with-param name="doc" select="$doc"/>
	    <xsl:with-param name="nt" select="$nt2"/>
	  </xsl:call-template>
	</xsl:otherwise>
      </xsl:choose>
      <sup><small><xsl:value-of select="@spec"/></small></sup>
    </xsl:when>
    <xsl:otherwise>
      <xsl:choose>
	<xsl:when test="$uri">
	  <a href="{$uri}#{$ref}">
	    <xsl:call-template name="process-xnt">
	      <xsl:with-param name="doc" select="$doc"/>
	      <xsl:with-param name="nt" select="$nt"/>
	    </xsl:call-template>
	  </a>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:call-template name="process-xnt">
	    <xsl:with-param name="doc" select="$doc"/>
	    <xsl:with-param name="nt" select="$nt"/>
	  </xsl:call-template>
	</xsl:otherwise>
      </xsl:choose>
      <sup><small><xsl:value-of select="@spec"/></small></sup>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="process-xnt">
  <xsl:param name="doc"/>
  <xsl:param name="nt"/>

  <xsl:choose>
    <xsl:when test="@href">
      <a href="{@href}">
        <xsl:apply-templates/>
      </a>
    </xsl:when>
    <xsl:when test="not($nt)">
      <xsl:message>
        <xsl:text>Warning: Cannot find </xsl:text>
        <xsl:value-of select="@ref"/>
        <xsl:text> in </xsl:text>
        <xsl:value-of select="@spec"/>
        <xsl:text> for xnt (</xsl:text>
	<xsl:value-of select="$nt"/>
	<xsl:text>)</xsl:text>
      </xsl:message>
      <xsl:text>[NT </xsl:text>
      <xsl:value-of select="@ref"/>
      <xsl:text> IN </xsl:text>
      <xsl:value-of select="@spec"/>
      <xsl:text>]</xsl:text>
      <xsl:apply-templates/>
    </xsl:when>
    <xsl:when test="node()">
      <xsl:apply-templates/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$nt"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="xtermref">
  <xsl:variable name="href" select="@href"/>
  <xsl:choose>
    <xsl:when test="$href">
      <xsl:apply-imports/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="ref" select="@ref"/>
      <xsl:variable name="doc" select="document(concat('../etc/', @spec, '.xml'))"/>
      <xsl:variable name="termdef" select="$doc//termdef[@id=$ref]"/>
      <xsl:variable name="uri" select="$doc/document-summary/@uri"/>
      
      <xsl:choose>
        <xsl:when test="not($termdef)">
          <xsl:message>
            <xsl:text>Warning: Cannot find </xsl:text>
            <xsl:value-of select="@ref"/>
            <xsl:text> in </xsl:text>
            <xsl:value-of select="@spec"/>
            <xsl:text> for xtermref</xsl:text>
          </xsl:message>
          <xsl:text>[TERMDEF </xsl:text>
          <xsl:value-of select="@ref"/>
          <xsl:text> IN </xsl:text>
          <xsl:value-of select="@spec"/>
          <xsl:text>]</xsl:text>
          <xsl:apply-templates/>
        </xsl:when>
        <xsl:when test="node()">
	  <xsl:choose>
	    <xsl:when test="$uri">
	      <a href="{$uri}#{$ref}">
		<xsl:apply-templates/>
	      </a>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:apply-templates/>
	    </xsl:otherwise>
	  </xsl:choose>
	  <sup><small><xsl:value-of select="@spec"/></small></sup>
        </xsl:when>
        <xsl:otherwise>
	  <xsl:choose>
	    <xsl:when test="$uri">
	      <a href="{$uri}#{$ref}">
		<xsl:value-of select="$termdef/@term"/>
	      </a>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:value-of select="$termdef/@term"/>
	    </xsl:otherwise>
	  </xsl:choose>
	  <sup><small><xsl:value-of select="@spec"/></small></sup>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="xerrorref">
  <xsl:variable name="ref" select="@code"/>
  <xsl:variable name="class" select="@class"/>
  <xsl:variable name="doc" select="document(concat('../etc/', @spec, '.xml'))"/>
  <xsl:variable name="error" select="$doc//error[@code=$ref and @class=$class]"/>
  <xsl:variable name="uri" select="$doc/document-summary/@uri"/>

  <!--
  <xsl:message>
    <xsl:text>xerrorref: </xsl:text>
    <xsl:value-of select="$ref"/>
    <xsl:text>; </xsl:text>
    <xsl:value-of select="$class"/>
    <xsl:text>; </xsl:text>
    <xsl:value-of select="@spec"/>
    <xsl:text>; </xsl:text>
    <xsl:value-of select="$error"/>
  </xsl:message>
  -->

  <xsl:choose>
    <xsl:when test="not($error)">
      <xsl:message>
        <xsl:text>Warning: Cannot find </xsl:text>
        <xsl:value-of select="@class"/>
        <xsl:value-of select="@code"/>
        <xsl:text> in </xsl:text>
        <xsl:value-of select="@spec"/>
        <xsl:text> for xerrorref</xsl:text>
      </xsl:message>
      <xsl:text>[ERROR </xsl:text>
      <xsl:value-of select="@code"/>
      <xsl:text> IN </xsl:text>
      <xsl:value-of select="@spec"/>
      <xsl:text>]</xsl:text>
      <xsl:apply-templates/>
    </xsl:when>
    <xsl:when test="node()">
      <xsl:apply-templates/>
      <sup><small><xsl:value-of select="@spec"/></small></sup>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="$error">
	<xsl:with-param name="uri" select="$uri"/>
      </xsl:apply-templates>
      <sup><small><xsl:value-of select="@spec"/></small></sup>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="make-which-spec">
  <xsl:choose>
    <xsl:when test="starts-with(/spec/header/title, 'XQuery')">
      <xsl:text>xquery</xsl:text>
      <xsl:text>-</xsl:text>
    </xsl:when>
    <xsl:when test="starts-with(/spec/header/title, 'XML Path Language')">
      <xsl:text>xpath</xsl:text>
      <xsl:text>-</xsl:text>
    </xsl:when>
    <xsl:when test="starts-with(/spec/header/title, '[Shared')">
      <xsl:text>xpath</xsl:text>
      <xsl:text>-</xsl:text>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<!-- nt: production non-terminal -->
<!-- make a link to the non-terminal's definition -->
<xsl:template match="nt">
  <xsl:variable name="def">
    <xsl:choose>
      <xsl:when test="key('ids', @def)">
	<xsl:value-of select="@def"/>
      </xsl:when>
      <xsl:when test="starts-with(@def, 'prod-xpath-')
                      or starts-with(@def, 'doc-xpath-')
                      or starts-with(@def, 'prod-xquery-')
                      or starts-with(@def, 'doc-xquery-')">
        <xsl:value-of select="@def"/>
      </xsl:when>
      <xsl:when test="starts-with(@def, 'prod-')">
        <xsl:text>prod-</xsl:text>
        <xsl:call-template name="make-which-spec"/>
        <xsl:value-of select="substring-after(@def, 'prod-')"/>
      </xsl:when>
      <xsl:when test="starts-with(@def, 'doc-')">
        <xsl:text>doc-</xsl:text>
        <xsl:call-template name="make-which-spec"/>
        <xsl:value-of select="substring-after(@def, 'doc-')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>prod-</xsl:text>
        <xsl:call-template name="make-which-spec"/>
        <xsl:value-of select="@def"/>        
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:if test="not(key('ids', $def))">
    <xsl:message>
      <xsl:text>nt def not found: </xsl:text>
      <xsl:value-of select="$def"/>
    </xsl:message>
  </xsl:if>
  <a>
    <xsl:attribute name="href">
      <xsl:call-template name="href.target">
        <xsl:with-param name="target" select="key('ids', $def)"/>
      </xsl:call-template>
    </xsl:attribute>
    <xsl:apply-templates/>
  </a>
</xsl:template>


<!-- ====================================================================== -->

<xsl:template match="bibl" name="bibl">
  <xsl:variable name="xsl-query" select="document('../etc/xsl-query-bibl.xml')"/>
  <xsl:variable name="tr" select="document('../etc/tr.xml')"/>
  <xsl:variable name="rfc" select="document('../etc/rfc.xml')"/>
  <xsl:variable name="id" select="@id"/>

  <xsl:if test="count(key('bibrefs', @id)) = 0">
    <xsl:message>
      <xsl:text>Warning: no bibref to bibl "</xsl:text>
      <xsl:value-of select="@id"/>
      <xsl:text>"</xsl:text>
    </xsl:message>
  </xsl:if>

  <dt class="label">
    <span>
      <xsl:if test="@role">
        <xsl:attribute name="class">
          <xsl:value-of select="@role"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@id">
        <a name="{@id}" id="{@id}"/>
      </xsl:if>
      <xsl:choose>
        <xsl:when test="@key">
          <xsl:value-of select="@key"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@id"/>
        </xsl:otherwise>
      </xsl:choose>
    </span>
  </dt>
  <dd>
    <div>
      <xsl:if test="@role">
        <xsl:attribute name="class">
          <xsl:value-of select="@role"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:choose>
        <xsl:when test="not(node()) and $xsl-query//bibl[@id=$id]">
          <xsl:apply-templates select="$xsl-query//bibl[@id=$id]/node()"/>
        </xsl:when>
        <xsl:when test="not(node()) and $tr//bibl[@id=$id]">
          <xsl:apply-templates select="$tr//bibl[@id=$id]/node()"/>
        </xsl:when>
        <xsl:when test="not(node()) and $rfc//bibl[@id=$id]">
          <xsl:apply-templates select="$rfc//bibl[@id=$id]/node()"/>
        </xsl:when>
        <xsl:when test="not(node())">
          <xsl:message>Error: no <xsl:value-of select="$id"/> known!</xsl:message>
          <xsl:text>ERROR: NO </xsl:text>
          <xsl:value-of select="$id"/>
          <xsl:text> KNOWN!</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </dd>
</xsl:template>

<!-- ====================================================================== -->
<!-- Extracted out of xmlspec.xsl so that it can go back to being the base
     stylesheet! -->

  <xsl:template match="loc">
    <xsl:if test="starts-with(@href, '#')">
      <xsl:if test="@role and @role != 'force'">
        <xsl:if test="not(key('ids', substring-after(@href, '#')))">
          <xsl:message terminate="yes">
            <xsl:text>Internal loc href to </xsl:text>
            <xsl:value-of select="@href"/>
            <xsl:text>, but that ID does not exist in this document.</xsl:text>
          </xsl:message>
        </xsl:if>
      </xsl:if>
    </xsl:if>

    <a href="{@href}">
      <xsl:choose>
        <xsl:when test="count(child::node())=0">
          <xsl:value-of select="@href"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </a>
  </xsl:template>

<!-- ====================================================================== -->

  <xsl:template match="author/loc" priority="100">
    <xsl:text>, via </xsl:text>
    <a href="{@href}">
      <xsl:value-of select="@href"/>
    </a>
  </xsl:template>

  <!-- notes: a series of notes about the spec -->
  <!-- note is defined in xmlspec -->
  <xsl:template match="notes">
    <div class="note">
      <p class="prefix">
        <b>Notes:</b>
      </p>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

<!-- ====================================================================== -->

  <xsl:template match="issue/head">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="issue">
    <div class="issue">
      <p class="title">
        <xsl:if test="@id">
          <a name="{@id}" id="{@id}"/>
        </xsl:if>
        <b>
          <xsl:text>Issue: </xsl:text>
          <xsl:value-of select="@id"/>
        </b>
	<xsl:text>, priority: </xsl:text>
	<xsl:value-of select="@priority"/>
	<xsl:text>, status: </xsl:text>
	<xsl:value-of select="@status"/>
      </p>

      <xsl:apply-templates/>

      <xsl:if test="not(resolution)">
        <p class="prefix">
          <b>
            <xsl:text>Resolution:</xsl:text>
          </b>
        </p>
        <p>None recorded.</p>
      </xsl:if>
    </div>
  </xsl:template>

  <xsl:template match="processing-instruction('issues-toc')">
    <table summary="Issues TOC">
      <thead>
	<tr>
	  <th class="issue-toc-head" align="left">Issue</th>
	  <th class="issue-toc-head" align="left">Priority</th>
	  <th class="issue-toc-head" align="left">Status</th>
	  <th class="issue-toc-head" align="left">ID</th>
	</tr>
      </thead>
      <tbody>
	<xsl:for-each select="following::issue[@status != 'closed']">
	  <tr>
	    <td>
	      <xsl:value-of select="count(preceding::issue[@status != 'closed'])+1"/>
	      <xsl:text>: </xsl:text>
	      <xsl:value-of select="head"/>
	      <xsl:text> (</xsl:text>
	      <a href="#{@id}">
		<xsl:value-of select="@id"/>
	      </a>
	      <xsl:text>)</xsl:text>
	    </td>
	    <td>
	      <xsl:value-of select="@priority"/>
	    </td>
	    <td>
	      <xsl:value-of select="@status"/>
	    </td>
	    <td>
	      <xsl:value-of select="@id"/>
	    </td>
	  </tr>
	</xsl:for-each>
      </tbody>
    </table>
  </xsl:template>

<!-- ====================================================================== -->

<xsl:template match="div1|div2|div3|div4|div5|inform-div1">
  <xsl:if test="not(@id)">
    <xsl:message>
      <xsl:text>Warning: </xsl:text>
      <xsl:value-of select="name(.)"/>
      <xsl:text> has no id: </xsl:text>
      <xsl:value-of select="head"/>
    </xsl:message>
  </xsl:if>
  <xsl:apply-imports/>
</xsl:template>

</xsl:stylesheet>

