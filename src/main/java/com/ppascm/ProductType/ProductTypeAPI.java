package com.ppascm.ProductType;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

import org.json.JSONArray;

@WebServlet("/product_type/*")
public class ProductTypeAPI extends HttpServlet
{
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
	{
		String pathInfo = request.getPathInfo();
		response.setContentType("application/json");

		if(pathInfo.equals("/") || pathInfo.equals(null)) {
			JSONArray res = null;
			try
			{
				res = ProductTypeBean.getAllProductTypes();
				if(!res.isEmpty()) {
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
}
