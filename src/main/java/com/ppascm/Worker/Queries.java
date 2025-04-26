package com.ppascm.Worker;

import java.sql.PreparedStatement;

public class Queries
{
	protected static final String CREATE_WORKER_QUERY = "INSERT INTO WorkersTable (product_type_id, name, factory_id) VALUES (?,?,?)";
	protected static final String GET_ALL_WORKERS_QUERY = "select wt.worker_id, wt.name, pt.type, ft.factory_id, ft.name from WorkersTable wt join ProductTypeTable pt on wt.product_type_id = pt.product_type_id join FactoriesTable ft on wt.factory_id = ft.factory_id";
	protected static final String GET_WORKER_BY_ID_QUERY = "select wt.worker_id, wt.name, pt.type, ft.factory_id, ft.name from WorkersTable wt join ProductTypeTable pt on wt.product_type_id = pt.product_type_id join FactoriesTable ft on wt.factory_id = ft.factory_id WHERE wt.worker_id = ?";
	protected static final String UPDATE_WORKER_BY_ID_QUERY = "UPDATE WorkersTable SET name = ?, factory_id = ?, product_type_id = ? WHERE worker_id = ?";
	protected static final String DELETE_WORKER_BY_ID = "DELETE FROM WorkersTable WHERE worker_id = ?";
}
