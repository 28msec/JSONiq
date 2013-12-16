/*
Copyright (c) 2005 W3C(r) (http://www.w3.org/) (MIT (http://www.lcs.mit.edu/),
INRIA (http://www.inria.fr/), Keio (http://www.keio.ac.jp/)),
All Rights Reserved.
See http://www.w3.org/Consortium/Legal/ipr-notice-20000612#Copyright.
W3C liability
(http://www.w3.org/Consortium/Legal/ipr-notice-20000612#Legal_Disclaimer),
trademark
(http://www.w3.org/Consortium/Legal/ipr-notice-20000612#W3C_Trademarks),
document use
(http://www.w3.org/Consortium/Legal/copyright-documents-19990405),
and software licensing rules
(http://www.w3.org/Consortium/Legal/copyright-software-19980720)
apply.
*/
package org.w3c.xqparser;

import java.util.Vector;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.DefaultHandler;

/*
 * Created on Oct 16, 2005
 */

/**
 * Validates XML Files
 */
public class XMLValidator {
    /** Namespaces feature id (http://xml.org/sax/features/namespaces). */
    protected static final String NAMESPACES_FEATURE_ID = "http://xml.org/sax/features/namespaces";

    /**
     * Namespace prefixes feature id
     * (http://xml.org/sax/features/namespace-prefixes).
     */
    protected static final String NAMESPACE_PREFIXES_FEATURE_ID = "http://xml.org/sax/features/namespace-prefixes";

    /** Validation feature id (http://xml.org/sax/features/validation). */
    protected static final String VALIDATION_FEATURE_ID = "http://xml.org/sax/features/validation";

    /**
     * Schema validation feature id
     * (http://apache.org/xml/features/validation/schema).
     */
    protected static final String SCHEMA_VALIDATION_FEATURE_ID = "http://apache.org/xml/features/validation/schema";

    /**
     * Schema full checking feature id
     * (http://apache.org/xml/features/validation/schema-full-checking).
     */
    protected static final String SCHEMA_FULL_CHECKING_FEATURE_ID = "http://apache.org/xml/features/validation/schema-full-checking";

    /**
     * Dynamic validation feature id
     * (http://apache.org/xml/features/validation/dynamic).
     */
    protected static final String DYNAMIC_VALIDATION_FEATURE_ID = "http://apache.org/xml/features/validation/dynamic";

    boolean _isValid = true;

    public Boolean validateXMLFile(String inputFileName, final Vector errors) {
        try {
            XMLReader parser = null;
            SAXParserFactory spf = SAXParserFactory.newInstance();
            spf.setNamespaceAware(true);
            spf.setFeature(SCHEMA_VALIDATION_FEATURE_ID, true);
            spf.setFeature(SCHEMA_FULL_CHECKING_FEATURE_ID, true);
            spf.setValidating(true);

            SAXParser saxParser = spf.newSAXParser();
            saxParser.setProperty(
                    "http://java.sun.com/xml/jaxp/properties/schemaLanguage",
                    "http://www.w3.org/2001/XMLSchema");
            saxParser.setProperty(
                    "http://java.sun.com/xml/jaxp/properties/schemaSource",
                    "xqueryx.xsd");

            DefaultHandler handler = new DefaultHandler() {

                public void error(SAXParseException arg0) throws SAXException {
                    _isValid = false;
                    if (errors != null)
                        errors.add("  Line #"+arg0.getLineNumber()+"; "+arg0.getMessage());
                }
            };
            try {
                saxParser.parse(inputFileName, handler);
            } catch (SAXParseException e) {
                System.err.println("error: SAXParseException occurred - "
                        + e.getMessage());
                _isValid = false;
            } catch (Exception e) {
                System.err.println("error: Parse error occurred - "
                        + e.getMessage());
                Exception se = e;
                _isValid = false;
                if (e instanceof SAXException) {
                    se = ((SAXException) e).getException();
                }
                if (se != null)
                    se.printStackTrace(System.err);
                else
                    e.printStackTrace(System.err);

            }

        } catch (Exception e) {
            System.err.println("error: Unable to instantiate parser!)");
        }
        return new Boolean(_isValid);
    }

}