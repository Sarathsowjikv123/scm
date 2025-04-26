package com.ppascm.RawMaterial;

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

@WebServlet("/raw_material/*")
public class RawMaterialAPI extends HttpServlet
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
			String name = object.getString("name");
			int quantityAvailable = object.getInt("quantityAvailable");
			int quantityRequired = object.getInt("quantityRequired");
			int price = object.getInt("price");
			try {
				if(RawMaterialBean.addRawMaterial(name, quantityAvailable, quantityRequired, price)){
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
				JSONArray res = RawMaterialBean.getAllRawMaterials();
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
			int rawMaterialId = Integer.parseInt(pathParam);
			try {
				JSONObject res = RawMaterialBean.getRawMaterialById(rawMaterialId);
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
			int rawMaterialId = object.getInt("rawMaterialId");
			String name = object.getString("name");
			int quantityAvailable = object.getInt("quantityAvailable");
			int quantityRequired = object.getInt("quantityRequired");
			int price = object.getInt("price");
			try {
				if(RawMaterialBean.updateRawMaterial(rawMaterialId, name, quantityAvailable, quantityRequired, price))
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
			int rawMaterialId = Integer.parseInt(pathParam);
			try {
				if(RawMaterialBean.deleteRawMaterial(rawMaterialId)){
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
