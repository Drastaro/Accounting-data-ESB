package com.silverwiresapp.admin.quickbooks.data;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "PlatformResponse")
public class PlatformResponse {

	String errorMessage;

	String errorCode;

	String serverTime;

	public String getErrorMessage() {
		return errorMessage;
	}

	@XmlElement(name = "ErrorMessage")
	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}

	public String getErrorCode() {
		return errorCode;
	}

	@XmlElement(name = "ErrorCode")
	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}

	public String getServerTime() {
		return serverTime;
	}

	@XmlElement(name = "ServerTime")
	public void setServerTime(String serverTime) {
		this.serverTime = serverTime;
	}

}
