package com.ppascm.Factory;

public class Queries
{
	protected static final String CREATE_FACTORY_QUERY = "INSERT INTO FactoriesTable (org_id, product_type_id, name, location, date_created) VALUES (?,?,?,?,?)";
	protected static final String GET_ALL_FACTORIES_QUERY = "SELECT ft.factory_id,ft.name,ut.name,pt.type,ft.location,ft.date_created,ut.org_id  FROM FactoriesTable ft join UsersTable ut on ft.org_id = ut.org_id join ProductTypeTable pt on pt.product_type_id = ft.product_type_id";
	protected static final String UPDATE_FACTORY_QUERY = "UPDATE FactoriesTable SET org_id = ?, product_type_id = ?, name = ?, location = ? WHERE factory_id = ?";
	protected static final String DELETE_FACTORY_QUERY = "DELETE FROM FactoriesTable WHERE factory_id = ?";
	protected static final String GET_FACTORY_BY_ID_QUERY = "SELECT ft.factory_id,ft.name,ut.name,pt.type,ft.location,ft.date_created,ut.org_id  FROM FactoriesTable ft join UsersTable ut on ft.org_id = ut.org_id join ProductTypeTable pt on pt.product_type_id = ft.product_type_id WHERE factory_id = ?";
	protected static final String GET_FACTORY_BY_TYPE_ID = "SELECT ft.factory_id,ft.name,ut.name,pt.type,ft.location,ft.date_created,ut.org_id  FROM FactoriesTable ft join UsersTable ut on ft.org_id = ut.org_id join ProductTypeTable pt on pt.product_type_id = ft.product_type_id where ft.product_type_id = ?";
}
