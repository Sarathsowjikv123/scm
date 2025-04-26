package com.ppascm;

import java.sql.*;
import java.time.LocalTime;
import java.util.Timer;
import java.util.TimerTask;

import com.ppascm.DBConnection.DBConnection;
import com.ppascm.Orders.OrderBean;

public class JobAutoCompletionScheduler {

	public static void startScheduler() {
		Timer timer = new Timer(true);
		timer.scheduleAtFixedRate(new TimerTask() {
			@Override
			public void run() {
				Connection conn = null;
				try {
					conn = DBConnection.getConnection();
					conn.setAutoCommit(false);
					OrderBean.completeOrders();
					conn.commit();
					System.out.println("Auto-completed jobs executed successfully at --> "+ LocalTime.now());
				} catch (Exception e) {
					try
					{
						conn.rollback();
					}
					catch(SQLException ex)
					{
						throw new RuntimeException(ex);
					}
					e.printStackTrace();
				}
			}
		}, 0, 5 * 1000); // Run every 5 secs
	}
}

