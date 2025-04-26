package com.ppascm.Worker;

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

@WebServlet("/worker/*")
public class WorkerAPI extends HttpServlet
{
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
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
			try {
				if(WorkerBean.addWorker(productTypeId, name, factoryId)){
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
				JSONArray res = WorkerBean.getAllWorkers();
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
			int workerId = Integer.parseInt(pathParam);
			try {
				JSONObject res = WorkerBean.getWorkerById(workerId);
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
			int workerId = object.getInt("worker_id");
			int factoryId = object.getInt("factory_id");
			int productTypeId = object.getInt("product_type_id");
			String name = object.getString("name");
			try {
				if(WorkerBean.updateWorker(workerId, factoryId, productTypeId, name))
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
			int workerId = Integer.parseInt(pathParam);
			try {
				if(WorkerBean.deleteWorker(workerId)){
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
