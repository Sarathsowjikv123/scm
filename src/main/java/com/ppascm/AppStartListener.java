package com.ppascm;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class AppStartListener implements ServletContextListener {
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		JobAutoCompletionScheduler.startScheduler();
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		// Cleanup if needed
	}
}

