//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.2.4 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2013.08.22 at 04:46:40 PM EST 
//


package com.silverwiresapp.admin.xeroauth.api.xsd;

import javax.xml.bind.annotation.XmlEnum;
import javax.xml.bind.annotation.XmlEnumValue;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for timezoneCode.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <p>
 * <pre>
 * &lt;simpleType name="timezoneCode">
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}token">
 *     &lt;enumeration value="Dateline Standard Time"/>
 *     &lt;enumeration value="UTC-11"/>
 *     &lt;enumeration value="Hawaiian Standard Time"/>
 *     &lt;enumeration value="Alaskan Standard Time"/>
 *     &lt;enumeration value="Pacific Standard Time (Mexico)"/>
 *     &lt;enumeration value="Pacific Standard Time"/>
 *     &lt;enumeration value="Mountain Standard Time"/>
 *     &lt;enumeration value="Mountain Standard Time (Mexico)"/>
 *     &lt;enumeration value="US Mountain Standard Time"/>
 *     &lt;enumeration value="Central America Standard Time"/>
 *     &lt;enumeration value="Canada Central Standard Time"/>
 *     &lt;enumeration value="Central Standard Time"/>
 *     &lt;enumeration value="Central Standard Time (Mexico)"/>
 *     &lt;enumeration value="SA Pacific Standard Time"/>
 *     &lt;enumeration value="US Eastern Standard Time"/>
 *     &lt;enumeration value="Eastern Standard Time"/>
 *     &lt;enumeration value="Venezuela Standard Time"/>
 *     &lt;enumeration value="Paraguay Standard Time"/>
 *     &lt;enumeration value="Pacific SA Standard Time"/>
 *     &lt;enumeration value="SA Western Standard Time"/>
 *     &lt;enumeration value="Central Brazilian Standard Time"/>
 *     &lt;enumeration value="Atlantic Standard Time"/>
 *     &lt;enumeration value="Newfoundland Standard Time"/>
 *     &lt;enumeration value="SA Eastern Standard Time"/>
 *     &lt;enumeration value="Montevideo Standard Time"/>
 *     &lt;enumeration value="Argentina Standard Time"/>
 *     &lt;enumeration value="Bahia Standard Time"/>
 *     &lt;enumeration value="Greenland Standard Time"/>
 *     &lt;enumeration value="E. South America Standard Time"/>
 *     &lt;enumeration value="Mid-Atlantic Standard Time"/>
 *     &lt;enumeration value="UTC-02"/>
 *     &lt;enumeration value="Cape Verde Standard Time"/>
 *     &lt;enumeration value="Azores Standard Time"/>
 *     &lt;enumeration value="Morocco Standard Time"/>
 *     &lt;enumeration value="UTC"/>
 *     &lt;enumeration value="Greenwich Standard Time"/>
 *     &lt;enumeration value="GMT Standard Time"/>
 *     &lt;enumeration value="Romance Standard Time"/>
 *     &lt;enumeration value="Namibia Standard Time"/>
 *     &lt;enumeration value="W. Central Africa Standard Time"/>
 *     &lt;enumeration value="W. Europe Standard Time"/>
 *     &lt;enumeration value="Central Europe Standard Time"/>
 *     &lt;enumeration value="Central European Standard Time"/>
 *     &lt;enumeration value="Middle East Standard Time"/>
 *     &lt;enumeration value="Syria Standard Time"/>
 *     &lt;enumeration value="South Africa Standard Time"/>
 *     &lt;enumeration value="Turkey Standard Time"/>
 *     &lt;enumeration value="GTB Standard Time"/>
 *     &lt;enumeration value="Israel Standard Time"/>
 *     &lt;enumeration value="Jordan Standard Time"/>
 *     &lt;enumeration value="E. Europe Standard Time"/>
 *     &lt;enumeration value="FLE Standard Time"/>
 *     &lt;enumeration value="Egypt Standard Time"/>
 *     &lt;enumeration value="Arabic Standard Time"/>
 *     &lt;enumeration value="Arab Standard Time"/>
 *     &lt;enumeration value="Kaliningrad Standard Time"/>
 *     &lt;enumeration value="E. Africa Standard Time"/>
 *     &lt;enumeration value="Iran Standard Time"/>
 *     &lt;enumeration value="Russian Standard Time"/>
 *     &lt;enumeration value="Mauritius Standard Time"/>
 *     &lt;enumeration value="Caucasus Standard Time"/>
 *     &lt;enumeration value="Arabian Standard Time"/>
 *     &lt;enumeration value="Azerbaijan Standard Time"/>
 *     &lt;enumeration value="Georgian Standard Time"/>
 *     &lt;enumeration value="Afghanistan Standard Time"/>
 *     &lt;enumeration value="Pakistan Standard Time"/>
 *     &lt;enumeration value="West Asia Standard Time"/>
 *     &lt;enumeration value="Sri Lanka Standard Time"/>
 *     &lt;enumeration value="India Standard Time"/>
 *     &lt;enumeration value="Nepal Standard Time"/>
 *     &lt;enumeration value="Central Asia Standard Time"/>
 *     &lt;enumeration value="Bangladesh Standard Time"/>
 *     &lt;enumeration value="Ekaterinburg Standard Time"/>
 *     &lt;enumeration value="Myanmar Standard Time"/>
 *     &lt;enumeration value="N. Central Asia Standard Time"/>
 *     &lt;enumeration value="SE Asia Standard Time"/>
 *     &lt;enumeration value="North Asia Standard Time"/>
 *     &lt;enumeration value="W. Australia Standard Time"/>
 *     &lt;enumeration value="Taipei Standard Time"/>
 *     &lt;enumeration value="Singapore Standard Time"/>
 *     &lt;enumeration value="Ulaanbaatar Standard Time"/>
 *     &lt;enumeration value="China Standard Time"/>
 *     &lt;enumeration value="North Asia East Standard Time"/>
 *     &lt;enumeration value="Tokyo Standard Time"/>
 *     &lt;enumeration value="Korea Standard Time"/>
 *     &lt;enumeration value="Cen. Australia Standard Time"/>
 *     &lt;enumeration value="AUS Central Standard Time"/>
 *     &lt;enumeration value="West Pacific Standard Time"/>
 *     &lt;enumeration value="Yakutsk Standard Time"/>
 *     &lt;enumeration value="Tasmania Standard Time"/>
 *     &lt;enumeration value="AUS Eastern Standard Time"/>
 *     &lt;enumeration value="E. Australia Standard Time"/>
 *     &lt;enumeration value="Vladivostok Standard Time"/>
 *     &lt;enumeration value="Central Pacific Standard Time"/>
 *     &lt;enumeration value="New Zealand Standard Time"/>
 *     &lt;enumeration value="UTC+12"/>
 *     &lt;enumeration value="Kamchatka Standard Time"/>
 *     &lt;enumeration value="Magadan Standard Time"/>
 *     &lt;enumeration value="Fiji Standard Time"/>
 *     &lt;enumeration value="Samoa Standard Time"/>
 *     &lt;enumeration value="Tonga Standard Time"/>
 *   &lt;/restriction>
 * &lt;/simpleType>
 * </pre>
 * 
 */
