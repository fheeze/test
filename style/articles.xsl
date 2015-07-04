<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="ext"
  >


  <!-- Article pages -->
  <xsl:template name="articles">

    <!-- Generate article overview page -->
    <ext:document
      href="articles.html"
      method="xml"
      omit-xml-declaration="yes"
      encoding="utf-8"
      indent="yes">

      <xsl:call-template name="html.page">
        <xsl:with-param name="title">Articles</xsl:with-param>
        <xsl:with-param name="subtitle" select="/site/articles/introduction" />
        <xsl:with-param name="content" select="/site/articles" />
      </xsl:call-template>

    </ext:document>

    <!-- Generate article detail pages -->
    <xsl:for-each select="/site/articles/article">

      <!-- Compute filename -->
      <xsl:variable name="filename">
        <xsl:call-template name="format.filename">
          <xsl:with-param name="string" select="title" />
        </xsl:call-template>
      </xsl:variable>

      <ext:document
        href="article.{$filename}.html"
        method="xml"
        omit-xml-declaration="yes"
        encoding="utf-8"
        indent="yes">

        <xsl:call-template name="html.page">
          <xsl:with-param name="title" select="title" />
          <xsl:with-param name="subtitle" select="subtitle" />
          <xsl:with-param name="content" select="." />
        </xsl:call-template>

      </ext:document>

    </xsl:for-each>

  </xsl:template>


  <!-- Article overview page contents -->
  <xsl:template match="articles">

    <p class="x2b-gry">
      Click on the title to continue reading.
    </p>

    <xsl:for-each select="article">
      <xsl:sort select="date" order="descending" />

      <!-- Compute filename -->
      <xsl:variable name="filename">
        <xsl:call-template name="format.filename">
          <xsl:with-param name="string" select="title" />
        </xsl:call-template>
      </xsl:variable>

      <div class="row">
        <div class="col-sm-12">
          <h2>
            <a>
              <xsl:attribute name="href">article.<xsl:value-of select="$filename" />.html</xsl:attribute>
              <xsl:value-of select="title" />
              <xsl:text> </xsl:text>
              <small><xsl:value-of select="subtitle" /></small>
            </a>
          </h2>

          <p>
            <xsl:value-of select="short" />

            <br />

            // <xsl:call-template name="format.date">
              <xsl:with-param name="date" select="date" />
            </xsl:call-template>
          </p>

        </div> <!-- /column -->
      </div> <!-- /row -->

      <xsl:if test="position()!=last()">
        <hr />
      </xsl:if>

    </xsl:for-each>

  </xsl:template>


  <!-- Article detail page contents -->
  <xsl:template match="article">

    <p>
      <strong>
        <xsl:value-of select="short" />
      </strong>

      <br />

      // <xsl:call-template name="format.date">
        <xsl:with-param name="date" select="date" />
      </xsl:call-template>
    </p>

    <hr />

    <!-- Copy content from XML directly -->
    <xsl:call-template name="copy.content">
      <xsl:with-param name="content" select="content" />
    </xsl:call-template>

  </xsl:template>

</xsl:stylesheet>
