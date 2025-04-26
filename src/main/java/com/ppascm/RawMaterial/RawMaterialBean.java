package com.ppascm.RawMaterial;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.json.JSONArray;
import org.json.JSONObject;

import com.ppascm.DBConnection.DBConnection;
import com.ppascm.RawMaterial.Queries;

public class RawMaterialBean
{
	public static boolean addRawMaterial(String name, int quantityAvailable, int quantityRequired, int price) throws SQLException
	{
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.CREATE_RAW_MATERIAL_QUERY);
		ps.setString(1, name);
		ps.setInt(2, quantityAvailable);
		ps.setInt(3, quantityRequired);
		ps.setInt(4, price);
		return ps.executeUpdate() > 0;
	}

	public static JSONArray getAllRawMaterials() throws SQLException
	{
		JSONArray rawMaterialsArray = new JSONArray();
		Connection conn = DBConnection.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(Queries.GET_RAW_MATERIAL_QUERY);
		while(rs.next()){
			JSONObject obj = new JSONObject();
			obj.put("rawMaterial_id", rs.getInt(1));
			obj.put("name", rs.getString(2));
			obj.put("quantity_avail", rs.getInt(3));
			obj.put("quantity_req", rs.getInt(4));
			obj.put("price", rs.getInt(5));
			rawMaterialsArray.put(obj);
		}
		return rawMaterialsArray;
	}

	public static JSONObject getRawMaterialById(int rawMaterialId) throws SQLException {
		JSONObject obj = new JSONObject();
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.GET_RAW_MATERIAL_QUERY_BY_ID);
		ps.setInt(1, rawMaterialId);
		ResultSet rs = ps.executeQuery();
		while(rs.next()){
			obj.put("rawMaterial_id", rs.getInt(1));
			obj.put("name", rs.getString(2));
			obj.put("quantity_avail", rs.getInt(3));
			obj.put("quantity_req", rs.getInt(4));
			obj.put("price", rs.getInt(5));
		}
		return obj;
	}

	public static boolean updateRawMaterial(int rawMaterialId, String name,int quantityAvailable, int quantityRequired, int price) throws SQLException {
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.UPDATE_RAW_MATERIAL_QUERY);
		ps.setString(1, name);
		ps.setInt(2, quantityAvailable);
		ps.setInt(3, quantityRequired);
		ps.setInt(4, price);
		ps.setInt(5, rawMaterialId);
		return ps.executeUpdate() > 0;
	}

	public static boolean deleteRawMaterial(int rawMaterialId) throws SQLException {
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.DELETE_RAW_MATERIAL_QUERY);
		ps.setInt(1, rawMaterialId);
		return ps.executeUpdate() > 0;
	}
}
