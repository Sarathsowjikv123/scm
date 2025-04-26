package com.ppascm.Worker;
import java.sql.*;

import org.json.JSONArray;
import org.json.JSONObject;

import com.ppascm.DBConnection.DBConnection;

public class WorkerBean
{
	public static boolean addWorker(int productTypeId, String name, int factoryId) throws SQLException
	{
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.CREATE_WORKER_QUERY);
		ps.setInt(1, productTypeId);
		ps.setString(2, name);
		ps.setInt(3, factoryId);
		return ps.executeUpdate() > 0;
	}

	public static JSONArray getAllWorkers() throws SQLException
	{
		JSONArray workersArray = new JSONArray();
		Connection conn = DBConnection.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(Queries.GET_ALL_WORKERS_QUERY);
		while(rs.next()){
			JSONObject obj = new JSONObject();
			obj.put("worker_id", rs.getInt(1));
			obj.put("name", rs.getString(2));
			obj.put("worker_type", rs.getString(3));
			obj.put("factory_id", rs.getInt(4));
			obj.put("factory_name", rs.getString(5));
			workersArray.put(obj);
		}
		return workersArray;
	}

	public static JSONObject getWorkerById(int workerId) throws SQLException {
		JSONObject obj = new JSONObject();
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.GET_WORKER_BY_ID_QUERY);
		ps.setInt(1, workerId);
		ResultSet rs = ps.executeQuery();
		while(rs.next()){
			obj.put("worker_id", rs.getInt(1));
			obj.put("name", rs.getString(2));
			obj.put("worker_type", rs.getString(3));
			obj.put("factory_id", rs.getInt(4));
			obj.put("factory_name", rs.getString(5));
		}
		return obj;
	}

	public static boolean updateWorker(int workerId, int factoryId, int productTypeId, String name) throws SQLException {
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.UPDATE_WORKER_BY_ID_QUERY);
		ps.setString(1,name);
		ps.setInt(2, factoryId);
		ps.setInt(3, productTypeId);
		ps.setInt(4, workerId);
		return ps.executeUpdate() > 0;
	}

	public static boolean deleteWorker(int workerId) throws SQLException {
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.DELETE_WORKER_BY_ID);
		ps.setInt(1, workerId);
		return ps.executeUpdate() > 0;
	}
}
