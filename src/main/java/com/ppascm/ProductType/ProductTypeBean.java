package com.ppascm.ProductType;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.json.JSONArray;
import org.json.JSONObject;

import com.ppascm.DBConnection.DBConnection;

public class ProductTypeBean
{
	public static JSONArray getAllProductTypes() throws SQLException
	{
		Connection conn = DBConnection.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(Queries.GET_ALL_PRODUCT_TYPES);
		JSONArray res = new JSONArray();
		while(rs.next()) {
			JSONObject obj = new JSONObject();
			obj.put("product_type_id", rs.getInt(1));
			obj.put("product_type", rs.getString(2));
			res.put(obj);
		}
		return res;
	}
}
