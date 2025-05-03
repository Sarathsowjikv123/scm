package com.ppascm.Factory;

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

@WebServlet("/factory/*")
public class FactoryAPI extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String pathInfo = request.getPathInfo();
		response.setContentType("application/json");

		if(pathInfo.equals("/") || pathInfo.equals(null)){
			StringBuilder json = new StringBuilder();
			String line;
			try(BufferedReader reader = request.getReader()){
				while((line = reader.readLine()) != null){
					json.append(line);
				}
			}
			JSONObject object = new JSONObject(json.toString());
			int orgId = object.getInt("org_id");
			int productTypeId = object.getInt("product_type_id");
			String name = object.getString("name");
			String location = object.getString("location");

			try{
				if(FactoryBean.createFactory(orgId, productTypeId, name, location)){
					Responses.RESPONSE_MSG.put(Responses.RESPONSE_STATUS, Responses.CREATE_FACTORY_SUCCESS_MSG);
					response.getWriter().write(Responses.RESPONSE_MSG.toString());
				} else {
					response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
					response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
				}
			} catch(SQLException e) {
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
			}

		}
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String pathInfo = request.getPathInfo();
		response.setContentType("application/json");

		String pathParam = "";
		if(pathInfo.equals("/")){
			try{
				JSONArray res = FactoryBean.getAllFactories();
				if(!res.isEmpty()) {
					response.getWriter().write(res.toString());
				} else {
					response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
				}
			}
			catch(SQLException e)
			{
				throw new RuntimeException(e);
			}
		} else if(pathInfo.length() > 1 & pathInfo.contains("/pt")) {
			pathParam = pathInfo.split("/")[2];
			int factoryPId = Integer.parseInt(pathParam);
			try {
				JSONArray res = FactoryBean.getFactoryByPId(factoryPId);
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
		else if(pathInfo.length() > 1) {
			pathParam = pathInfo.split("/")[1];
			int factoryId = Integer.parseInt(pathParam);
			try {
				JSONObject res = FactoryBean.getFactoryById(factoryId);
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

		String pathParam = pathInfo.split("/")[1];

		if(pathInfo.split("/")[2].equals("update"))
		{
			StringBuilder json = new StringBuilder();
			String line;
			try(BufferedReader reader = request.getReader()){
				while((line = reader.readLine()) != null){
					json.append(line);
				}
			}
			JSONObject object = new JSONObject(json.toString());
			int orgId = object.getInt("org_id");
			int productTypeId = object.getInt("product_type_id");
			String name = object.getString("name");
			String location = object.getString("location");
			int factoryId = object.getInt("factory_id");

			try {
				if(FactoryBean.updateFactory(orgId,productTypeId, name, location, factoryId)){
					Responses.RESPONSE_MSG.put(Responses.RESPONSE_STATUS, Responses.UPDATE_FACTORY_SUCCESS_MSG);
					response.getWriter().write(Responses.RESPONSE_MSG.toString());
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

		String pathParam = pathInfo.split("/")[1];

		if(pathInfo.split("/")[2].equals("delete")){
			int factoryId = Integer.parseInt(pathParam);
			try {
				if(FactoryBean.deleteFactory(factoryId)){
					Responses.RESPONSE_MSG.put(Responses.RESPONSE_STATUS, Responses.DELETE_FACTORY_SUCCESS_MSG);
					response.getWriter().write(Responses.RESPONSE_MSG.toString());
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
