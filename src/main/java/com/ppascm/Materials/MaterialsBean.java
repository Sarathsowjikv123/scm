package com.ppascm.Materials;

import jakarta.servlet.ServletException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.json.JSONArray;
import org.json.JSONObject;

import com.ppascm.DBConnection.DBConnection;

public class MaterialsBean
{
	public static boolean addBillOfMaterials(int productId, JSONArray rawMaterials, JSONArray quantities) throws SQLException {
		Connection conn = DBConnection.getConnection();
		boolean res = false;
		for(int i=0;i<rawMaterials.length();i++) {
			int rawMaterialId = rawMaterials.getInt(i);
			int quantity = quantities.getInt(i);
			PreparedStatement ps = conn.prepareStatement(Queries.ADD_BILL_OF_MATERIAL);
			ps.setInt(1, productId);
			ps.setInt(2, rawMaterialId);
			ps.setInt(3, quantity);
			if(ps.executeUpdate() > 0) {
				res = true;
			} else {
				res = false;
				break;
			}
		}
		return res;
	}

	public static boolean deleteBillOfMaterial(int productId) throws SQLException {
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.DELETE_BILL_OF_MATERIAL);
		ps.setInt(1, productId);
		return ps.executeUpdate() > 0;
	}

	public static JSONArray getBillOfMaterial(int productId) throws SQLException {
		Connection conn = DBConnection.getConnection();
		JSONArray res = new JSONArray();
		PreparedStatement ps = conn.prepareStatement(Queries.GET_BILL_OF_MATERIAL);
		ps.setInt(1,productId);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			JSONObject obj = new JSONObject();
			obj.put("raw_material_id", rs.getInt(1));
			obj.put("raw_material_name", rs.getString(2));
			obj.put("quantity", rs.getInt(3));
			res.put(obj);
		}
		return res;
	}
}
