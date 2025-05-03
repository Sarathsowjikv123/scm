package com.ppascm.Machine;

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

import com.ppascm.Machine.MachineBean;

@WebServlet("/machines/*")
public class MachineAPI extends HttpServlet
{
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
	{
		String pathInfo = request.getPathInfo();
		response.setContentType("application/json");

		if(pathInfo.equals("/")) {
			StringBuilder json = new StringBuilder();
			String line;
			try(BufferedReader reader = request.getReader()){
				while((line = reader.readLine()) != null){
					json.append(line);
				}
			}

			JSONObject object = new JSONObject(json.toString());
			int factoryId = object.getInt("factory_id");
			int productTypeId = object.getInt("product_type_id");
			String name = object.getString("name");
			String status = object.getString("status");
			int repairCost = object.getInt("repair_cost");
			try {
				if(MachineBean.addMachine(productTypeId, name, factoryId, status, repairCost)){
					response.getWriter().write(Responses.RESPONSE_SUCCESS_MSG.toString());
				} else {
					response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
					response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
				}
			} catch (SQLException e) {
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
			}
		}
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String pathInfo = request.getPathInfo();
		response.setContentType("application/json");
		if(pathInfo.equals("/")){
			try
			{
				JSONArray res = MachineBean.getAllMachines();
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
		else if(pathInfo.length() > 1)
		{
			String pathParam = pathInfo.split("/")[1];
			int machineId = Integer.parseInt(pathParam);
			try {
				JSONObject res = MachineBean.getMachineById(machineId);
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

		if(pathInfo.equals("/")){
			StringBuilder json = new StringBuilder();
			String line;
			try(BufferedReader reader = request.getReader()){
				while((line = reader.readLine()) != null){
					json.append(line);
				}
			}

			JSONObject object = new JSONObject(json.toString());
			int factoryId = object.getInt("factory_id");
			int productTypeId = object.getInt("product_type_id");
			String name = object.getString("name");
			int repairCost = object.getInt("repair_cost");
			int machineId = object.getInt("machine_id");
			try {
				if(MachineBean.updateMachine(machineId, factoryId, productTypeId, name, repairCost))
				{
					response.getWriter().write(Responses.RESPONSE_SUCCESS_MSG.toString());
				} else {
					response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
					response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
				}
			} catch(Exception e) {
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
			}
		}
	}

	public void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String pathInfo = request.getPathInfo();
		response.setContentType("application/json");

		String pathParam = pathInfo.split("/")[1];

		if(pathInfo.split("/")[2].equals("delete")){
			int machineId = Integer.parseInt(pathParam);
			try {
				if(MachineBean.deleteMachine(machineId)){
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
