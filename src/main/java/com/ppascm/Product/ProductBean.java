package com.ppascm.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.json.JSONArray;
import org.json.JSONObject;

import com.ppascm.DBConnection.DBConnection;
import com.ppascm.Product.Queries;

public class ProductBean
{
	public static boolean addProduct(int productTypeId, String name, int profitPercentage, int productionTimeInMins,int quantityAvailable, int quantityRequired) throws SQLException
	{
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.CREATE_PRODUCT_QUERY);
		ps.setInt(1, productTypeId);
		ps.setString(2, name);
		ps.setInt(3, profitPercentage);
		ps.setInt(4, productionTimeInMins);
		ps.setInt(5, quantityAvailable);
		ps.setInt(6, quantityRequired);
		return ps.executeUpdate() > 0;
	}

	public static JSONArray getAllProducts() throws SQLException
	{
		JSONArray productsArray = new JSONArray();
		Connection conn = DBConnection.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(Queries.GET_ALL_PRODUCT_QUERY);
		while(rs.next()){
			JSONObject obj = new JSONObject();
			obj.put("product_id", rs.getInt(1));
			obj.put("name", rs.getString(2));
			obj.put("product_type", rs.getString(3));
			obj.put("cost_price", rs.getInt(4));
			obj.put("selling_price", rs.getInt(5));
			obj.put("prod_time_in_mins", rs.getInt(6));
			obj.put("quantity_avail", rs.getInt(7));
			obj.put("quantity_req", rs.getInt(8));
			productsArray.put(obj);
		}
		return productsArray;
	}

	public static JSONObject getProductById(int productId) throws SQLException {
		JSONObject obj = new JSONObject();
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.GET_PRODUCT_QUERY_BY_ID);
		ps.setInt(1, productId);
		ResultSet rs = ps.executeQuery();
		while(rs.next()){
			obj.put("product_id", rs.getInt(1));
			obj.put("name", rs.getString(2));
			obj.put("product_type", rs.getString(3));
			obj.put("cost_price", rs.getInt(4));
			obj.put("selling_price", rs.getInt(5));
			obj.put("prod_time_in_mins", rs.getInt(6));
			obj.put("quantity_avail", rs.getInt(7));
			obj.put("quantity_req", rs.getInt(8));
		}
		return obj;
	}

	public static boolean updateProduct(int productId, int productTypeId, String name, int profitPercentage, int productionTimeInMins,int quantityAvailable, int quantityRequired) throws SQLException {
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.UPDATE_PRODUCT_QUERY);
		ps.setInt(1,productTypeId);
		ps.setString(2, name);
		ps.setInt(3, profitPercentage);
		ps.setInt(4, productionTimeInMins);
		ps.setInt(5, quantityAvailable);
		ps.setInt(6, quantityRequired);
		ps.setInt(7, productId);
		return ps.executeUpdate() > 0;
	}

	public static boolean deleteProduct(int productId) throws SQLException {
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.DELETE_PRODUCT_QUERY);
		ps.setInt(1, productId);
		return ps.executeUpdate() > 0;
	}
}