@XmlType(name = "timezoneCode")
@XmlEnum
public enum TimezoneCode {


    /**
     * (UTC-12:00) International Date Line West
     * 
     */
    @XmlEnumValue("Dateline Standard Time")
    DATELINE_STANDARD_TIME("Dateline Standard Time"),

    /**
     * (UTC-11:00) Coordinated Universal Time-11
     * 
     */
    @XmlEnumValue("UTC-11")
    UTC_11("UTC-11"),

    /**
     * (UTC-10:00) Hawaii
     * 
     */
    @XmlEnumValue("Hawaiian Standard Time")
    HAWAIIAN_STANDARD_TIME("Hawaiian Standard Time"),

    /**
     * (UTC-09:00) Alaska
     * 
     */
    @XmlEnumValue("Alaskan Standard Time")
    ALASKAN_STANDARD_TIME("Alaskan Standard Time"),

    /**
     * (UTC-08:00) Baja California
     * 
     */
    @XmlEnumValue("Pacific Standard Time (Mexico)")
    PACIFIC_STANDARD_TIME_MEXICO("Pacific Standard Time (Mexico)"),

    /**
     * (UTC-08:00) Pacific Time (US & Canada)
     * 
     */
    @XmlEnumValue("Pacific Standard Time")
    PACIFIC_STANDARD_TIME("Pacific Standard Time"),

