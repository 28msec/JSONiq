<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0"
  xmlns:g="http://www.w3.org/2001/03/XPath/grammar" 
  exclude-result-prefixes="g xlink"
  xmlns:xlink="http://www.w3.org/1999/xlink">
  <!-- For the moment, only use this with the lexical tables note build! -->

  <xsl:import href="assemble-spec.xsl"/>

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

  <xsl:template match="p[@role='lexical-state-tables']">
    <xsl:variable name="fn"><xsl:call-template name="get-gfn"/></xsl:variable>
    <xsl:variable name="grammar" select="document(@at,.)"/>
    <xsl:for-each select="$grammar">
      <xsl:call-template name="show-tokens-transition-to-state"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="prodrecap[@role='BNF-Grammar-prods']">
    <xsl:variable name="fn"><xsl:call-template name="get-gfn"/></xsl:variable>
    <xsl:variable name="grammar" select="document(@at,.)"/>
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

  <xsl:template match="prodrecap[@role='DefinedLexemes']">
    <xsl:variable name="fn"><xsl:call-template name="get-gfn"/></xsl:variable>
    <xsl:variable name="grammar" select="document(@at,.)"/>
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


  
</xsl:stylesheet>

<!-- Stylus Studio meta-information - (c) 2004-2006. Progress Software Corporation. All rights reserved.
<metaInformation>
<scenarios/><MapperMetaTag><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/><MapperBlockPosition></MapperBlockPosition><TemplateContext></TemplateContext><MapperFilter side="source"></MapperFilter></MapperMetaTag>
</metaInformation>
-->