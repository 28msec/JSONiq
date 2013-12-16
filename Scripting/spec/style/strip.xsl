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

<!-- NOTE: This stylesheet is NOT the same as the stylesheet of the same
     filename located in the grammarXX/parser/ directories -->
<!-- This stylesheet is used by various ant scripts (build.xml)
     to transform the "complete" xpath/xquery grammar file into
     a "temporary" XPath or XQuery grammar file, possibly with
     specialized extensions (e.g., Full Text, Update Facility) -->
<!-- The parameters (spec1, spec2, spec3) are used to cause this
     stylesheet to incorporate only those productions that are
     associated with one or more of those specialized extensions -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0" xmlns:g="http://www.w3.org/2001/03/XPath/grammar">
<!-- xpath is the default grammar to build -->
  <xsl:param name="spec1" select="'xpath'"/>
  <xsl:param name="spec2" select="'dummy'"/>
  <xsl:param name="spec3" select="'dummy'"/>

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


<!-- This is a "near-identity" transformation template -->  
  <xsl:template match="@*|node()">

<!-- If a node doesn't have an "if" attribute, or if it has one
     and the value of the attribute contains a string equal to the
     value of any of the three parameters passed to the template,
     then... -->
    <xsl:if test="self::node()[not(@if) or
                               contains(@if, $spec1) or
                               contains(@if, $spec2) or
                               contains(@if, $spec3)]">
<!-- ...if the node doesn't have a "not-if" attribute whose value
     contains a string equal to the value of any of the
     three parameters, then ... -->
 		  <xsl:if test="self::node()[not(contains(@not-if, $spec1) or
			                   	           contains(@not-if, $spec2) or
						                         contains(@not-if, $spec3))]">
<!-- ...produce a copy of the node by applying this template
     to all of the contained nodes and attributes -->
			  <xsl:copy>
				  <xsl:apply-templates select="@*|node()"/>
			  </xsl:copy>        
	    </xsl:if>
		</xsl:if>
    
  </xsl:template>

</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2006. Progress Software Corporation. All rights reserved.
<metaInformation>
<scenarios/><MapperMetaTag><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/><MapperBlockPosition></MapperBlockPosition><TemplateContext></TemplateContext><MapperFilter side="source"></MapperFilter></MapperMetaTag>
</metaInformation>
-->