<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="../style/xsl-query.xsl"/>

  <xsl:param name="show.diff.markup" select="1"/>

  <xsl:param name="additional.css">
    <xsl:if test="$show.diff.markup != '0'">
      <xsl:text>
.diff-add  { background-color: #FFFF99; }
.diff-del  { background-color: #FFBBBB; text-decoration: line-through; }
.diff-chg  { background-color: #99FF99; }
.diff-off  {  }
</xsl:text>
    </xsl:if>table.small    { font-size: x-small; }

a.judgment:visited, a.judgment:link { font-family: sans-serif;
                              	      color: black; 
                              	      text-decoration: none }
a.processing:visited, a.processing:link { color: black; 
                              		  text-decoration: none }
a.env:visited, a.env:link { color: black; 
                            text-decoration: none }</xsl:param>

  <xsl:param name="additional.title">
    <xsl:if test="$show.diff.markup != '0'">
      <xsl:text>Review Version</xsl:text>
    </xsl:if>
  </xsl:param>

  <xsl:param name="called.by.diffspec" select="1"/>

  <!-- ==================================================================== -->

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

  <!-- ==================================================================== -->

  <!--
    The following template is a copy of the match="spec" template in
    xmlspec.xsl, with an extra chunk inserted.

    In a better design, xmlspec.xsl would have a "hook" in its template
    (at the point corresponding to where we insert the extra chunk).
    The hook would call a template (named, say, "top-of-body").
    In xmlspec.xsl, there would be a no-op template of that name,
    but this stylesheet would override that with a template
    consisting of just the inserted chunk.

    But we can't edit xmlspec.xsl.
  -->

  <!-- spec: the specification itself -->
  <xsl:template match="spec">
    <html>
      <xsl:if test="header/langusage/language">
        <xsl:attribute name="lang">
          <xsl:value-of select="header/langusage/language/@id"/>
        </xsl:attribute>
      </xsl:if>
      <head>
        <title>
          <xsl:apply-templates select="header/title"/>
          <xsl:if test="header/version">
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="header/version"/>
          </xsl:if>
          <xsl:if test="$additional.title != ''">
            <xsl:text> -- </xsl:text>
            <xsl:value-of select="$additional.title"/>
          </xsl:if>
        </title>
        <xsl:call-template name="css"/>
      </head>
      <body>
        <xsl:if test="$show.diff.markup != 0">
          <div>
            <p>The presentation of this document has been augmented to
            identify changes from a previous version. Three kinds of changes
            are highlighted: <span class="diff-add">new, added text</span>,
              <span class="diff-chg">changed text</span>, and
              <span class="diff-del">deleted text</span>.</p>
            <hr/>
          </div>
        </xsl:if>
        <xsl:apply-templates/>
        <xsl:if test="//footnote[not(ancestor::table)]">
          <hr/>
          <div class="endnotes">
            <xsl:text>&#xA;</xsl:text>
            <h3>
              <xsl:call-template name="anchor">
                <xsl:with-param name="conditional" select="0"/>
                <xsl:with-param name="default.id" select="'endnotes'"/>
              </xsl:call-template>
              <xsl:text>End Notes</xsl:text>
            </h3>
            <dl>
              <xsl:apply-templates select="//footnote[not(ancestor::table)]" mode="notes"/>
            </dl>
          </div>
        </xsl:if>
      </body>
    </html>
  </xsl:template>

  <!-- ==================================================================== -->

  <xsl:template name="diff-markup">
    <xsl:param name="diff">off</xsl:param>
    <xsl:choose>
      <xsl:when test="ancestor::scrap">
        <!-- forget it, we can't add stuff inside tables -->
        <!-- handled in base stylesheet -->
        <xsl:apply-imports/>
      </xsl:when>
      <xsl:when test="self::gitem or self::bibl">
        <!-- forget it, we can't add stuff inside dls; handled below -->
        <xsl:apply-imports/>
      </xsl:when>
      <xsl:when test="ancestor-or-self::phrase">
        <span class="diff-{$diff}">
          <xsl:apply-imports/>
        </span>
      </xsl:when>
      <xsl:when test="ancestor::p and not(self::p)">
        <span class="diff-{$diff}">
          <xsl:apply-imports/>
        </span>
      </xsl:when>
      <xsl:when test="ancestor-or-self::affiliation">
        <span class="diff-{$diff}">
          <xsl:apply-imports/>
        </span>
      </xsl:when>
      <xsl:when test="ancestor-or-self::name">
        <span class="diff-{$diff}">
          <xsl:apply-imports/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <div class="diff-{$diff}">
          <xsl:apply-imports/>
        </div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*[@diff='chg']">
    <xsl:choose>
      <xsl:when test="$show.diff.markup != 0">
        <xsl:call-template name="diff-markup">
          <xsl:with-param name="diff">chg</xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-imports/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*[@diff='add']">
    <xsl:choose>
      <xsl:when test="$show.diff.markup != 0">
        <xsl:call-template name="diff-markup">
          <xsl:with-param name="diff">add</xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-imports/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*[@diff='del']">
    <xsl:choose>
      <!--    <xsl:when test="true()"> -->
      <!-- suppress deleted markup -->
      <!--    </xsl:when> -->
      <xsl:when test="$show.diff.markup != 0">
        <xsl:call-template name="diff-markup">
          <xsl:with-param name="diff">del</xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <!-- suppress deleted markup -->
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*[@diff='off']">
    <xsl:choose>
      <xsl:when test="$show.diff.markup != 0">
        <xsl:call-template name="diff-markup">
          <xsl:with-param name="diff">off</xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-imports/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="td[@diff]|th[@diff]|tr[@diff]" priority="3">
    <xsl:choose>
      <xsl:when test="@diff = 'off'"/>
      <xsl:otherwise>
        <xsl:element name="{local-name(.)}">
          <xsl:attribute name="class">diff-<xsl:value-of select="@diff"/></xsl:attribute>
          <xsl:for-each select="@*">
            <xsl:choose>
              <xsl:when test="local-name(.) = 'role'">
                <xsl:attribute name="class">
                  <xsl:value-of select="."/>
                </xsl:attribute>
              </xsl:when>
              <xsl:when test="local-name(.) = 'diff'">
                <!-- nop -->
              </xsl:when>
              <xsl:otherwise>
                <xsl:copy-of select="."/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- ================================================================= -->

  <xsl:template match="bibl[@diff]" priority="1">

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

  <xsl:variable name="class">
    <xsl:choose>
      <xsl:when test="@diff and $show.diff.markup != 0">
        <xsl:text>diff-</xsl:text><xsl:value-of select="@diff"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>dummy-class</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="@diff='del' and $show.diff.markup = 0">
      <!-- all generation of output is suppressed in this case -->
    </xsl:when>
    <xsl:otherwise>
      <dt class="label">
        <span class="{$class}">
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
        <div class="{$class}">
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
    </xsl:otherwise>
  </xsl:choose>

  </xsl:template>

  <xsl:template match="gitem/label">
    <xsl:variable name="diffval" select="ancestor-or-self::*/@diff"/>
    <xsl:choose>
      <xsl:when test="$diffval='off'">
        <!-- suppress deleted markup -->
      </xsl:when>
      <xsl:when test="$diffval != '' and $show.diff.markup != 0">
        <dt class="label">
          <span class="diff-{ancestor-or-self::*/@diff}">
            <xsl:apply-templates/>
          </span>
        </dt>
      </xsl:when>
      <xsl:when test="$diffval='del' and $show.diff.markup = 0">
        <!-- suppressed -->
      </xsl:when>
      <xsl:otherwise>
        <dt class="label">
          <xsl:apply-templates/>
        </dt>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="gitem/def" priority="3">
    <xsl:variable name="diffval" select="ancestor-or-self::*/@diff"/>
    <xsl:choose>
      <xsl:when test="$diffval='off'">
        <!-- suppress deleted markup -->
      </xsl:when>
      <xsl:when test="$diffval != '' and $show.diff.markup != 0">
        <dd>
          <div class="diff-{ancestor-or-self::*/@diff}">
            <xsl:apply-templates/>
          </div>
        </dd>
      </xsl:when>
      <xsl:when test="$diffval='del' and $show.diff.markup = 0">
        <!-- suppressed -->
      </xsl:when>
      <xsl:otherwise>
        <dd>
          <xsl:apply-templates/>
        </dd>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- authlist: list of authors (editors, really) -->
  <!-- called in enforced order from header's template, in <dl>
       context -->
  <xsl:template match="authlist[@diff]">
    <xsl:choose>
      <xsl:when test="@diff='off'">
        <!-- suppress deleted markup -->
      </xsl:when>
      <xsl:when test="$show.diff.markup != 0">
        <dt>
          <span class="diff-{ancestor-or-self::*/@diff}">
            <xsl:text>Editor</xsl:text>
            <xsl:if test="count(author) &gt; 1">
              <xsl:text>s</xsl:text>
            </xsl:if>
            <xsl:text>:</xsl:text>
          </span>
        </dt>
      </xsl:when>
      <xsl:when test="@diff='del' and $show.diff.markup = 0">
        <!-- suppressed -->
      </xsl:when>
      <xsl:otherwise>
        <dt>
          <xsl:text>Editor</xsl:text>
          <xsl:if test="count(author) &gt; 1">
            <xsl:text>s</xsl:text>
          </xsl:if>
          <xsl:text>:</xsl:text>
        </dt>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:apply-templates/>
  </xsl:template>

  <!-- author: an editor of a spec -->
  <!-- only appears in authlist -->
  <!-- called in <dl> context -->
  <xsl:template match="author[@diff]" priority="1">
    <xsl:choose>
      <xsl:when test="@diff='off'">
        <!-- suppress deleted markup -->
      </xsl:when>
      <xsl:when test="@diff and $show.diff.markup != 0">
        <dd>
          <span class="diff-{ancestor-or-self::*/@diff}">
            <xsl:apply-templates/>
            <xsl:if test="@role = '2e'">
              <xsl:text> - Second Edition</xsl:text>
            </xsl:if>
          </span>
        </dd>
      </xsl:when>
      <xsl:when test="@diff='del' and $show.diff.markup = 0">
        <!-- suppressed -->
      </xsl:when>
      <xsl:otherwise>
        <dd>
          <xsl:apply-templates/>
          <xsl:if test="@role = '2e'">
            <xsl:text> - Second Edition</xsl:text>
          </xsl:if>
        </dd>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>