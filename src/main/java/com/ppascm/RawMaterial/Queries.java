package com.ppascm.RawMaterial;

public class Queries
{
	protected static final String CREATE_RAW_MATERIAL_QUERY = "insert into RawMaterialsTable (name, quantity_available, quantity_required, price) values (?, ?, ?, ?)";
	protected static final String UPDATE_RAW_MATERIAL_QUERY = "update RawMaterialsTable SET name=?, quantity_available=?, quantity_required=?, price=? where raw_material_id=?";
	protected static final String GET_RAW_MATERIAL_QUERY = "select * from RawMaterialsTable";
	protected static final String GET_RAW_MATERIAL_QUERY_BY_ID = "select * from RawMaterialsTable WHERE raw_material_id = ?;";
	protected static final String DELETE_RAW_MATERIAL_QUERY = "delete from RawMaterialsTable WHere raw_material_id=?";
}
