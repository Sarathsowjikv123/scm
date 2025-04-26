package com.ppascm.User;

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

	protected static final String CREATE_USER_SUCCESS_MSG = "New Org Created Successfully";
	protected static final String GET_USER_SUCCESS_MSG = "All Org Retrieved Successfully";
	protected static final String UPDATE_USER_SUCCESS_MSG = "Org Info Updated Successfully";
	protected static final String DELETE_USER_SUCCESS_MSG = "Org Deleted Successfully";
	protected static final String AUTHENTICATE_USER_SUCCESS_MSG = "AUTHENTICATION SUCCESS";
	protected static final String AUTHENTICATE_USER_FAIL_MSG = "AUTHENTICATION FAILED";

}
