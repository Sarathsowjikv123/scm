package com.ppascm.Orders;

import java.sql.PreparedStatement;

import com.ppascm.DBConnection.DBConnection;
import com.ppascm.ProductType.ProductTypeBean;

public class Queries
{
	protected static final String CREATE_ORDER_QUERY = "insert into OrderStatus (order_type, customer_or_vendor_id, status, ordered_date) VALUES (?, ?, ?, ?)";
	protected static final String CREATE_ORDER_AND_JOBS = "insert into OrdersAndJobs (order_id, product_id, quantity) values (?, ?, ?)";
	protected static final String CREATE_JOBS_QUERY = "insert into jobstable (job_id, worker_id, machine_id, start_time, end_time, status, order_id) values (?,?,?,?,?,?,?)";
	protected static final String CREATE_WAITING_JOB_QUERY = "insert into jobstable (job_id, status, order_id) values (?,?,?)";
	protected static final String GET_PRODUCT_TYPE_FROM_PRODUCT = "select ptt.product_type_id from ProductTypeTable ptt join ProductsTable pt on pt.product_type_id = ptt.product_type_id where pt.product_id = ?";
	protected static final String IS_WORKER_FREE = "SELECT worker_id from WorkersTable WHERE product_type_id = ? and status = 'FREE'";
	protected static final String IS_MACHINE_FREE = "SELECT machine_id from machinesTable WHERE product_type_id = ? and status = 'FREE'";
	protected static final String GET_PRODUCTION_TIME = "SELECT production_time_in_mins from ProductsTable WHERE product_id = ?";
	protected static final String CHANGE_WORKER_STATUS = "UPDATE WorkersTable SET status=? WHERE worker_id = ?";
	protected static final String CHANGE_MACHINE_STATUS = "UPDATE machinestable SET status=? WHERE machine_id = ?";
	protected static final String CHANGE_ORDER_STATUS = "UPDATE OrderStatus SET status=? WHERE order_id=?";
	protected static final String GET_NEXT_FREE_PAIR = "select jt.worker_id, jt.machine_id, jt.end_time, oj.product_id, pt.product_type_id from jobstable jt join OrdersAndJobs oj on jt.job_id = oj.job_id join ProductsTable pt on pt.product_id = oj.product_id having jt.end_time = max(jt.end_time) and pt.product_type_id = ?";
	protected static final String GET_PRODUCT_TYPE_FROM_JOB_ID = "select pt.product_type_id from OrdersAndJobs oj join ProductsTable pt on oj.product_id = pt.product_id where oj.job_id = ?";
	protected static final String GET_IN_PROGRESS_ORDERS = "select order_id from OrderStatus where status = 'IN PROGRESS' or status = 'NOT STARTED'";
	protected static final String GET_JOB = "select * from jobstable where job_id = ?";
	protected static final String GET_JOBS_FROM_ORDER_ID = "SELECT job_id FROM OrdersAndJobs WHERE order_id = ?";
	protected static final String MARK_JOB_AS_COMPLETED = "update jobstable set status = 'COMPLETED' WHERE worker_id = ? and machine_id = ? and order_id = ? and job_id = ?";
	protected static final String MARK_ORDER_AS_COMPLETED = "UPDATE OrderStatus SET status = 'COMPLETED', completed_date=? WHERE order_id = ?";
	protected static final String GET_PRODUCT_FROM_JOB = "SELECT product_id from OrdersAndJobs WHERE job_id = ?";
	protected static final String GET_PRODUCT_QUANTITY_FROM_JOB = "SELECT quantity from OrdersAndJobs WHERE job_id = ?";
	protected static final String GET_ORDER_ID_FROM_JOB = "SELECT order_id from OrdersAndJobs WHERE job_id = ?";
	protected static final String UPDATE_JOB = "UPDATE jobstable SET worker_id=?, machine_id=?, start_time=?, end_time=?, status=? WHERE job_id = ?";
	protected static final String IS_ALL_JOBS_COMPLETED = "SELECT CASE WHEN COUNT(*) = SUM(CASE WHEN jt.status = 'COMPLETED' THEN 1 ELSE 0 END) THEN 1 ELSE 0 END AS all_completed FROM OrdersAndJobs oj JOIN JobsTable jt ON oj.job_id = jt.job_id WHERE oj.order_id = ?";
	protected static final String DELETE_FROM_ORDER_STATUS = "delete FROM OrderStatus WHERE order_id = ? AND status = 'NOT STARTED'";
	protected static final String DELETE_FROM_ORDER_AND_JOBS = "DELETE FROM OrdersAndJobs WHERE order_id = ?";
	protected static final String DELETE_FROM_JOBS = "DELETE FROM jobstable WHERE order_id = ? AND status = 'YET TO START'";
	//protected static final String GET_ALL_ORDER_DETAILS = "select jt.order_id,jt.job_id,jt.worker_id,wt.name as worker_name,jt.machine_id,mt.name as machine_name,oj.product_id,pt.name as product_name,oj.quantity,jt.start_time,jt.end_time,jt.status from jobstable jt join OrdersAndJobs oj on oj.job_id = jt.job_id join WorkersTable wt on wt.worker_id = jt.worker_id join machinestable mt on mt.machine_id = jt.machine_id join ProductsTable pt on pt.product_id = oj.product_id";
	protected static final String GET_ALL_ORDER_DETAILS = "select jt.order_id,jt.job_id,jt.worker_id,wt.name as worker_name,jt.machine_id,mt.name as machine_name,oj.product_id,pt.name as product_name,oj.quantity,jt.start_time,jt.end_time,jt.status from jobstable jt left join OrdersAndJobs oj on oj.job_id = jt.job_id left join WorkersTable wt on wt.worker_id = jt.worker_id left join machinestable mt on mt.machine_id = jt.machine_id left join ProductsTable pt on pt.product_id = oj.product_id";
	protected static final String GET_ORDER_BY_ID = "select jt.order_id,jt.job_id,jt.worker_id,wt.name as worker_name,jt.machine_id,mt.name as machine_name,oj.product_id,pt.name as product_name,oj.quantity,jt.start_time,jt.end_time,jt.status from jobstable jt join OrdersAndJobs oj on oj.job_id = jt.job_id join WorkersTable wt on wt.worker_id = jt.worker_id join machinestable mt on mt.machine_id = jt.machine_id join ProductsTable pt on pt.product_id = oj.product_id where jt.order_id = ?";
	protected static final String CHANGE_PO_STATUS = "update OrderStatus set status='RECEIVED', completed_date=? WHERE order_id = ? AND order_type = 'PURCHASE'";
	protected static final String GET_PURCHASE_ORDERS = "select os.*, oj.product_id, pt.name, oj.quantity from OrderStatus os join OrdersAndJobs oj on os.order_id = oj.order_id join ProductsTable pt on pt.product_id = oj.product_id where order_type = 'PURCHASE'";
	protected static final String ADD_ORDER_TRACKING = "INSERT INTO CustomerOrderTrackingTable(order_id, delivery_status) VALUES (?, ?)";
	protected static final String UPDATE_TRACKING = "UPDATE CustomerOrderTrackingTable SET delivery_status=? WHERE order_id=?";
	protected static final String GET_PO_BY_ID = "select os.*, oj.product_id, pt.name, oj.quantity from OrderStatus os join OrdersAndJobs oj on os.order_id = oj.order_id join ProductsTable pt on pt.product_id = oj.product_id where order_type = 'PURCHASE' and os.order_id = ?";
}