    /**
     * (UTC-07:00) Mountain Time (US & Canada)
     * 
     */
    @XmlEnumValue("Mountain Standard Time")
    MOUNTAIN_STANDARD_TIME("Mountain Standard Time"),

    /**
     * (UTC-07:00) Chihuahua, La Paz, Mazatlan
     * 
     */
    @XmlEnumValue("Mountain Standard Time (Mexico)")
    MOUNTAIN_STANDARD_TIME_MEXICO("Mountain Standard Time (Mexico)"),

    /**
     * (UTC-07:00) Arizona
     * 
     */
    @XmlEnumValue("US Mountain Standard Time")
    US_MOUNTAIN_STANDARD_TIME("US Mountain Standard Time"),

    /**
     * (UTC-06:00) Central America
     * 
     */
    @XmlEnumValue("Central America Standard Time")
    CENTRAL_AMERICA_STANDARD_TIME("Central America Standard Time"),

    /**
     * (UTC-06:00) Saskatchewan
     * 
     */
    @XmlEnumValue("Canada Central Standard Time")
    CANADA_CENTRAL_STANDARD_TIME("Canada Central Standard Time"),

    /**
     * (UTC-06:00) Central Time (US & Canada)
     * 
     */
    @XmlEnumValue("Central Standard Time")
    CENTRAL_STANDARD_TIME("Central Standard Time"),

    /**
     * (UTC-06:00) Guadalajara, Mexico City, Monterrey
     * 
     */
    @XmlEnumValue("Central Standard Time (Mexico)")
    CENTRAL_STANDARD_TIME_MEXICO("Central Standard Time (Mexico)"),

    /**
     * (UTC-05:00) Bogota, Lima, Quito
     * 
     */
    @XmlEnumValue("SA Pacific Standard Time")
    SA_PACIFIC_STANDARD_TIME("SA Pacific Standard Time"),

    /**
     * (UTC-05:00) Indiana (East)
     * 
     */
    @XmlEnumValue("US Eastern Standard Time")
    US_EASTERN_STANDARD_TIME("US Eastern Standard Time"),

    /**
     * (UTC-05:00) Eastern Time (US & Canada)
     * 
     */
    @XmlEnumValue("Eastern Standard Time")
    EASTERN_STANDARD_TIME("Eastern Standard Time"),

    /**
     * (UTC-04:30) Caracas
     * 
     */
    @XmlEnumValue("Venezuela Standard Time")
    VENEZUELA_STANDARD_TIME("Venezuela Standard Time"),

    /**
     * (UTC-04:00) Asuncion
     * 
     */
    @XmlEnumValue("Paraguay Standard Time")
    PARAGUAY_STANDARD_TIME("Paraguay Standard Time"),

    /**
     * (UTC-04:00) Santiago
     * 
     */
    @XmlEnumValue("Pacific SA Standard Time")
    PACIFIC_SA_STANDARD_TIME("Pacific SA Standard Time"),

    /**
     * (UTC-04:00) Georgetown, La Paz, Manaus, San Juan
     * 
     */
    @XmlEnumValue("SA Western Standard Time")
    SA_WESTERN_STANDARD_TIME("SA Western Standard Time"),

    /**
     * (UTC-04:00) Cuiaba
     * 
     */
    @XmlEnumValue("Central Brazilian Standard Time")
    CENTRAL_BRAZILIAN_STANDARD_TIME("Central Brazilian Standard Time"),

    /**
     * (UTC-04:00) Atlantic Time (Canada)
     * 
     */
    @XmlEnumValue("Atlantic Standard Time")
    ATLANTIC_STANDARD_TIME("Atlantic Standard Time"),

    /**
     * (UTC-03:30) Newfoundland
     * 
     */
    @XmlEnumValue("Newfoundland Standard Time")
    NEWFOUNDLAND_STANDARD_TIME("Newfoundland Standard Time"),

    /**
     * (UTC-03:00) Cayenne, Fortaleza
     * 
     */
    @XmlEnumValue("SA Eastern Standard Time")
    SA_EASTERN_STANDARD_TIME("SA Eastern Standard Time"),

