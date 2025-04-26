package com.ppascm.DBConnection;
import java.sql.*;
public class DBConnection
{
	private static Connection conn = null;
	private static final String url = "jdbc:mysql://localhost:3306/ppascm";
	private static final String user = "root";
	private static final String password = "";

	public static Connection getConnection() throws SQLException
	{
		if(conn == null || conn.isClosed())
		{
			conn = DriverManager.getConnection(url, user, password);
		}
		return conn;
	}

	public static void closeConnection() throws SQLException
	{
		if(conn != null)
		{
			conn.close();
		}
	}
}
