package com.ppascm.CustomerAndVendor;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.SQLException;

import org.json.JSONArray;
import org.json.JSONObject;

import com.ppascm.Factory.FactoryBean;

@WebServlet("/customer_and_vendor/*")
public class CustomerAndVendorAPI extends HttpServlet
{
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		String pathInfo = request.getPathInfo();
		response.setContentType("application/json");

		if(pathInfo.equals("/") || pathInfo.equals(null))
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
			int orgId = object.getInt("org_id");
			String name = object.getString("name");
			String email = object.getString("email");
			int customerOrVendor = object.getInt("customerorvendor");
			try
			{
				if(CustomerAndVendorBean.addCustomerAndVendor(orgId, name, email, customerOrVendor))
				{
					response.getWriter().write(Responses.RESPONSE_SUCCESS_MSG.toString());
				}
				else
				{
					response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
					response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
				}
			}
			catch(SQLException e)
			{
				throw new RuntimeException(e);
			}
		}
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		String pathInfo = request.getPathInfo();
		response.setContentType("application/json");

		String pathParam = "";
		if(pathInfo.equals("/customers"))
		{
			try
			{
				JSONArray res;
				res = CustomerAndVendorBean.getAllCustomers();
				if(!res.isEmpty())
				{
					response.getWriter().write(res.toString());
				}
				else
				{
					response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
				}
			}
			catch(SQLException e)
			{
				throw new RuntimeException(e);
			}
		}
		else if(pathInfo.equals("/vendors"))
		{
			try
			{
				JSONArray res;
				res = CustomerAndVendorBean.getAllVendors();
				if(!res.isEmpty())
				{
					response.getWriter().write(res.toString());
				}
				else
				{
					response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
				}
			}
			catch(SQLException e)
			{
				throw new RuntimeException(e);
			}
		}
		else if(pathInfo.split("/")[1].equals("customers"))
		{
			pathParam = pathInfo.split("/")[2];
			int customerId = Integer.parseInt(pathParam);
			try {
				JSONObject res = CustomerAndVendorBean.getCustomerById(customerId);
				if(!res.isEmpty()){
					response.getWriter().write(res.toString());
				} else {
					response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
					response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
				}
			}
			catch(SQLException e)
			{
				throw new RuntimeException(e);
			}
		}
		else if(pathInfo.split("/")[1].equals("vendors"))
		{
			pathParam = pathInfo.split("/")[2];
			int vendorId = Integer.parseInt(pathParam);
			try {
				JSONObject res = CustomerAndVendorBean.getVendorById(vendorId);
				if(!res.isEmpty()){
					response.getWriter().write(res.toString());
				} else {
					response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
					response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
				}
			}
			catch(SQLException e)
			{
				throw new RuntimeException(e);
			}
		}
	}

	public void doPut(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String pathInfo = request.getPathInfo();
		response.setContentType("application/json");

		if(pathInfo.split("/")[1].equals("customers"))
		{
			String pathParam = pathInfo.split("/")[2];
			StringBuilder json = new StringBuilder();
			String line;
			try(BufferedReader reader = request.getReader()){
				while((line = reader.readLine()) != null){
					json.append(line);
				}
			}
			JSONObject object = new JSONObject(json.toString());
			int customerId = Integer.parseInt(pathParam);
			String name = object.getString("name");
			String email = object.getString("email");

			try {
				if(CustomerAndVendorBean.updateCustomer(name, email, customerId)){
					response.getWriter().write(Responses.RESPONSE_SUCCESS_MSG.toString());
				} else {
					response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
					response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
				}
			} catch(SQLException e) {
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
			}
		}
		else if(pathInfo.split("/")[1].equals("vendors"))
		{
			String pathParam = pathInfo.split("/")[2];
			StringBuilder json = new StringBuilder();
			String line;
			try(BufferedReader reader = request.getReader()){
				while((line = reader.readLine()) != null){
					json.append(line);
				}
			}
			JSONObject object = new JSONObject(json.toString());
			int vendorId = Integer.parseInt(pathParam);
			String name = object.getString("name");
			String email = object.getString("email");
			try {
				if(CustomerAndVendorBean.updateVendor(name, email, vendorId)){
					response.getWriter().write(Responses.RESPONSE_SUCCESS_MSG.toString());
				} else {
					response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
					response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
				}
			} catch(SQLException e) {
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
			}
		}
	}

	public void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String pathInfo = request.getPathInfo();
		response.setContentType("application/json");

		String pathParam = pathInfo.split("/")[2];

		if(pathInfo.split("/")[1].equals("customers")){
			int customerId = Integer.parseInt(pathParam);
			try {
				if(CustomerAndVendorBean.deleteCustomer(customerId)){
					response.getWriter().write(Responses.RESPONSE_SUCCESS_MSG.toString());
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
		} else if(pathInfo.split("/")[1].equals("vendors")){
			int vendorId = Integer.parseInt(pathParam);
			try {
				if(CustomerAndVendorBean.deleteVendor(vendorId)){
					response.getWriter().write(Responses.RESPONSE_SUCCESS_MSG.toString());
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
}