    /**
     * (UTC-03:00) Montevideo
     * 
     */
    @XmlEnumValue("Montevideo Standard Time")
    MONTEVIDEO_STANDARD_TIME("Montevideo Standard Time"),

    /**
     * (UTC-03:00) Buenos Aires
     * 
     */
    @XmlEnumValue("Argentina Standard Time")
    ARGENTINA_STANDARD_TIME("Argentina Standard Time"),

    /**
     * (UTC-03:00) Salvador
     * 
     */
    @XmlEnumValue("Bahia Standard Time")
    BAHIA_STANDARD_TIME("Bahia Standard Time"),

    /**
     * (UTC-03:00) Greenland
     * 
     */
    @XmlEnumValue("Greenland Standard Time")
    GREENLAND_STANDARD_TIME("Greenland Standard Time"),

    /**
     * (UTC-03:00) Brasilia
     * 
     */
    @XmlEnumValue("E. South America Standard Time")
    E_SOUTH_AMERICA_STANDARD_TIME("E. South America Standard Time"),

    /**
     * (UTC-02:00) Mid-Atlantic
     * 
     */
    @XmlEnumValue("Mid-Atlantic Standard Time")
    MID_ATLANTIC_STANDARD_TIME("Mid-Atlantic Standard Time"),

    /**
     * (UTC-02:00) Coordinated Universal Time-02
     * 
     */
    @XmlEnumValue("UTC-02")
    UTC_02("UTC-02"),

    /**
     * (UTC-01:00) Cape Verde Is.
     * 
     */
    @XmlEnumValue("Cape Verde Standard Time")
    CAPE_VERDE_STANDARD_TIME("Cape Verde Standard Time"),

    /**
     * (UTC-01:00) Azores
     * 
     */
    @XmlEnumValue("Azores Standard Time")
    AZORES_STANDARD_TIME("Azores Standard Time"),

    /**
     * (UTC) Casablanca
     * 
     */
    @XmlEnumValue("Morocco Standard Time")
    MOROCCO_STANDARD_TIME("Morocco Standard Time"),

    /**
     * (UTC) Coordinated Universal Time
     * 
     */
    UTC("UTC"),

    /**
     * (UTC) Monrovia, Reykjavik
     * 
     */
    @XmlEnumValue("Greenwich Standard Time")
    GREENWICH_STANDARD_TIME("Greenwich Standard Time"),

    /**
     * (UTC) Dublin, Edinburgh, Lisbon, London
     * 
     */
    @XmlEnumValue("GMT Standard Time")
    GMT_STANDARD_TIME("GMT Standard Time"),

    /**
     * (UTC+01:00) Brussels, Copenhagen, Madrid, Paris
     * 
     */
    @XmlEnumValue("Romance Standard Time")
    ROMANCE_STANDARD_TIME("Romance Standard Time"),

    /**
     * (UTC+01:00) Windhoek
     * 
     */
    @XmlEnumValue("Namibia Standard Time")
    NAMIBIA_STANDARD_TIME("Namibia Standard Time"),

    /**
     * (UTC+01:00) West Central Africa
     * 
     */
    @XmlEnumValue("W. Central Africa Standard Time")
    W_CENTRAL_AFRICA_STANDARD_TIME("W. Central Africa Standard Time"),

    /**
     * (UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna
     * 
     */
    @XmlEnumValue("W. Europe Standard Time")
    W_EUROPE_STANDARD_TIME("W. Europe Standard Time"),

    /**
     * (UTC+01:00) Belgrade, Bratislava, Budapest, Ljubljana, Prague
     * 
     */
    @XmlEnumValue("Central Europe Standard Time")
    CENTRAL_EUROPE_STANDARD_TIME("Central Europe Standard Time"),

    /**
     * (UTC+01:00) Sarajevo, Skopje, Warsaw, Zagreb
     * 
     */
    @XmlEnumValue("Central European Standard Time")
    CENTRAL_EUROPEAN_STANDARD_TIME("Central European Standard Time"),

    /**
     * (UTC+02:00) Beirut
     * 
     */
    @XmlEnumValue("Middle East Standard Time")
    MIDDLE_EAST_STANDARD_TIME("Middle East Standard Time"),

