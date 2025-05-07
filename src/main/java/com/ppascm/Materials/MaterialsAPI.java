package com.ppascm.Materials;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.security.PublicKey;
import java.sql.SQLException;

import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/material_requirements/*")
public class MaterialsAPI extends HttpServlet
{
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
	{
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
			int productId = object.getInt("product_id");
			JSONArray products = object.getJSONArray("raw_materials");
			JSONArray quantities = object.getJSONArray("quantities");
			try
			{
				if(MaterialsBean.addBillOfMaterials(productId, products, quantities)) {
					response.getWriter().write(Responses.RESPONSE_SUCCESS_MSG.toString());
				} else {
					response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
					response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
				}
			}
			catch(SQLException e)
			{
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				response.getWriter().write(e.toString());
				throw new RuntimeException(e);
			}
		}
	}

	public void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String pathInfo = request.getPathInfo();
		response.setContentType("application/json");

		String pathParam = pathInfo.split("/")[1];
		if(pathInfo.split("/")[2].equals("delete")) {
			int productId = Integer.parseInt(pathParam);
			try
			{
				if(MaterialsBean.deleteBillOfMaterial(productId)) {
					response.getWriter().write(Responses.RESPONSE_SUCCESS_MSG.toString());
				} else {
					response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
					response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
				}
			}
			catch(SQLException e)
			{
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				response.getWriter().write(e.toString());
				throw new RuntimeException(e);
			}
		}
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String pathInfo = request.getPathInfo();
		response.setContentType("application/json");

		String pathParam = pathInfo.split("/")[1];
		int productId = Integer.parseInt(pathParam);
		try
		{
			JSONArray result = MaterialsBean.getBillOfMaterial(productId);
			response.getWriter().write(result.toString());
		}
		catch(SQLException e)
		{
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			response.getWriter().write(e.toString());
			throw new RuntimeException(e);
		}
	}
}
