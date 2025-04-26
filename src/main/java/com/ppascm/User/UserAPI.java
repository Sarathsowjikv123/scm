package com.ppascm.User;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.ppascm.DBConnection.*;

import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/user/*")
public class UserAPI extends HttpServlet
{
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
	{
			String pathInfo = request.getPathInfo();
			response.setContentType("application/json");

			if(pathInfo.equals("/add") || pathInfo.equals(null))
			{
				StringBuilder json = new StringBuilder();
				String line;
				try(BufferedReader reader = request.getReader()){
					while((line = reader.readLine()) != null){
						json.append(line);
					}
				}

				JSONObject object;
				try
				{
					object = new JSONObject(json.toString());
					String name = object.getString("name");
					String email = object.getString("email");
					String password = object.getString("password");
					if(UserBean.createUser(name, email, password)){
						Responses.RESPONSE_MSG.put(Responses.RESPONSE_STATUS, Responses.CREATE_USER_SUCCESS_MSG);
						response.getWriter().write(Responses.RESPONSE_MSG.toString());
					} else {
						response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
						response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
					}
				}
				catch(SQLException e)
				{
					throw new RuntimeException(e);
				}
			} else if(pathInfo.equals("/login"))
			{
				String userName = request.getParameter("user-name");
				String passWord = request.getParameter("pass-word");

				try
				{
					int orgId = UserBean.authenticateUser(userName, passWord);
					if(orgId > 0){
						HttpSession session = request.getSession();
						session.setAttribute("user-name", userName);
						session.setAttribute("pass-word", passWord);
						session.setAttribute("org-id", orgId);
						response.sendRedirect("http://localhost:8080/DashBoard.jsp");
					} else {
						response.setContentType("text/html");
						PrintWriter out = response.getWriter();
						out.println("<script type=\"text/javascript\">");
						out.println("alert('Invalid Username or Password !!!');");
						out.println("window.location.href='http://localhost:8080';");
						out.println("</script>");
					}
				}
				catch(SQLException e)
				{
					response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
					Responses.RESPONSE_MSG.put(Responses.RESPONSE_STATUS, Responses.AUTHENTICATE_USER_FAIL_MSG);
					response.getWriter().write(Responses.RESPONSE_MSG.toString());
				}
			}

	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String pathInfo = request.getPathInfo();
		response.setContentType("application/json");

		String pathParam = "";
		if(pathInfo.equals("/") || pathInfo.equals(null)){
			try
			{
				JSONArray res = UserBean.getAllUsers();
				if(!res.isEmpty())
				{
					response.getWriter().write(res.toString());
				} else {
					response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
				}
			}
			catch(SQLException e)
			{
				throw new RuntimeException(e);
			}
		}
		else if(pathInfo.equals("/logout")) {
			HttpSession session = request.getSession();
			session.removeAttribute("user-name");
			session.removeAttribute("pass-word");
			session.removeAttribute("org-id");
			response.sendRedirect("http://localhost:8080/");
		}
		else if(pathInfo.length() > 1) {
			pathParam = pathInfo.split("/")[1];
			int orgId = Integer.parseInt(pathParam);
			try {
				JSONObject res = UserBean.getUserById(orgId);
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

		String pathParamOrgId = pathInfo.split("/")[1];

		if(pathInfo.split("/")[2].equals("update")){
			StringBuilder json = new StringBuilder();
			String line;
			try(BufferedReader reader = request.getReader()){
				while((line = reader.readLine()) != null){
					json.append(line);
				}
			}

			JSONObject object;
			object = new JSONObject(json.toString());
			int orgId = Integer.parseInt(pathParamOrgId);
			String name = object.getString("name");
			String email = object.getString("email");
			String password = object.getString("password");
			try
			{
				if(UserBean.updateUser(orgId, name, email, password)){
					Responses.RESPONSE_MSG.put(Responses.RESPONSE_STATUS, Responses.UPDATE_USER_SUCCESS_MSG);
					response.getWriter().write(Responses.RESPONSE_MSG.toString());
				} else {
					response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
					response.getWriter().write(Responses.RESPONSE_FAIL_MSG.toString());
				}
			}
			catch(SQLException e)
			{
				throw new RuntimeException(e);
			}
		}
	}

	public void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String pathInfo = request.getPathInfo();
		response.setContentType("application/json");

		String pathParamOrgId = pathInfo.split("/")[1];

		if(pathInfo.split("/")[2].equals("delete")){
			int orgId = Integer.parseInt(pathParamOrgId);
			try
			{
				if(UserBean.deleteUser(orgId)){
					Responses.RESPONSE_MSG.put(Responses.RESPONSE_STATUS, Responses.DELETE_USER_SUCCESS_MSG);
					response.getWriter().write(Responses.RESPONSE_MSG.toString());
				} else {
					response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
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
