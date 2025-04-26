package com.ppascm.Product;

import org.json.JSONObject;

public class Responses
{
	protected static final JSONObject RESPONSE_SUCCESS_MSG = new JSONObject();
	protected static final JSONObject RESPONSE_FAIL_MSG = new JSONObject();
	static {
		RESPONSE_SUCCESS_MSG.put("status","success");
		RESPONSE_FAIL_MSG.put("status", "error");
	}
}
