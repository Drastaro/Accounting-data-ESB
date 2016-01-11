//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.2.4 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2013.08.22 at 04:46:40 PM EST 
//


package com.silverwiresapp.admin.xeroauth.api.xsd;

import javax.xml.bind.annotation.XmlEnum;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for receiptStatus.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <p>
 * <pre>
 * &lt;simpleType name="receiptStatus">
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}token">
 *     &lt;enumeration value="DRAFT"/>
 *     &lt;enumeration value="SUBMITTED"/>
 *     &lt;enumeration value="AUTHORISED"/>
 *     &lt;enumeration value="VOIDED"/>
 *     &lt;enumeration value="DELETED"/>
 *   &lt;/restriction>
 * &lt;/simpleType>
 * </pre>
 * 
 */
@XmlType(name = "receiptStatus")
@XmlEnum
public enum ReceiptStatus {


    /**
     * Draft
     * 
     */
    DRAFT,

    /**
     * Submitted
     * 
     */
    SUBMITTED,
    AUTHORISED,
    VOIDED,
    DELETED;

    public String value() {
        return name();
    }

    public static ReceiptStatus fromValue(String v) {
        return valueOf(v);
    }

}