    /**
     * (UTC+02:00) Damascus
     * 
     */
    @XmlEnumValue("Syria Standard Time")
    SYRIA_STANDARD_TIME("Syria Standard Time"),

    /**
     * (UTC+02:00) Harare, Pretoria
     * 
     */
    @XmlEnumValue("South Africa Standard Time")
    SOUTH_AFRICA_STANDARD_TIME("South Africa Standard Time"),

    /**
     * (UTC+02:00) Istanbul
     * 
     */
    @XmlEnumValue("Turkey Standard Time")
    TURKEY_STANDARD_TIME("Turkey Standard Time"),

    /**
     * (UTC+02:00) Athens, Bucharest
     * 
     */
    @XmlEnumValue("GTB Standard Time")
    GTB_STANDARD_TIME("GTB Standard Time"),

    /**
     * (UTC+02:00) Jerusalem
     * 
     */
    @XmlEnumValue("Israel Standard Time")
    ISRAEL_STANDARD_TIME("Israel Standard Time"),

    /**
     * (UTC+02:00) Amman
     * 
     */
    @XmlEnumValue("Jordan Standard Time")
    JORDAN_STANDARD_TIME("Jordan Standard Time"),

    /**
     * (UTC+02:00) Nicosia
     * 
     */
    @XmlEnumValue("E. Europe Standard Time")
    E_EUROPE_STANDARD_TIME("E. Europe Standard Time"),

    /**
     * (UTC+02:00) Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius
     * 
     */
    @XmlEnumValue("FLE Standard Time")
    FLE_STANDARD_TIME("FLE Standard Time"),

    /**
     * (UTC+02:00) Cairo
     * 
     */
    @XmlEnumValue("Egypt Standard Time")
    EGYPT_STANDARD_TIME("Egypt Standard Time"),

    /**
     * (UTC+03:00) Baghdad
     * 
     */
    @XmlEnumValue("Arabic Standard Time")
    ARABIC_STANDARD_TIME("Arabic Standard Time"),

    /**
     * (UTC+03:00) Kuwait, Riyadh
     * 
     */
    @XmlEnumValue("Arab Standard Time")
    ARAB_STANDARD_TIME("Arab Standard Time"),

    /**
     * (UTC+03:00) Kaliningrad, Minsk
     * 
     */
    @XmlEnumValue("Kaliningrad Standard Time")
    KALININGRAD_STANDARD_TIME("Kaliningrad Standard Time"),

    /**
     * (UTC+03:00) Nairobi
     * 
     */
    @XmlEnumValue("E. Africa Standard Time")
    E_AFRICA_STANDARD_TIME("E. Africa Standard Time"),

    /**
     * (UTC+03:30) Tehran
     * 
     */
    @XmlEnumValue("Iran Standard Time")
    IRAN_STANDARD_TIME("Iran Standard Time"),

    /**
     * (UTC+04:00) Moscow, St. Petersburg, Volgograd
     * 
     */
    @XmlEnumValue("Russian Standard Time")
    RUSSIAN_STANDARD_TIME("Russian Standard Time"),

    /**
     * (UTC+04:00) Port Louis
     * 
     */
    @XmlEnumValue("Mauritius Standard Time")
    MAURITIUS_STANDARD_TIME("Mauritius Standard Time"),

    /**
     * (UTC+04:00) Yerevan
     * 
     */
    @XmlEnumValue("Caucasus Standard Time")
    CAUCASUS_STANDARD_TIME("Caucasus Standard Time"),

    /**
     * (UTC+04:00) Abu Dhabi, Muscat
     * 
     */
    @XmlEnumValue("Arabian Standard Time")
    ARABIAN_STANDARD_TIME("Arabian Standard Time"),

    /**
     * (UTC+04:00) Baku
     * 
     */
    @XmlEnumValue("Azerbaijan Standard Time")
    AZERBAIJAN_STANDARD_TIME("Azerbaijan Standard Time"),

    /**
     * (UTC+04:00) Tbilisi
     * 
     */
    @XmlEnumValue("Georgian Standard Time")
    GEORGIAN_STANDARD_TIME("Georgian Standard Time"),

