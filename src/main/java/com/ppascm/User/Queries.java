package com.ppascm.User;

public class Queries
{
	protected static final String CREATE_USER_QUERY = "INSERT INTO UsersTable (name, email, password, date_created) VALUES (?,?,?,?)";
	protected static final String GET_ALL_USERS_QUERY = "SELECT org_id, name, email, date_created FROM UsersTable";
	protected static final String GET_USER_BY_ID_QUERY = "SELECT org_id, name, email, date_created FROM UsersTable WHERE org_id = ?";
	protected static final String UPDATE_USER_QUERY = "UPDATE UsersTable SET name = ?, email = ?, password = ? WHERE org_id = ?";
	protected static final String DELETE_USER_QUERY = "DELETE FROM UsersTable WHERE org_id = ?";
	protected static final String AUTHENTICATE_USER_QUERY = "SELECT org_id, email, password FROM UsersTable WHERE email = ?";
}
