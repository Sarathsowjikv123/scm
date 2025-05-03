package com.ppascm.Factory;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;

import org.json.JSONArray;
import org.json.JSONObject;

import com.ppascm.DBConnection.DBConnection;

public class FactoryBean
{
	public static boolean createFactory(int orgId, int productTypeId, String name, String location) throws SQLException
	{
		LocalDate localDate = LocalDate.now();
		Date dateCreated = Date.valueOf(localDate);

		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.CREATE_FACTORY_QUERY);
		ps.setInt(1, orgId);
		ps.setInt(2, productTypeId);
		ps.setString(3, name);
		ps.setString(4, location);
		ps.setDate(5, dateCreated);
		return ps.executeUpdate() > 0;
	}

	public static JSONArray getAllFactories() throws SQLException {
		Connection conn = DBConnection.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(Queries.GET_ALL_FACTORIES_QUERY);
		JSONArray factoriesArray = new JSONArray();
		while(rs.next()){
			JSONObject object = new JSONObject();
			object.put("factory_id", rs.getInt(1));
			object.put("factory_name", rs.getString(2));
			object.put("org_name", rs.getString(3));
			object.put("type", rs.getString(4));
			object.put("location", rs.getString(5));
			object.put("date_created", rs.getDate(6));
			object.put("org_id", rs.getInt(7));
			factoriesArray.put(object);
		}
		return factoriesArray;
	}

	public static JSONObject getFactoryById(int factoryId) throws SQLException {
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.GET_FACTORY_BY_ID_QUERY);
		ps.setInt(1, factoryId);
		ResultSet rs = ps.executeQuery();
		JSONObject obj = new JSONObject();
		while(rs.next()){
			obj.put("factory_id", rs.getInt(1));
			obj.put("factory_name", rs.getString(2));
			obj.put("org_name", rs.getString(3));
			obj.put("type", rs.getString(4));
			obj.put("location", rs.getString(5));
			obj.put("date_created", rs.getDate(6));
			obj.put("org_id", rs.getInt(7));
		}
		return obj;
	}

	public static JSONArray getFactoryByPId(int pTypeId) throws SQLException {
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.GET_FACTORY_BY_TYPE_ID);
		JSONArray factories = new JSONArray();
		ps.setInt(1, pTypeId);
		ResultSet rs = ps.executeQuery();
		JSONObject obj = new JSONObject();
		while(rs.next()){
			obj.put("factory_id", rs.getInt(1));
			obj.put("factory_name", rs.getString(2));
			obj.put("org_name", rs.getString(3));
			obj.put("type", rs.getString(4));
			obj.put("location", rs.getString(5));
			obj.put("date_created", rs.getDate(6));
			obj.put("org_id", rs.getInt(7));
			factories.put(obj);
		}
		return factories;
	}

	public static boolean updateFactory(int orgId, int productTypeId, String name, String location, int factoryId) throws SQLException{
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.UPDATE_FACTORY_QUERY);
		ps.setInt(1, orgId);
		ps.setInt(2, productTypeId);
		ps.setString(3, name);
		ps.setString(4, location);
		ps.setInt(5, factoryId);
		return ps.executeUpdate() > 0;
	}

	public static boolean deleteFactory(int factoryId) throws SQLException
	{
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.DELETE_FACTORY_QUERY);
		ps.setInt(1, factoryId);
		return ps.executeUpdate() > 0;
	}

}
