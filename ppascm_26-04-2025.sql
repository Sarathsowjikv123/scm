-- Valentina Studio --
-- MySQL dump --
-- ---------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
-- ---------------------------------------------------------


-- CREATE DATABASE "ppascm" --------------------------------
CREATE DATABASE IF NOT EXISTS `ppascm` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `ppascm`;
-- ---------------------------------------------------------


-- CREATE TABLE "CustomerOrderTrackingTable" -------------------
CREATE TABLE `CustomerOrderTrackingTable`( 
	`order_id` Int( 0 ) AUTO_INCREMENT NOT NULL,
	`delivery_status` Enum( 'IN PROGRESS', 'SHIPPED', 'DELIVERED' ) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'IN PROGRESS',
	PRIMARY KEY ( `order_id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
ENGINE = InnoDB
AUTO_INCREMENT = 3;
-- -------------------------------------------------------------


-- CREATE TABLE "customerstable" -------------------------------
CREATE TABLE `customerstable`( 
	`customer_id` Int( 0 ) AUTO_INCREMENT NOT NULL,
	`org_id` Int( 0 ) NOT NULL,
	`name` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
	`email` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
	`password` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
	PRIMARY KEY ( `customer_id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
ENGINE = InnoDB
AUTO_INCREMENT = 8;
-- -------------------------------------------------------------


-- CREATE TABLE "FactoriesTable" -------------------------------
CREATE TABLE `FactoriesTable`( 
	`factory_id` Int( 0 ) AUTO_INCREMENT NOT NULL,
	`org_id` Int( 0 ) NOT NULL,
	`product_type_id` Int( 0 ) NOT NULL,
	`name` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
	`location` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
	`date_created` Date NOT NULL,
	PRIMARY KEY ( `factory_id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
ENGINE = InnoDB
AUTO_INCREMENT = 18;
-- -------------------------------------------------------------


-- CREATE TABLE "jobstable" ------------------------------------
CREATE TABLE `jobstable`( 
	`job_id` Int( 0 ) AUTO_INCREMENT NOT NULL,
	`worker_id` Int( 0 ) NULL DEFAULT NULL,
	`machine_id` Int( 0 ) NULL DEFAULT NULL,
	`start_time` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
	`end_time` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
	`status` Enum( 'YET TO START', 'IN PROGRESS', 'COMPLETED' ) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'YET TO START',
	`order_id` Int( 0 ) NOT NULL,
	PRIMARY KEY ( `job_id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
ENGINE = InnoDB
AUTO_INCREMENT = 77;
-- -------------------------------------------------------------


-- CREATE TABLE "machinestable" --------------------------------
CREATE TABLE `machinestable`( 
	`machine_id` Int( 0 ) AUTO_INCREMENT NOT NULL,
	`factory_id` Int( 0 ) NOT NULL,
	`product_type_id` Int( 0 ) NOT NULL,
	`name` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
	`status` Enum( 'FREE', 'WORKING', 'UNDER MAINTENANCE' ) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'FREE',
	`repair_cost` Int( 0 ) NOT NULL,
	PRIMARY KEY ( `machine_id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
ENGINE = InnoDB
AUTO_INCREMENT = 7;
-- -------------------------------------------------------------


-- CREATE TABLE "OrdersAndJobs" --------------------------------
CREATE TABLE `OrdersAndJobs`( 
	`order_id` Int( 0 ) NULL DEFAULT NULL,
	`product_id` Int( 0 ) NULL DEFAULT NULL,
	`quantity` Int( 0 ) NULL DEFAULT NULL,
	`job_id` Int( 0 ) NOT NULL,
	PRIMARY KEY ( `job_id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
ENGINE = InnoDB
AUTO_INCREMENT = 77;
-- -------------------------------------------------------------


-- CREATE TABLE "OrderStatus" ----------------------------------
CREATE TABLE `OrderStatus`( 
	`order_id` Int( 0 ) AUTO_INCREMENT NOT NULL,
	`order_type` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
	`customer_or_vendor_id` Int( 0 ) NULL DEFAULT NULL,
	`status` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
	PRIMARY KEY ( `order_id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
ENGINE = InnoDB
AUTO_INCREMENT = 52;
-- -------------------------------------------------------------


-- CREATE TABLE "productrawmaterialstable" ---------------------
CREATE TABLE `productrawmaterialstable`( 
	`product_id` Int( 0 ) NOT NULL,
	`raw_material_id` Int( 0 ) NOT NULL,
	`raw_material_quantity` Int( 0 ) NOT NULL,
	PRIMARY KEY ( `product_id`, `raw_material_id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
ENGINE = InnoDB;
-- -------------------------------------------------------------


-- CREATE TABLE "ProductsTable" --------------------------------
CREATE TABLE `ProductsTable`( 
	`product_id` Int( 0 ) AUTO_INCREMENT NOT NULL,
	`product_type_id` Int( 0 ) NOT NULL,
	`name` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
	`profit_percentage` Int( 0 ) NOT NULL,
	`production_time_in_mins` Float NOT NULL,
	`quantity_available` Int( 0 ) NOT NULL,
	`quantity_required` Int( 0 ) NOT NULL,
	PRIMARY KEY ( `product_id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
ENGINE = InnoDB
AUTO_INCREMENT = 8;
-- -------------------------------------------------------------


-- CREATE TABLE "ProductTypeTable" -----------------------------
CREATE TABLE `ProductTypeTable`( 
	`product_type_id` Int( 0 ) AUTO_INCREMENT NOT NULL,
	`type` Enum( 'FURNITURE', 'STEEL PRODUCTS', 'ELECTRICAL APPLIANCES', 'PLASTIC GOODS', 'TEXTILE PRODUCTS', 'ELECTRONIC DEVICES', 'AUTOMOTIVE PARTS', 'WOODEN PRODUCTS', 'PACKAGING MATERIALS', 'STATIONARY ITEMS' ) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'FURNITURE',
	PRIMARY KEY ( `product_type_id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
ENGINE = InnoDB
AUTO_INCREMENT = 6;
-- -------------------------------------------------------------


-- CREATE TABLE "RawMaterialsTable" ----------------------------
CREATE TABLE `RawMaterialsTable`( 
	`raw_material_id` Int( 0 ) AUTO_INCREMENT NOT NULL,
	`name` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
	`quantity_available` Int( 0 ) NOT NULL,
	`quantity_required` Int( 0 ) NOT NULL,
	`price` Int( 0 ) NOT NULL,
	PRIMARY KEY ( `raw_material_id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
ENGINE = InnoDB
AUTO_INCREMENT = 7;
-- -------------------------------------------------------------


-- CREATE TABLE "UsersTable" -----------------------------------
CREATE TABLE `UsersTable`( 
	`org_id` Int( 0 ) AUTO_INCREMENT NOT NULL,
	`name` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
	`email` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
	`password` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
	`date_created` Date NOT NULL,
	PRIMARY KEY ( `org_id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
ENGINE = InnoDB
AUTO_INCREMENT = 24;
-- -------------------------------------------------------------


-- CREATE TABLE "vendorrawmaterialstable" ----------------------
CREATE TABLE `vendorrawmaterialstable`( 
	`vendor_id` Int( 0 ) NOT NULL,
	`raw_material_id` Int( 0 ) NOT NULL,
	`price` Int( 0 ) NOT NULL,
	PRIMARY KEY ( `vendor_id`, `raw_material_id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
ENGINE = InnoDB;
-- -------------------------------------------------------------


-- CREATE TABLE "VendorsTable" ---------------------------------
CREATE TABLE `VendorsTable`( 
	`vendor_id` Int( 0 ) AUTO_INCREMENT NOT NULL,
	`org_id` Int( 0 ) NOT NULL,
	`name` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
	`email` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
	`password` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
	PRIMARY KEY ( `vendor_id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
ENGINE = InnoDB
AUTO_INCREMENT = 10;
-- -------------------------------------------------------------


-- CREATE TABLE "WorkersTable" ---------------------------------
CREATE TABLE `WorkersTable`( 
	`worker_id` Int( 0 ) AUTO_INCREMENT NOT NULL,
	`product_type_id` Int( 0 ) NOT NULL,
	`name` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
	`factory_id` Int( 0 ) NOT NULL,
	`status` Enum( 'FREE', 'WORKING' ) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'FREE',
	PRIMARY KEY ( `worker_id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
ENGINE = InnoDB
AUTO_INCREMENT = 20;
-- -------------------------------------------------------------


-- Dump data of "CustomerOrderTrackingTable" ---------------
BEGIN;

INSERT INTO `CustomerOrderTrackingTable`(`order_id`,`delivery_status`) VALUES 
( '1', 'IN PROGRESS' ),
( '2', 'SHIPPED' ),
( '3', 'DELIVERED' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "customerstable" ---------------------------
BEGIN;

INSERT INTO `customerstable`(`customer_id`,`org_id`,`name`,`email`,`password`) VALUES 
( '7', '2', 'sarath', 'cust@gmail.com', '1234' ),
( '8', '2', 'kabilan', 'aaab@gmail.com', NULL );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "FactoriesTable" ---------------------------
BEGIN;

INSERT INTO `FactoriesTable`(`factory_id`,`org_id`,`product_type_id`,`name`,`location`,`date_created`) VALUES 
( '2', '2', '2', 'Factory B', 'Mumbai', '2023-05-01' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "jobstable" --------------------------------
BEGIN;

INSERT INTO `jobstable`(`job_id`,`worker_id`,`machine_id`,`start_time`,`end_time`,`status`,`order_id`) VALUES 
( '94', '1', '7', '2025-04-26T13:46:24.302291', '2025-04-26T13:49:24.302291', 'COMPLETED', '61' ),
( '95', '2', '6', '2025-04-26T13:46:24.310240', '2025-04-26T13:52:24.310240', 'COMPLETED', '61' ),
( '96', '1', '7', '2025-04-26T14:25:40.856551', '2025-04-26T14:28:40.856576', 'IN PROGRESS', '62' ),
( '97', '2', '6', '2025-04-26T14:25:40.862057', '2025-04-26T14:31:40.862069', 'IN PROGRESS', '62' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "machinestable" ----------------------------
BEGIN;

INSERT INTO `machinestable`(`machine_id`,`factory_id`,`product_type_id`,`name`,`status`,`repair_cost`) VALUES 
( '6', '2', '2', 'machine-1', 'WORKING', '1000' ),
( '7', '2', '1', 'machine-3', 'WORKING', '2000' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "OrdersAndJobs" ----------------------------
BEGIN;

INSERT INTO `OrdersAndJobs`(`order_id`,`product_id`,`quantity`,`job_id`) VALUES 
( '61', '1', '3', '94' ),
( '61', '3', '3', '95' ),
( '62', '1', '3', '96' ),
( '62', '3', '3', '97' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "OrderStatus" ------------------------------
BEGIN;

INSERT INTO `OrderStatus`(`order_id`,`order_type`,`customer_or_vendor_id`,`status`) VALUES 
( '61', 'SALES', '6', 'COMPLETED' ),
( '62', 'SALES', '6', 'IN PROGRESS' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "productrawmaterialstable" -----------------
BEGIN;

INSERT INTO `productrawmaterialstable`(`product_id`,`raw_material_id`,`raw_material_quantity`) VALUES 
( '3', '1', '5' ),
( '3', '3', '10' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "ProductsTable" ----------------------------
BEGIN;

INSERT INTO `ProductsTable`(`product_id`,`product_type_id`,`name`,`profit_percentage`,`production_time_in_mins`,`quantity_available`,`quantity_required`) VALUES 
( '1', '1', 'product-2', '15', '1', '45', '4' ),
( '2', '1', 'product-8', '15', '1', '45', '4' ),
( '3', '2', 'Table', '25', '2', '0', '2' ),
( '4', '1', 'Table-2', '10', '2', '5', '3' ),
( '5', '1', 'product-5', '15', '2', '45', '4' ),
( '6', '1', 'product-6', '15', '1', '45', '4' ),
( '7', '1', 'product-7', '15', '1', '45', '4' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "ProductTypeTable" -------------------------
BEGIN;

INSERT INTO `ProductTypeTable`(`product_type_id`,`type`) VALUES 
( '1', 'FURNITURE' ),
( '2', 'STEEL PRODUCTS' ),
( '3', 'ELECTRICAL APPLIANCES' ),
( '4', 'STATIONARY ITEMS' ),
( '5', 'ELECTRONIC DEVICES' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "RawMaterialsTable" ------------------------
BEGIN;

INSERT INTO `RawMaterialsTable`(`raw_material_id`,`name`,`quantity_available`,`quantity_required`,`price`) VALUES 
( '1', 'Wood', '500', '100', '150' ),
( '3', 'Nails', '2000', '0', '300' ),
( '5', 'Iron', '150', '100', '400' ),
( '7', 'Plastic', '100', '20', '450' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "UsersTable" -------------------------------
BEGIN;

INSERT INTO `UsersTable`(`org_id`,`name`,`email`,`password`,`date_created`) VALUES 
( '2', 'Org B', 'orgb@example.com', 'pass2', '2023-02-01' ),
( '3', 'Org C', 'orgc@example.com', 'pass3', '2023-03-01' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "vendorrawmaterialstable" ------------------
-- ---------------------------------------------------------


-- Dump data of "VendorsTable" -----------------------------
BEGIN;

INSERT INTO `VendorsTable`(`vendor_id`,`org_id`,`name`,`email`,`password`) VALUES 
( '9', '2', 'kabilan', 'aaa@gmail.com', NULL ),
( '10', '2', 'aaa', 'laal@gmail.com', NULL );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "WorkersTable" -----------------------------
BEGIN;

INSERT INTO `WorkersTable`(`worker_id`,`product_type_id`,`name`,`factory_id`,`status`) VALUES 
( '1', '1', 'Worker Alpha', '1', 'WORKING' ),
( '2', '2', 'Worker Beta', '2', 'WORKING' ),
( '3', '1', 'Worker Gamma', '1', 'FREE' ),
( '19', '2', 'worker 1', '2', 'FREE' );
COMMIT;
-- ---------------------------------------------------------


-- CREATE INDEX "fk_customer_org" ------------------------------
CREATE INDEX `fk_customer_org` USING BTREE ON `customerstable`( `org_id` );
-- -------------------------------------------------------------


-- CREATE INDEX "fk_factory_org" -------------------------------
CREATE INDEX `fk_factory_org` USING BTREE ON `FactoriesTable`( `org_id` );
-- -------------------------------------------------------------


-- CREATE INDEX "fk_job_machine" -------------------------------
CREATE INDEX `fk_job_machine` USING BTREE ON `jobstable`( `machine_id` );
-- -------------------------------------------------------------


-- CREATE INDEX "fk_job_worker" --------------------------------
CREATE INDEX `fk_job_worker` USING BTREE ON `jobstable`( `worker_id` );
-- -------------------------------------------------------------


-- CREATE INDEX "fk_machine_factory" ---------------------------
CREATE INDEX `fk_machine_factory` USING BTREE ON `machinestable`( `factory_id` );
-- -------------------------------------------------------------


-- CREATE INDEX "fk_machine_product_type" ----------------------
CREATE INDEX `fk_machine_product_type` USING BTREE ON `machinestable`( `product_type_id` );
-- -------------------------------------------------------------


-- CREATE INDEX "index_job_id" ---------------------------------
CREATE INDEX `index_job_id` USING BTREE ON `OrdersAndJobs`( `job_id` );
-- -------------------------------------------------------------


-- CHANGE "AUTOINCREMENT" OF "FIELD "job_id" -------------------
ALTER TABLE `OrdersAndJobs` MODIFY `job_id` Int( 0 ) AUTO_INCREMENT NOT NULL;
-- -------------------------------------------------------------


-- CREATE INDEX "fk_product_raw_material_material" -------------
CREATE INDEX `fk_product_raw_material_material` USING BTREE ON `productrawmaterialstable`( `raw_material_id` );
-- -------------------------------------------------------------


-- CREATE INDEX "fk_vendor_raw_materials_material" -------------
CREATE INDEX `fk_vendor_raw_materials_material` USING BTREE ON `vendorrawmaterialstable`( `raw_material_id` );
-- -------------------------------------------------------------


-- CREATE INDEX "fk_vendor_org" --------------------------------
CREATE INDEX `fk_vendor_org` USING BTREE ON `VendorsTable`( `org_id` );
-- -------------------------------------------------------------


-- CREATE INDEX "fk_worker_product_type" -----------------------
CREATE INDEX `fk_worker_product_type` USING BTREE ON `WorkersTable`( `product_type_id` );
-- -------------------------------------------------------------


-- CREATE LINK "fk_factory_org" --------------------------------
ALTER TABLE `FactoriesTable`
	ADD CONSTRAINT `fk_factory_org` FOREIGN KEY ( `org_id` )
	REFERENCES `UsersTable`( `org_id` )
	ON DELETE Cascade
	ON UPDATE No Action;
-- -------------------------------------------------------------


-- CREATE LINK "fk_job_machine" --------------------------------
ALTER TABLE `jobstable`
	ADD CONSTRAINT `fk_job_machine` FOREIGN KEY ( `machine_id` )
	REFERENCES `machinestable`( `machine_id` )
	ON DELETE Cascade
	ON UPDATE No Action;
-- -------------------------------------------------------------


-- CREATE LINK "fk_job_worker" ---------------------------------
ALTER TABLE `jobstable`
	ADD CONSTRAINT `fk_job_worker` FOREIGN KEY ( `worker_id` )
	REFERENCES `WorkersTable`( `worker_id` )
	ON DELETE No Action
	ON UPDATE No Action;
-- -------------------------------------------------------------


-- CREATE LINK "fk_machine_product_type" -----------------------
ALTER TABLE `machinestable`
	ADD CONSTRAINT `fk_machine_product_type` FOREIGN KEY ( `product_type_id` )
	REFERENCES `ProductTypeTable`( `product_type_id` )
	ON DELETE No Action
	ON UPDATE No Action;
-- -------------------------------------------------------------


-- CREATE LINK "fk_vendor_org" ---------------------------------
ALTER TABLE `VendorsTable`
	ADD CONSTRAINT `fk_vendor_org` FOREIGN KEY ( `org_id` )
	REFERENCES `UsersTable`( `org_id` )
	ON DELETE No Action
	ON UPDATE No Action;
-- -------------------------------------------------------------


-- CREATE LINK "fk_vendor_raw_materials_material" --------------
ALTER TABLE `vendorrawmaterialstable`
	ADD CONSTRAINT `fk_vendor_raw_materials_material` FOREIGN KEY ( `raw_material_id` )
	REFERENCES `RawMaterialsTable`( `raw_material_id` )
	ON DELETE No Action
	ON UPDATE No Action;
-- -------------------------------------------------------------


-- CREATE LINK "fk_worker_product_type" ------------------------
ALTER TABLE `WorkersTable`
	ADD CONSTRAINT `fk_worker_product_type` FOREIGN KEY ( `product_type_id` )
	REFERENCES `ProductTypeTable`( `product_type_id` )
	ON DELETE No Action
	ON UPDATE No Action;
-- -------------------------------------------------------------


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
-- ---------------------------------------------------------


