package com.ppascm.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.sql.Statement;
import java.time.LocalDate;
import org.json.JSONArray;
import org.json.JSONObject;
import com.ppascm.DBConnection.DBConnection;

public class UserBean
{
	public static boolean createUser(String name, String email, String password) throws SQLException
	{
		LocalDate localDate = LocalDate.now();
		Date dateCreated = Date.valueOf(localDate);

		Connection conn = DBConnection.getConnection();

		PreparedStatement ps = conn.prepareStatement(Queries.CREATE_USER_QUERY);
		ps.setString(1,name);
		ps.setString(2,email);
		ps.setString(3,password);
		ps.setDate(4,dateCreated);
		return ps.executeUpdate() > 0;
	}

	public static JSONObject getUserById(int orgId) throws SQLException {
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.GET_USER_BY_ID_QUERY);
		ps.setInt(1, orgId);
		ResultSet rs = ps.executeQuery();
		JSONObject obj = new JSONObject();
		while(rs.next()){
			obj.put("org_id", rs.getInt(1));
			obj.put("name", rs.getString(2));
			obj.put("email", rs.getString(3));
			obj.put("date_created", rs.getDate(4));
		}
		return obj;
	}

	public static JSONArray getAllUsers() throws SQLException{
		Connection conn = DBConnection.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(Queries.GET_ALL_USERS_QUERY);
		JSONArray usersArray = new JSONArray();
		while(rs.next()){
			JSONObject object = new JSONObject();
			object.put("org_id",rs.getInt(1));
			object.put("name",rs.getString(2));
			object.put("email",rs.getString(3));
			object.put("date_created",rs.getDate(4));
			usersArray.put(object);
		}
		return usersArray;
	}

	public static boolean updateUser(int orgId, String name, String email, String password) throws SQLException{
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.UPDATE_USER_QUERY);
		ps.setString(1, name);
		ps.setString(2, email);
		ps.setString(3, password);
		ps.setInt(4, orgId);
		return ps.executeUpdate() > 0;
	}

	public static boolean deleteUser(int orgId) throws SQLException {
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.DELETE_USER_QUERY);
		ps.setInt(1, orgId);
		return ps.executeUpdate() > 0;
	}

	public static int authenticateUser(String userName, String passWord) throws SQLException {
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.AUTHENTICATE_USER_QUERY);
		ps.setString(1,userName);
		ResultSet rs = ps.executeQuery();
		int orgId = 0;
		String userNameFromDB = null;
		String passWordFromDB = null;
		while(rs.next()){
			orgId = rs.getInt(1);
			userNameFromDB = rs.getString(2);
			passWordFromDB = rs.getString(3);
		}
		if(userName.equals(userNameFromDB) & passWord.equals(passWordFromDB)) {
			return orgId;
		}
		return 0;
	}
}
