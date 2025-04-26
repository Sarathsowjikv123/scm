package com.ppascm.Factory;

import org.json.JSONObject;

public class Responses
{
	protected static final JSONObject RESPONSE_MSG = new JSONObject();
	protected static final JSONObject RESPONSE_FAIL_MSG = new JSONObject();
	protected static final String RESPONSE_STATUS = "status";
	protected static final String FAILED_MSG = "error";

	static {
		RESPONSE_FAIL_MSG.put(RESPONSE_STATUS, FAILED_MSG);
	}

	protected static final String CREATE_FACTORY_SUCCESS_MSG = "New FACTORY Created Successfully";
	protected static final String GET_FACTORY_SUCCESS_MSG = "FACTORIES Retrieved Successfully";
	protected static final String UPDATE_FACTORY_SUCCESS_MSG = "FACTORY Updated Successfully";
	protected static final String DELETE_FACTORY_SUCCESS_MSG = "FACTORY Deleted Successfully";
}
