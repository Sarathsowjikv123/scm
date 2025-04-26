package com.ppascm.Orders;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalTime;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.ppascm.DBConnection.DBConnection;

public class OrderBean
{
	public static boolean createOrder(String orderType, int customerOrVendorId, String status, JSONArray products, JSONArray quantities) throws SQLException
	{
		int allJobs = 0;
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.CREATE_ORDER_QUERY, Statement.RETURN_GENERATED_KEYS);
		ps.setString(1, orderType);
		ps.setInt(2, customerOrVendorId);
		ps.setString(3, status);
		ps.executeUpdate();
		ResultSet rs = ps.getGeneratedKeys();
		int orderId = -1;

		if(rs.next())
		{
			orderId = rs.getInt(1);
		}
		rs.close();
		ps.close();

		for(int i = 0; i < products.length(); i++)
		{
			PreparedStatement ps1 = conn.prepareStatement(Queries.CREATE_ORDER_AND_JOBS, Statement.RETURN_GENERATED_KEYS);
			ps1.setInt(1, orderId);
			ps1.setInt(2, products.getInt(i));
			ps1.setInt(3, quantities.getInt(i));
			ps1.executeUpdate();

			ResultSet rs1 = ps1.getGeneratedKeys();
			int jobId = -1;

			if(rs1.next())
			{
				jobId = rs1.getInt(1);
			}
			rs1.close();
			ps1.close();

			int workerId = -1;
			int machineId = -1;

			int productTypeId = getProductTypeFromProduct(products.getInt(i));
			int freeWorkerId = isWorkerFree(productTypeId);
			int freeMachineId = isMachineFree(productTypeId);
			int productionTime = getProductionTime(products.getInt(i)) * quantities.getInt(i);
			String PPstatus = "IN PROGRESS";

			if(freeMachineId != -1 && freeWorkerId != -1)
			{
				if(createJob(jobId, freeWorkerId, freeMachineId, orderId, productionTime, PPstatus))
				{
					changeWorkerStatus(freeWorkerId, "WORKING");
					changeMachineStatus(freeMachineId, "WORKING");
					changeOrderStatus(orderId, "IN PROGRESS");
					allJobs = 1;
				} else {
					allJobs = 0;
				}
			} else {
				PPstatus = "YET TO START";
				if(createJob(jobId, freeWorkerId, freeMachineId, orderId, productionTime, PPstatus))
				{
					allJobs = 1;
				} else {
					allJobs = 0;
				}
			}
		}
		if(allJobs == 1)
		{
			return true;
		}
		return false;
	}

	public static void changeOrderStatus(int orderID) throws SQLException {

	}

	public static boolean createJob(int jobId, int workerId, int machineId, int orderId, int productionTime, String Pstatus) throws SQLException
	{
		LocalDateTime time = LocalDateTime.now();
		String startTime = time.toString();
		LocalDateTime eTime = time.plusMinutes(productionTime);
		String endTime = eTime.toString();
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps2 = null;
		if(Pstatus.equals("IN PROGRESS"))
		{
			ps2 = conn.prepareStatement(Queries.CREATE_JOBS_QUERY);
			ps2.setInt(1, jobId);
			ps2.setInt(2, workerId);
			ps2.setInt(3, machineId);
			ps2.setString(4, startTime);
			ps2.setString(5, endTime);
			ps2.setString(6, Pstatus);
			ps2.setInt(7, orderId);

		} else {
				ps2 = conn.prepareStatement(Queries.CREATE_WAITING_JOB_QUERY);
				ps2.setInt(1, jobId);
				ps2.setString(2, Pstatus);
				ps2.setInt(3, orderId);
		}
		return ps2.executeUpdate() > 0;
	}

	public static int getProductTypeFromProduct(int productId) throws SQLException
	{
		int productTypeId = -1;
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.GET_PRODUCT_TYPE_FROM_PRODUCT);
		ps.setInt(1, productId);
		ResultSet rs = ps.executeQuery();
		while(rs.next())
		{
			productTypeId = rs.getInt(1);
		}
		return productTypeId;
	}

	public static int isWorkerFree(int productTypeId) throws SQLException
	{
		int workerId = -1;
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.IS_WORKER_FREE);
		ps.setInt(1, productTypeId);
		ResultSet rs = ps.executeQuery();
		if(!rs.next())
		{
			return workerId;
		}
		else
		{
			workerId = rs.getInt(1);
			return workerId;
		}
	}

	public static int isMachineFree(int productTypeId) throws SQLException
	{
		int machineId = -1;
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.IS_MACHINE_FREE);
		ps.setInt(1, productTypeId);
		ResultSet rs = ps.executeQuery();
		if(!rs.next())
		{
			return machineId;
		}
		else
		{
			machineId = rs.getInt(1);
			return machineId;
		}

	}

	public static int getProductionTime(int productId) throws SQLException
	{
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.GET_PRODUCTION_TIME);
		ps.setInt(1, productId);
		ResultSet rs = ps.executeQuery();
		while(rs.next())
		{
			return rs.getInt(1);
		}
		return -1;
	}

	public static boolean changeWorkerStatus(int workerId, String status) throws SQLException{
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.CHANGE_WORKER_STATUS);
		ps.setString(1, status);
		ps.setInt(2, workerId);
		return ps.executeUpdate() > 0;
	}

	public static boolean changeMachineStatus(int machineId, String status) throws SQLException{
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.CHANGE_MACHINE_STATUS);
		ps.setString(1, status);
		ps.setInt(2, machineId);
		return ps.executeUpdate() > 0;
	}

	public static void changeOrderStatus(int orderId, String status) throws SQLException
	{
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.CHANGE_ORDER_STATUS);
		ps.setString(1, status);
		ps.setInt(2, orderId);
		ps.executeUpdate();
	}

	public static ResultSet getNextFreePair(int productTypeId) throws SQLException {
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.GET_NEXT_FREE_PAIR);
		ps.setInt(1, productTypeId);
		ResultSet rs = ps.executeQuery();
		return rs;
	}

	public static int getProductTypeFromJobId(int jobId) throws SQLException {
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.GET_PRODUCT_TYPE_FROM_JOB_ID);
		ps.setInt(1, jobId);
		ResultSet rs = ps.executeQuery();
		int productTypeId = 0;
		if(rs.next()) {
			productTypeId = rs.getInt(1);
		}
		return productTypeId;
	}

	public static void completeOrders() throws SQLException
	{
		boolean orderCompleted = false;
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.GET_IN_PROGRESS_ORDERS);
		ResultSet inProgressOrders = ps.executeQuery();
		boolean res = false;
		while(inProgressOrders.next())
		{
			int order_id = inProgressOrders.getInt(1);

			PreparedStatement ps2 = conn.prepareStatement(Queries.GET_JOBS_FROM_ORDER_ID);
			ps2.setInt(1, order_id);
			ResultSet JobIds = ps2.executeQuery();
			int job_id = -1;
//			if(JobIds.next()) {
//				job_id = JobIds.getInt(1);
//			}
			while(JobIds.next())
			{
				job_id = JobIds.getInt(1);
				PreparedStatement ps3 = conn.prepareStatement(Queries.GET_JOB);
				ps3.setInt(1, job_id);
				ResultSet jobs = ps3.executeQuery();
				while(jobs.next())
				{
					int worker_id = jobs.getInt(2);
					int machine_id = jobs.getInt(3);
					String end_time = jobs.getString(5);
					String jobStatus = jobs.getString(6);
					if(jobStatus.equals("COMPLETED")) {
						orderCompleted = true;
						continue;
					}
					if(worker_id > 0 && machine_id >0)
					{
						LocalDateTime endTime = LocalDateTime.parse(end_time);
						if(endTime.isBefore(LocalDateTime.now()))
						{
							PreparedStatement ps4 = conn.prepareStatement(Queries.MARK_JOB_AS_COMPLETED);
							ps4.setInt(1, worker_id);
							ps4.setInt(2, machine_id);
							ps4.setInt(3, order_id);
							ps4.setInt(4, job_id);
							res = ps4.executeUpdate() > 0;
							changeWorkerStatus(worker_id, "FREE");
							changeMachineStatus(machine_id, "FREE");
							orderCompleted = true;
						}
					}
					else
					{
						orderCompleted = false;
						startNewJob(job_id);
					}
				}
			}
			if(orderCompleted) {
				markOrderAsCompleted(order_id);
			}
		}
	}

	public static void startNewJob(int jobId) throws SQLException{

		int productTypeId = getProductTypeFromJobId(jobId);
		int freeWorkerId = isWorkerFree(productTypeId);
		int freeMachineId = isMachineFree(productTypeId);
		int productId = getProductFromJobId(jobId);
		int productQuantity = getProductQuantityFromJobId(jobId);
		int productionTime = getProductionTime(productId) * productQuantity;
		int orderId = getOrderIdFromJobId(jobId);

		String PPstatus = "IN PROGRESS";

		if(freeMachineId != -1 && freeWorkerId != -1)
		{
			if(updateJob(jobId, freeWorkerId, freeMachineId, orderId, productionTime, PPstatus))
			{
				changeWorkerStatus(freeWorkerId, "WORKING");
				changeMachineStatus(freeMachineId, "WORKING");
				changeOrderStatus(orderId, "IN PROGRESS");
			}
		}
	}

	public static boolean updateJob(int jobId, int freeWorkerId, int freeMachineId, int orderId, int productionTime, String PPstatus) throws SQLException {
		Connection conn = DBConnection.getConnection();
		LocalDateTime time = LocalDateTime.now();
		String startTime = time.toString();
		LocalDateTime eTime = LocalDateTime.now().plusMinutes(productionTime);
		String endTime = eTime.toString();

		PreparedStatement ps = conn.prepareStatement(Queries.UPDATE_JOB);
		ps.setInt(1, freeWorkerId);
		ps.setInt(2, freeMachineId);
		ps.setString(3,startTime);
		ps.setString(4,endTime);
		ps.setString(5,PPstatus);
		ps.setInt(6, jobId);
		return ps.executeUpdate() > 0;
	}

	public static void markOrderAsCompleted(int orderId) throws SQLException {
		Connection conn = DBConnection.getConnection();

		PreparedStatement ps1 = conn.prepareStatement(Queries.IS_ALL_JOBS_COMPLETED);
		ps1.setInt(1, orderId);
		ResultSet rs = ps1.executeQuery();

		if(rs.next())
		{
			if(rs.getInt(1) == 1)
			{
				PreparedStatement ps = conn.prepareStatement(Queries.MARK_ORDER_AS_COMPLETED);
				ps.setInt(1, orderId);
				ps.executeUpdate();
			}
		}

	}

	public static int getProductFromJobId(int jobId) throws SQLException {
		int productId = -1;
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.GET_PRODUCT_FROM_JOB);
		ps.setInt(1, jobId);
		ResultSet rs = ps.executeQuery();
		if(rs.next()) {
			productId = rs.getInt(1);
		}
		return productId;
	}

	public static int getProductQuantityFromJobId(int jobId) throws SQLException {
		int productQuantity = -1;
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.GET_PRODUCT_QUANTITY_FROM_JOB);
		ps.setInt(1, jobId);
		ResultSet rs = ps.executeQuery();
		if(rs.next()) {
			productQuantity = rs.getInt(1);
		}
		return productQuantity;
	}

	public static int getOrderIdFromJobId(int jobId) throws SQLException {
		int orderId = -1;
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.GET_ORDER_ID_FROM_JOB);
		ps.setInt(1, jobId);
		ResultSet rs = ps.executeQuery();
		if(rs.next()) {
			orderId = rs.getInt(1);
		}
		return orderId;
	}

	public static boolean deleteOrder(int orderId) throws SQLException {
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.DELETE_FROM_ORDER_STATUS);
		ps.setInt(1, orderId);

		PreparedStatement ps1 = conn.prepareStatement(Queries.DELETE_FROM_ORDER_AND_JOBS);
		ps1.setInt(1, orderId);

		PreparedStatement ps2 = conn.prepareStatement(Queries.DELETE_FROM_JOBS);
		ps2.setInt(1, orderId);

		boolean res = false;
		if(ps.executeUpdate() > 0 && ps1.executeUpdate() > 0 && ps2.executeUpdate() > 0) {
			res = true;
		}
		return res;
	}

	public static JSONArray getAllOrders() throws SQLException
	{
		JSONArray ordersArray = new JSONArray();
		Connection conn = DBConnection.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(Queries.GET_ALL_ORDER_DETAILS);
		while(rs.next()){
			JSONObject obj = new JSONObject();
			obj.put("order_id", rs.getInt(1));
			obj.put("job_id", rs.getInt(2));
			obj.put("worker_id", rs.getInt(3));
			obj.put("worker_name", rs.getString(4));
			obj.put("machine_id", rs.getInt(5));
			obj.put("machine_name", rs.getString(6));
			obj.put("product_id", rs.getInt(7));
			obj.put("product_name", rs.getString(8));
			obj.put("quantity", rs.getInt(9));
			obj.put("start_time", rs.getString(10));
			obj.put("end_time", rs.getString(11));
			obj.put("status", rs.getString(12));
			ordersArray.put(obj);
		}
		return ordersArray;
	}

	public static JSONArray getOrderById(int orderId) throws SQLException {
		JSONArray ordersArray = new JSONArray();
		Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(Queries.GET_ORDER_BY_ID);
		ps.setInt(1, orderId);
		ResultSet rs = ps.executeQuery();
		while(rs.next())
		{
			JSONObject obj = new JSONObject();
			obj.put("order_id", rs.getInt(1));
			obj.put("job_id", rs.getInt(2));
			obj.put("worker_id", rs.getInt(3));
			obj.put("worker_name", rs.getString(4));
			obj.put("machine_id", rs.getInt(5));
			obj.put("machine_name", rs.getString(6));
			obj.put("product_id", rs.getInt(7));
			obj.put("product_name", rs.getString(8));
			obj.put("quantity", rs.getInt(9));
			obj.put("start_time", rs.getString(10));
			obj.put("end_time", rs.getString(11));
			obj.put("status", rs.getString(12));
			ordersArray.put(obj);
		}
		return ordersArray;
	}
}
