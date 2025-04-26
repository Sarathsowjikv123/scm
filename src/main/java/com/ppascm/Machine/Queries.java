package com.ppascm.Machine;

public class Queries
{
	protected static final String CREATE_MACHINE_QUERY = "insert into machinestable (factory_id, product_type_id, name, status, repair_cost) VALUES (?, ?, ?, ?, ?)";
	protected static final String UPDATE_MACHINE_QUERY = "UPDATE machinestable SET factory_id=?, product_type_id=?, NAME=?, STATUS=?, repair_cost=? WHERE machine_id=?";
	protected static final String DELETE_MACHINE_QUERY = "DELETE FROM machinestable WHERE machine_id = ?";
	protected static final String GET_ALL_MACHINE_QUERY = "SELECT mt.machine_id, ft.factory_id, ft.name as factory_name, pt.product_type_id, pt.type as machine_type, mt.name as machine_name, mt.status, mt.repair_cost FROM machinestable mt join FactoriesTable ft on mt.factory_id = ft.factory_id join ProductTypeTable pt on pt.product_type_id = mt.product_type_id";
	protected static final String GET_MACHINE_BY_ID_QUERY = "SELECT mt.machine_id, ft.factory_id, ft.name as factory_name, pt.product_type_id, pt.type as machine_type, mt.name as machine_name, mt.status, mt.repair_cost FROM machinestable mt join FactoriesTable ft on mt.factory_id = ft.factory_id join ProductTypeTable pt on pt.product_type_id = mt.product_type_id where mt.machine_id = ?";
}
