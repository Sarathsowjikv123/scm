package com.ppascm.CustomerAndVendor;

import java.sql.PreparedStatement;

public class Queries
{
	protected static final String CREATE_CUSTOMER_QUERY = "INSERT INTO CustomersTable (org_id, name, email) VALUES (?, ?, ?)";
	protected static final String CREATE_VENDOR_QUERY = "INSERT INTO VendorsTable (org_id, name, email) VALUES (?, ?, ?)";
	protected static final String GET_CUSTOMERS_QUERY = "SELECT ct.*, ut.name FROM CustomersTable ct JOIN UsersTable ut on ct.org_id=ut.org_id";
	protected static final String GET_VENDORS_QUERY = "SELECT vt.*, ut.name FROM VendorsTable vt JOIN UsersTable ut on vt.org_id=ut.org_id";
	protected static final String GET_CUSTOMER_BY_ID = "SELECT ct.*, ut.name FROM CustomersTable ct JOIN UsersTable ut on ct.org_id=ut.org_id WHERE ct.customer_id = ?";
	protected static final String GET_VENDOR_BY_ID = "SELECT vt.*, ut.name FROM VendorsTable vt JOIN UsersTable ut on vt.org_id=ut.org_id WHERE vt.vendor_id = ?";
	protected static final String UPDATE_CUSTOMER_QUERY = "UPDATE CustomersTable SET name=?,email=? WHERE customer_id = ?";
	protected static final String UPDATE_VENDOR_QUERY = "UPDATE VendorsTable SET name=?,email=? WHERE vendor_id = ?";
	protected static final String DELETE_CUSTOMER_QUERY = "DELETE FROM CustomersTable WHERE customer_id=?";
	protected static final String DELETE_VENDOR_QUERY = "DELETE FROM VendorsTable WHERE vendor_id=?";
	protected static final String GET_CUSTOMER_EMAIL = "select email from customerstable where customer_id = ?";
	protected static final String GET_VENDOR_EMAIL = "select email from VendorsTable where vendor_id = ?";
}
