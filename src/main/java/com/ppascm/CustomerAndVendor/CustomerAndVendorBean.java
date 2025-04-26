package com.ppascm.CustomerAndVendor;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.json.JSONArray;
import org.json.JSONObject;

import com.ppascm.DBConnection.DBConnection;

public class CustomerAndVendorBean
{
	public static boolean addCustomerAndVendor(int orgId, String name, String email, int customerOrVendor) throws SQLException
	{
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps;
		if(customerOrVendor == 1)
		{
			ps = conn.prepareStatement(Queries.CREATE_CUSTOMER_QUERY);
		} else {
			ps = conn.prepareStatement(Queries.CREATE_VENDOR_QUERY);
		}
		ps.setInt(1, orgId);
		ps.setString(2, name);
		ps.setString(3, email);
		return ps.executeUpdate() > 0;
	}

	public static JSONArray getAllCustomers() throws SQLException {
		Connection conn = DBConnection.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(Queries.GET_CUSTOMERS_QUERY);
		JSONArray customersArray = new JSONArray();
		while(rs.next()){
			JSONObject object = new JSONObject();
			object.put("customer_or_vendor_id", rs.getInt(1));
			object.put("org_id", rs.getString(2));
			object.put("name", rs.getString(3));
			object.put("email", rs.getString(4));
			object.put("password", rs.getString(5));
			object.put("org_name", rs.getString(6));
			customersArray.put(object);
		}
		return customersArray;
	}

	public static JSONArray getAllVendors() throws SQLException {
		Connection conn = DBConnection.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(Queries.GET_VENDORS_QUERY);
		JSONArray vendorsArray = new JSONArray();
		while(rs.next()){
			JSONObject object = new JSONObject();
			object.put("customer_or_vendor_id", rs.getInt(1));
			object.put("org_id", rs.getString(2));
			object.put("name", rs.getString(3));
			object.put("email", rs.getString(4));
			object.put("password", rs.getString(5));
			object.put("org_name", rs.getString(6));
			vendorsArray.put(object);
		}
		return vendorsArray;
	}

	public static JSONObject getCustomerById(int customerId) throws SQLException {
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.GET_CUSTOMER_BY_ID);
		ps.setInt(1, customerId);
		ResultSet rs = ps.executeQuery();
		JSONObject obj = new JSONObject();
		while(rs.next()){
			obj.put("customer_or_vendor_id", rs.getInt(1));
			obj.put("org_id", rs.getString(2));
			obj.put("name", rs.getString(3));
			obj.put("email", rs.getString(4));
			obj.put("password", rs.getString(5));
			obj.put("org_name", rs.getString(6));
		}
		return obj;
	}

	public static JSONObject getVendorById(int vendorId) throws SQLException {
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.GET_VENDOR_BY_ID);
		ps.setInt(1, vendorId);
		ResultSet rs = ps.executeQuery();
		JSONObject obj = new JSONObject();
		while(rs.next()){
			obj.put("customer_or_vendor_id", rs.getInt(1));
			obj.put("org_id", rs.getString(2));
			obj.put("name", rs.getString(3));
			obj.put("email", rs.getString(4));
			obj.put("password", rs.getString(5));
			obj.put("org_name", rs.getString(6));
		}
		return obj;
	}

	public static boolean updateCustomer(String name, String email, int customerId) throws SQLException
	{
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.UPDATE_CUSTOMER_QUERY);
		ps.setString(1, name);
		ps.setString(2, email);
		ps.setInt(3, customerId);
		return ps.executeUpdate() > 0;
	}

	public static boolean updateVendor(String name, String email, int vendorId) throws SQLException
	{
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.UPDATE_VENDOR_QUERY);
		ps.setString(1, name);
		ps.setString(2, email);
		ps.setInt(3, vendorId);
		return ps.executeUpdate() > 0;
	}

	public static boolean deleteCustomer(int customerId) throws SQLException
	{
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.DELETE_CUSTOMER_QUERY);
		ps.setInt(1, customerId);
		return ps.executeUpdate() > 0;
	}

	public static boolean deleteVendor(int vendorId) throws SQLException
	{
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.DELETE_VENDOR_QUERY);
		ps.setInt(1, vendorId);
		return ps.executeUpdate() > 0;
	}
}