    /**
     * (UTC+04:30) Kabul
     * 
     */
    @XmlEnumValue("Afghanistan Standard Time")
    AFGHANISTAN_STANDARD_TIME("Afghanistan Standard Time"),

    /**
     * (UTC+05:00) Islamabad, Karachi
     * 
     */
    @XmlEnumValue("Pakistan Standard Time")
    PAKISTAN_STANDARD_TIME("Pakistan Standard Time"),

    /**
     * (UTC+05:00) Tashkent
     * 
     */
    @XmlEnumValue("West Asia Standard Time")
    WEST_ASIA_STANDARD_TIME("West Asia Standard Time"),

    /**
     * (UTC+05:30) Sri Jayawardenepura
     * 
     */
    @XmlEnumValue("Sri Lanka Standard Time")
    SRI_LANKA_STANDARD_TIME("Sri Lanka Standard Time"),

    /**
     * (UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi
     * 
     */
    @XmlEnumValue("India Standard Time")
    INDIA_STANDARD_TIME("India Standard Time"),

    /**
     * (UTC+05:45) Kathmandu
     * 
     */
    @XmlEnumValue("Nepal Standard Time")
    NEPAL_STANDARD_TIME("Nepal Standard Time"),

    /**
     * (UTC+06:00) Astana
     * 
     */
    @XmlEnumValue("Central Asia Standard Time")
    CENTRAL_ASIA_STANDARD_TIME("Central Asia Standard Time"),

    /**
     * (UTC+06:00) Dhaka
     * 
     */
    @XmlEnumValue("Bangladesh Standard Time")
    BANGLADESH_STANDARD_TIME("Bangladesh Standard Time"),

    /**
     * (UTC+06:00) Ekaterinburg
     * 
     */
    @XmlEnumValue("Ekaterinburg Standard Time")
    EKATERINBURG_STANDARD_TIME("Ekaterinburg Standard Time"),

    /**
     * (UTC+06:30) Yangon (Rangoon)
     * 
     */
    @XmlEnumValue("Myanmar Standard Time")
    MYANMAR_STANDARD_TIME("Myanmar Standard Time"),

    /**
     * (UTC+07:00) Novosibirsk
     * 
     */
    @XmlEnumValue("N. Central Asia Standard Time")
    N_CENTRAL_ASIA_STANDARD_TIME("N. Central Asia Standard Time"),

    /**
     * (UTC+07:00) Bangkok, Hanoi, Jakarta
     * 
     */
    @XmlEnumValue("SE Asia Standard Time")
    SE_ASIA_STANDARD_TIME("SE Asia Standard Time"),

    /**
     * (UTC+08:00) Krasnoyarsk
     * 
     */
    @XmlEnumValue("North Asia Standard Time")
    NORTH_ASIA_STANDARD_TIME("North Asia Standard Time"),

    /**
     * (UTC+08:00) Perth
     * 
     */
    @XmlEnumValue("W. Australia Standard Time")
    W_AUSTRALIA_STANDARD_TIME("W. Australia Standard Time"),

    /**
     * (UTC+08:00) Taipei
     * 
     */
    @XmlEnumValue("Taipei Standard Time")
    TAIPEI_STANDARD_TIME("Taipei Standard Time"),

    /**
     * (UTC+08:00) Kuala Lumpur, Singapore
     * 
     */
    @XmlEnumValue("Singapore Standard Time")
    SINGAPORE_STANDARD_TIME("Singapore Standard Time"),

    /**
     * (UTC+08:00) Ulaanbaatar
     * 
     */
    @XmlEnumValue("Ulaanbaatar Standard Time")
    ULAANBAATAR_STANDARD_TIME("Ulaanbaatar Standard Time"),

    /**
     * (UTC+08:00) Beijing, Chongqing, Hong Kong, Urumqi
     * 
     */
    @XmlEnumValue("China Standard Time")
    CHINA_STANDARD_TIME("China Standard Time"),

    /**
     * (UTC+09:00) Irkutsk
     * 
     */
    @XmlEnumValue("North Asia East Standard Time")
    NORTH_ASIA_EAST_STANDARD_TIME("North Asia East Standard Time"),

