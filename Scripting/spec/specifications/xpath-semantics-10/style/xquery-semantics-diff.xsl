<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0">

<!-- <xsl:import href="../../../style/qtspecs-diff.xsl"/> -->
<xsl:import href="xquery-semantics.xsl"/>

<xsl:param name="show.diff.markup" select="1"/>

<xsl:param name="additional.css">
<xsl:if test="$show.diff.markup != '0'">
<xsl:text>
.diff-add  { background-color: #FFFF99; }
.diff-del  { background-color: #FFBBBB; text-decoration: line-through; }
.diff-chg  { background-color: #99FF99; }
.diff-off  {  }
</xsl:text>
</xsl:if>
</xsl:param>

<xsl:param name="additional.title">
  <xsl:if test="$show.diff.markup != '0'">
    <xsl:text>Review Version</xsl:text>
  </xsl:if>
</xsl:param>

<xsl:param name="called.by.diffspec" select="1"/>

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
        <!-- This xsl:if element is the "extra chunk". -->
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
            <xsl:text>&#10;</xsl:text>
            <h3>
              <xsl:call-template name="anchor">
                <xsl:with-param name="conditional" select="0"/>
                <xsl:with-param name="default.id" select="'endnotes'"/>
              </xsl:call-template>
              <xsl:text>End Notes</xsl:text>
            </h3>
            <dl>
              <xsl:apply-templates select="//footnote[not(ancestor::table)]"
                                   mode="notes"/>
            </dl>
          </div>
        </xsl:if>
      </body>
    </html>
  </xsl:template>

<!-- ==================================================================== -->

<xsl:template match="*[@diff]">
    <xsl:choose>
        <xsl:when test="$show.diff.markup = 0">
            <xsl:message terminate="yes">
                Input document contains diff-markup!

                (When $show.diff.markup = 0, diff-markup should have been executed
                and removed at the 'assemble' stage by assemble-semantics.xsl.)
            </xsl:message>
        </xsl:when>

        <xsl:otherwise>
            <!--
                $show.diff.markup != 0:
                Put markup in the result document
                so that the nature of the diffs is made visible.
                (I.e., highlight the edits via styling).
            -->
            <xsl:variable name='diffclass' select="concat('diff-',@diff)"/>
            <xsl:variable name='diffat'    select="@at"/>
            <!-- Transform the source node, and then tweak the results. -->
            <xsl:variable name='x' as='node()*'>
                <xsl:apply-imports/>
            </xsl:variable>

            <xsl:choose>
                <xsl:when test="$x/self::text()[matches(., '\S')]">
                    <!--
                        There are some top-level non-whitespace text nodes in $x.
                        We could either <span> each individually,
                        or <span> the whole result-sequence.
                        I think the latter is more often the better choice.
                    -->
                    <span>
                        <xsl:attribute name="class" select="$diffclass"/>
                        <xsl:attribute name="title" select="$diffat"/>
                        <xsl:copy-of select="$x"/>
                    </span>
                </xsl:when>

                <xsl:otherwise>
                    <xsl:for-each select="$x">
                        <xsl:copy>
                            <!--
                                Put the value of @at into a 'title' attribute, so that
                                (typically) it pops up when you hover over the affected area.
                            -->
                            <xsl:if test="$diffat">
                                <xsl:attribute name='title' select='$diffat'/>
                            </xsl:if>

                            <!--
                                Put the diffclass into a 'class' attribute.
                                Allow for the fact that it might already be set that way
                                (in which case, no change needed)
                                or that it might exist with some other setting
                                (in which case, just append the diffclass).
                            -->
                            <xsl:attribute name='class'>
                                <xsl:choose>
                                    <xsl:when test="@class eq $diffclass">
                                        <xsl:value-of select="@class"/>
                                    </xsl:when>
                                    <xsl:when test="exists(@class)">
                                        <xsl:value-of select="concat(@class, ' ', $diffclass)"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="$diffclass"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:attribute>

                            <!--
                                And then copy over all the other attributes, and all the child nodes.
                            -->
                            <xsl:copy-of select="@*[name(.) != 'title' and name(.) != 'class' and name(.) != 'diff' and name(.) != 'at'] | node()"/>

                        </xsl:copy>
                    </xsl:for-each>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- ==================================================================== -->
<xsl:template name="DUMMY">
<![CDATA[
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
<xsl:message>Entering *[@diff='del'] in xquery-semanatics-diff.xsl</xsl:message>  <xsl:choose>
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
    <xsl:when test="@diff = 'del'"/>
    <xsl:otherwise>
      <xsl:element name="{local-name(.)}">
        <xsl:attribute name="class">diff-<xsl:value-of select="@diff"/></xsl:attribute>
        <xsl:for-each select="@*">
          <!-- Wait: some of these aren't HTML attributes after all... -->
          <xsl:if test="local-name(.) != 'diff'">
            <xsl:copy>
              <xsl:apply-templates/>
            </xsl:copy>
          </xsl:if>
        </xsl:for-each>
        <xsl:apply-templates/>
      </xsl:element>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ================================================================= -->

  <xsl:template match="bibl[@diff]" priority="1">
    <xsl:variable name="dt">
      <xsl:if test="@id">
	<a name="{@id}"/>
      </xsl:if>
      <xsl:choose>
	<xsl:when test="@key">
	  <xsl:value-of select="@key"/>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:value-of select="@id"/>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="dd">
      <xsl:apply-templates/>
      <xsl:if test="@href">
        <xsl:text>  (See </xsl:text>
        <a href="{@href}">
          <xsl:value-of select="@href"/>
        </a>
        <xsl:text>.)</xsl:text>
      </xsl:if>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="@diff='off'">
        <!-- suppress deleted markup -->
      </xsl:when>
      <xsl:when test="@diff and $show.diff.markup != 0">
	<dt class="label">
	  <span class="diff-{@diff}">
	    <xsl:copy-of select="$dt"/>
	  </span>
	</dt>
	<dd>
	  <div class="diff-{@diff}">
	    <xsl:copy-of select="$dd"/>
	  </div>
	</dd>
      </xsl:when>
      <xsl:when test="@diff='del' and $show.diff.markup = 0">
	<!-- suppressed -->
      </xsl:when>
      <xsl:otherwise>
	<dt class="label">
	  <xsl:copy-of select="$dt"/>
	</dt>
	<dd>
	  <xsl:copy-of select="$dd"/>
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
	    <xsl:if test="count(author) > 1">
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
	  <xsl:if test="count(author) > 1">
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
]]>
</xsl:template>

</xsl:stylesheet>
