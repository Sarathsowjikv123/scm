package com.ppascm.Machine;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.json.JSONArray;
import org.json.JSONObject;

import com.ppascm.DBConnection.DBConnection;

public class MachineBean
{
	public static boolean addMachine(int productTypeId, String name, int factoryId, String status, int repairCost) throws SQLException
	{
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.CREATE_MACHINE_QUERY);
		ps.setInt(1, factoryId);
		ps.setInt(2, productTypeId);
		ps.setString(3, name);
		ps.setString(4, status);
		ps.setInt(5, repairCost);
		return ps.executeUpdate() > 0;
	}

	public static JSONArray getAllMachines() throws SQLException
	{
		JSONArray machinesArray = new JSONArray();
		Connection conn = DBConnection.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(Queries.GET_ALL_MACHINE_QUERY);
		while(rs.next()){
			JSONObject obj = new JSONObject();
			obj.put("machine_id", rs.getInt(1));
			obj.put("factory_id", rs.getInt(2));
			obj.put("factory_name", rs.getString(3));
			obj.put("product_type_id", rs.getInt(4));
			obj.put("machine_type", rs.getString(5));
			obj.put("machine_name", rs.getString(6));
			obj.put("machine_status", rs.getString(7));
			obj.put("repair_cost", rs.getInt(8));
			machinesArray.put(obj);
		}
		return machinesArray;
	}

	public static JSONObject getMachineById(int machineId) throws SQLException {
		JSONObject obj = new JSONObject();
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.GET_MACHINE_BY_ID_QUERY);
		ps.setInt(1, machineId);
		ResultSet rs = ps.executeQuery();
		while(rs.next()){
			obj.put("machine_id", rs.getInt(1));
			obj.put("factory_id", rs.getInt(2));
			obj.put("factory_name", rs.getString(3));
			obj.put("product_type_id", rs.getInt(4));
			obj.put("machine_type", rs.getString(5));
			obj.put("machine_name", rs.getString(6));
			obj.put("machine_status", rs.getString(7));
			obj.put("repair_cost", rs.getInt(8));
		}
		return obj;
	}

	public static boolean updateMachine(int machineId, int factoryId, int productTypeId, String name, String status, int repairCost) throws SQLException {
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.UPDATE_MACHINE_QUERY);
		ps.setInt(1, factoryId);
		ps.setInt(2, productTypeId);
		ps.setString(3,name);
		ps.setString(4, status);
		ps.setInt(5, repairCost);
		ps.setInt(6, machineId);
		return ps.executeUpdate() > 0;
	}

	public static boolean deleteMachine(int machineId) throws SQLException {
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.DELETE_MACHINE_QUERY);
		ps.setInt(1, machineId);
		return ps.executeUpdate() > 0;
	}	
}