    /**
     * (UTC+09:00) Osaka, Sapporo, Tokyo
     * 
     */
    @XmlEnumValue("Tokyo Standard Time")
    TOKYO_STANDARD_TIME("Tokyo Standard Time"),

    /**
     * (UTC+09:00) Seoul
     * 
     */
    @XmlEnumValue("Korea Standard Time")
    KOREA_STANDARD_TIME("Korea Standard Time"),

    /**
     * (UTC+09:30) Adelaide
     * 
     */
    @XmlEnumValue("Cen. Australia Standard Time")
    CEN_AUSTRALIA_STANDARD_TIME("Cen. Australia Standard Time"),

    /**
     * (UTC+09:30) Darwin
     * 
     */
    @XmlEnumValue("AUS Central Standard Time")
    AUS_CENTRAL_STANDARD_TIME("AUS Central Standard Time"),

    /**
     * (UTC+10:00) Guam, Port Moresby
     * 
     */
    @XmlEnumValue("West Pacific Standard Time")
    WEST_PACIFIC_STANDARD_TIME("West Pacific Standard Time"),

    /**
     * (UTC+10:00) Yakutsk
     * 
     */
    @XmlEnumValue("Yakutsk Standard Time")
    YAKUTSK_STANDARD_TIME("Yakutsk Standard Time"),

    /**
     * (UTC+10:00) Hobart
     * 
     */
    @XmlEnumValue("Tasmania Standard Time")
    TASMANIA_STANDARD_TIME("Tasmania Standard Time"),

    /**
     * (UTC+10:00) Canberra, Melbourne, Sydney
     * 
     */
    @XmlEnumValue("AUS Eastern Standard Time")
    AUS_EASTERN_STANDARD_TIME("AUS Eastern Standard Time"),

    /**
     * (UTC+10:00) Brisbane
     * 
     */
    @XmlEnumValue("E. Australia Standard Time")
    E_AUSTRALIA_STANDARD_TIME("E. Australia Standard Time"),

    /**
     * (UTC+11:00) Vladivostok
     * 
     */
    @XmlEnumValue("Vladivostok Standard Time")
    VLADIVOSTOK_STANDARD_TIME("Vladivostok Standard Time"),

    /**
     * (UTC+11:00) Solomon Is., New Caledonia
     * 
     */
    @XmlEnumValue("Central Pacific Standard Time")
    CENTRAL_PACIFIC_STANDARD_TIME("Central Pacific Standard Time"),

    /**
     * (UTC+12:00) Auckland, Wellington
     * 
     */
    @XmlEnumValue("New Zealand Standard Time")
    NEW_ZEALAND_STANDARD_TIME("New Zealand Standard Time"),

    /**
     * (UTC+12:00) Coordinated Universal Time+12
     * 
     */
    @XmlEnumValue("UTC+12")
    UTC_12("UTC+12"),

    /**
     * (UTC+12:00) Petropavlovsk-Kamchatsky - Old
     * 
     */
    @XmlEnumValue("Kamchatka Standard Time")
    KAMCHATKA_STANDARD_TIME("Kamchatka Standard Time"),

    /**
     * (UTC+12:00) Magadan
     * 
     */
    @XmlEnumValue("Magadan Standard Time")
    MAGADAN_STANDARD_TIME("Magadan Standard Time"),

    /**
     * (UTC+12:00) Fiji
     * 
     */
    @XmlEnumValue("Fiji Standard Time")
    FIJI_STANDARD_TIME("Fiji Standard Time"),

    /**
     * (UTC+13:00) Samoa
     * 
     */
    @XmlEnumValue("Samoa Standard Time")
    SAMOA_STANDARD_TIME("Samoa Standard Time"),

    /**
     * (UTC+13:00) Nuku'alofa
     * 
     */
    @XmlEnumValue("Tonga Standard Time")
    TONGA_STANDARD_TIME("Tonga Standard Time");
    private final String value;

    TimezoneCode(String v) {
        value = v;
    }

    public String value() {
        return value;
    }

    public static TimezoneCode fromValue(String v) {
        for (TimezoneCode c: TimezoneCode.values()) {
            if (c.value.equals(v)) {
                return c;
            }
        }
        throw new IllegalArgumentException(v);
    }

}
