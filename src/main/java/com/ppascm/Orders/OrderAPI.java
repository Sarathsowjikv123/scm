package com.ppascm.Orders;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;

import org.json.JSONArray;
import org.json.JSONObject;

import com.ppascm.CustomerAndVendor.CustomerAndVendorBean;
import com.ppascm.DBConnection.DBConnection;
import com.ppascm.EmailSender;
import com.ppascm.Machine.MachineBean;

@WebServlet("/order/*")
public class OrderAPI extends HttpServlet
{
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String pathInfo = request.getPathInfo();
		response.setContentType("application/json");

		if(pathInfo.equals("/"))
		{
			StringBuilder json = new StringBuilder();
			String line;
			try(BufferedReader reader = request.getReader())
			{
				while((line = reader.readLine()) != null)
				{
					json.append(line);
				}
			}
			JSONObject object = new JSONObject(json.toString());
			String orderType = object.getString("order_type");
			int customerOrVendorId = object.getInt("customer_or_vendor_id");
			String status = object.getString("status");
			JSONArray products = object.getJSONArray("products");
			JSONArray quantities = object.getJSONArray("quantities");

			Connection conn = null;
			try
			{
				conn = DBConnection.getConnection();
				conn.setAutoCommit(false);
				if(orderType.equals("SALES"))
				{
					JSONArray requirements = OrderBean.isRawMaterialAvailable(products, quantities);
					if(!requirements.isEmpty())
					{
						response.getWriter().write(requirements.toString());
						return;
					}
				}
				OrderBean.createOrder(orderType, customerOrVendorId, status, products, quantities);
				OrderBean.sendConfirmationEmail(orderType, customerOrVendorId, status, products, quantities);
				conn.commit();
				response.getWriter().write(Responses.RESPONSE_SUCCESS_MSG.toString());

			}
			catch(SQLException e)
			{
				try
				{
					conn.rollback();
					response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
					response.getWriter().write(e.toString());
				}
				catch(SQLException ex)
				{
					response.getWriter().write("Rollback Failed");
					throw new RuntimeException(ex);
				}
				throw new RuntimeException(e);
			}
		}
	}

	public void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String pathInfo = request.getPathInfo();
		response.setContentType("application/json");

		String pathParam = pathInfo.split("/")[1];

		if(pathInfo.split("/")[2].equals("delete")){
			int orderId = Integer.parseInt(pathParam);
			Connection conn = null;
			try
			{
				conn = DBConnection.getConnection();
				conn.setAutoCommit(false);
				if(OrderBean.deleteOrder(orderId))
				{
					conn.commit();
					response.getWriter().write(Responses.RESPONSE_SUCCESS_MSG.toString());
				} else {
					//response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
					response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
				}
			} catch(SQLException e) {
				try
				{
					conn.rollback();
					response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
					response.getWriter().write(e.toString());
				}
				catch(SQLException ex)
				{
					response.getWriter().write("Rollback Failed");
					throw new RuntimeException(ex);
				}
			}
		}
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String pathInfo = request.getPathInfo();
		response.setContentType("application/json");
		if(pathInfo.equals("/")){
			try
			{
				JSONArray res = OrderBean.getAllOrders();
				if(!res.isEmpty()){
					response.getWriter().write(res.toString());
				} else {
					response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
					response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
				}
			}
			catch(SQLException e)
			{
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
			}
		}
		else if(pathInfo.equals("/po"))
		{
			try
			{
				JSONArray res = OrderBean.getAllPO();
				if(!res.isEmpty()){
					response.getWriter().write(res.toString());
				} else {
					response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
					response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
				}
			}
			catch(SQLException e)
			{
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
			}
		} else if (pathInfo.length() > 1 & pathInfo.contains("/po")) {
			String pathParam = pathInfo.split("/")[2];
			int poID = Integer.parseInt(pathParam);
			try {
				JSONArray res = OrderBean.getPurchaseOrderById(poID);
				if(!res.isEmpty()){
					response.getWriter().write(res.toString());
				} else {
					response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
					response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
				}
			} catch(SQLException e) {
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
			}
		}
		else if(pathInfo.length() > 1)
		{
			String pathParam = pathInfo.split("/")[1];
			int orderId = Integer.parseInt(pathParam);
			try {
				JSONArray res = OrderBean.getOrderById(orderId);
				if(!res.isEmpty()){
					response.getWriter().write(res.toString());
				} else {
					response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
					response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
				}
			}
			catch(SQLException e)
			{
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
			}
		}
	}

	public void doPut(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String pathInfo = request.getPathInfo();
		response.setContentType("application/json");
		if(pathInfo.equals("/")) {
			StringBuilder json = new StringBuilder();
			String line;
			try(BufferedReader reader = request.getReader())
			{
				while((line = reader.readLine()) != null)
				{
					json.append(line);
				}
			}
			JSONObject object = new JSONObject(json.toString());
			int orderId = object.getInt("order_id");
			String status = object.getString("order_status");

			try
			{
				if(OrderBean.changePurchaseOrderStatus(orderId, status)){
					response.getWriter().write(Responses.RESPONSE_SUCCESS_MSG.toString());
				} else {
					response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
				}
			}
			catch(SQLException e)
			{
				throw new RuntimeException(e);
			}
		} else if (pathInfo.equals("/tracking")) {
			StringBuilder json = new StringBuilder();
			String line;
			try(BufferedReader reader = request.getReader())
			{
				while((line = reader.readLine()) != null)
				{
					json.append(line);
				}
			}
			JSONObject object = new JSONObject(json.toString());
			int orderId = object.getInt("order_id");
			String status = object.getString("order_status");
			try
			{
				if(OrderBean.updateOrderTracking(orderId, status)){
					response.getWriter().write(Responses.RESPONSE_SUCCESS_MSG.toString());
				} else {
					response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
				}
			}
			catch(SQLException e)
			{
				throw new RuntimeException(e);
			}
		}
	}

}
