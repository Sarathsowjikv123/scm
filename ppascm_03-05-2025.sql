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
	`delivery_status` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'IN PROGRESS',
	PRIMARY KEY ( `order_id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
ENGINE = InnoDB
AUTO_INCREMENT = 4;
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
AUTO_INCREMENT = 12;
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
AUTO_INCREMENT = 24;
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
AUTO_INCREMENT = 170;
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
AUTO_INCREMENT = 16;
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
AUTO_INCREMENT = 174;
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
AUTO_INCREMENT = 109;
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
AUTO_INCREMENT = 14;
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
AUTO_INCREMENT = 16;
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
AUTO_INCREMENT = 14;
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
AUTO_INCREMENT = 26;
-- -------------------------------------------------------------


-- Dump data of "CustomerOrderTrackingTable" ---------------
-- ---------------------------------------------------------


-- Dump data of "customerstable" ---------------------------
BEGIN;

INSERT INTO `customerstable`(`customer_id`,`org_id`,`name`,`email`,`password`) VALUES 
( '10', '2', 'Vinoth', 'vinoth@gmail.com', NULL ),
( '11', '2', 'Praveen', 'praveen@gmail.com', NULL ),
( '12', '2', 'Vinoth Kumar', 'vinoth@gmail.com', NULL );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "FactoriesTable" ---------------------------
BEGIN;

INSERT INTO `FactoriesTable`(`factory_id`,`org_id`,`product_type_id`,`name`,`location`,`date_created`) VALUES 
( '19', '2', '1', 'Furniture Factory', 'India', '2025-04-27' ),
( '20', '2', '2', 'Steel Factory', 'India', '2025-04-27' ),
( '21', '2', '3', 'Electrical Appliances Factory', 'India', '2025-04-27' ),
( '22', '2', '1', 'Furniture Factory', 'India', '2025-04-28' ),
( '23', '2', '1', 'Furniture Factory', 'India', '2025-04-28' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "jobstable" --------------------------------
BEGIN;

INSERT INTO `jobstable`(`job_id`,`worker_id`,`machine_id`,`start_time`,`end_time`,`status`,`order_id`) VALUES 
( '149', '22', '11', '2025-04-27T23:14:13.606512', '2025-04-27T23:19:13.606512', 'COMPLETED', '93' ),
( '150', '20', '9', '2025-04-27T23:14:13.614339', '2025-04-27T23:22:13.614339', 'COMPLETED', '93' ),
( '151', '20', '9', '2025-04-28T07:52:16.270323', '2025-04-28T07:55:16.270405', 'COMPLETED', '94' ),
( '152', '21', '10', '2025-04-28T07:52:21.273787', '2025-04-28T07:55:21.273846', 'COMPLETED', '94' ),
( '153', '20', '9', '2025-04-28T07:55:16.402728', '2025-04-28T07:58:16.402756', 'COMPLETED', '95' ),
( '154', '21', '10', '2025-04-28T07:55:21.398768', '2025-04-28T07:58:21.398777', 'COMPLETED', '95' ),
( '155', '20', '9', '2025-04-28T07:58:16.531599', '2025-04-28T08:01:16.531661', 'COMPLETED', '96' ),
( '156', '22', '11', '2025-04-28T07:55:50.160446', '2025-04-28T07:58:50.160446', 'COMPLETED', '96' ),
( '157', '21', '10', '2025-04-28T07:58:21.529680', '2025-04-28T08:01:21.529737', 'COMPLETED', '97' ),
( '158', '23', '12', '2025-04-28T07:55:51.954443', '2025-04-28T07:58:51.954443', 'COMPLETED', '97' ),
( '159', '20', '9', '2025-04-28T08:01:34.339890', '2025-04-28T08:04:34.339890', 'COMPLETED', '98' ),
( '160', '22', '11', '2025-04-28T08:01:34.346939', '2025-04-28T08:04:34.346939', 'COMPLETED', '98' ),
( '161', '21', '10', '2025-04-28T08:01:34.983661', '2025-04-28T08:04:34.983661', 'COMPLETED', '99' ),
( '162', '23', '12', '2025-04-28T08:01:34.989585', '2025-04-28T08:04:34.989585', 'COMPLETED', '99' ),
( '163', '20', '9', '2025-04-28T09:54:18.339354', '2025-04-28T09:57:18.339375', 'COMPLETED', '100' ),
( '164', '22', '11', '2025-04-28T09:54:18.343644', '2025-04-28T09:57:18.343653', 'COMPLETED', '100' ),
( '165', '20', '9', '2025-04-28T10:26:58.197667', '2025-04-28T10:30:58.197667', 'COMPLETED', '101' ),
( '166', '22', '11', '2025-04-28T10:26:58.204427', '2025-04-28T10:28:58.204427', 'COMPLETED', '101' ),
( '169', '20', '9', '2025-04-28T10:44:20.475387', '2025-04-28T10:48:20.475387', 'COMPLETED', '103' ),
( '170', '21', '10', '2025-04-28T10:44:20.484785', '2025-04-28T10:47:20.484785', 'COMPLETED', '103' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "machinestable" ----------------------------
BEGIN;

INSERT INTO `machinestable`(`machine_id`,`factory_id`,`product_type_id`,`name`,`status`,`repair_cost`) VALUES 
( '9', '19', '1', 'Furniture Machine', 'FREE', '1000' ),
( '10', '19', '1', 'Furniture Machine - 2', 'FREE', '1000' ),
( '11', '20', '2', 'Steel Machine - 1', 'FREE', '1000' ),
( '12', '20', '2', 'Steel Machine - 2', 'FREE', '1000' ),
( '13', '20', '2', 'Steel Machine - 3', 'FREE', '1000' ),
( '14', '21', '3', 'E - Machine - 3', 'FREE', '1005' ),
( '15', '21', '3', 'E - Machine - 2', 'FREE', '1005' ),
( '16', '21', '3', 'E - Machine - 1', 'FREE', '1005' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "OrdersAndJobs" ----------------------------
BEGIN;

INSERT INTO `OrdersAndJobs`(`order_id`,`product_id`,`quantity`,`job_id`) VALUES 
( '93', '11', '5', '149' ),
( '93', '10', '8', '150' ),
( '94', '9', '3', '151' ),
( '94', '10', '3', '152' ),
( '95', '9', '3', '153' ),
( '95', '10', '3', '154' ),
( '96', '10', '3', '155' ),
( '96', '11', '3', '156' ),
( '97', '10', '3', '157' ),
( '97', '11', '3', '158' ),
( '98', '10', '3', '159' ),
( '98', '11', '3', '160' ),
( '99', '10', '3', '161' ),
( '99', '11', '3', '162' ),
( '100', '10', '3', '163' ),
( '100', '11', '3', '164' ),
( '101', '9', '4', '165' ),
( '101', '11', '2', '166' ),
( '102', '9', '4', '167' ),
( '102', '10', '3', '168' ),
( '103', '9', '4', '169' ),
( '103', '10', '3', '170' ),
( '104', '9', '32', '171' ),
( '105', '9', '32', '172' ),
( '107', '9', '4', '173' ),
( '108', '9', '4', '174' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "OrderStatus" ------------------------------
BEGIN;

INSERT INTO `OrderStatus`(`order_id`,`order_type`,`customer_or_vendor_id`,`status`) VALUES 
( '93', 'SALES', '10', 'COMPLETED' ),
( '94', 'SALES', '6', 'COMPLETED' ),
( '95', 'SALES', '6', 'COMPLETED' ),
( '96', 'SALES', '6', 'COMPLETED' ),
( '97', 'SALES', '6', 'COMPLETED' ),
( '98', 'SALES', '6', 'COMPLETED' ),
( '99', 'SALES', '6', 'COMPLETED' ),
( '100', 'SALES', '6', 'COMPLETED' ),
( '101', 'SALES', '10', 'COMPLETED' ),
( '102', 'PURCHASE', '12', 'RECEIVED' ),
( '103', 'SALES', '10', 'COMPLETED' ),
( '104', 'PURCHASE', '12', 'RECEIVED' ),
( '105', 'PURCHASE', '12', 'RECEIVED' ),
( '106', 'PURCHASE', '12', 'RECEIVED' ),
( '107', 'PURCHASE', '12', 'RECEIVED' ),
( '108', 'PURCHASE', '12', 'RECEIVED' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "productrawmaterialstable" -----------------
BEGIN;

INSERT INTO `productrawmaterialstable`(`product_id`,`raw_material_id`,`raw_material_quantity`) VALUES 
( '9', '10', '2' ),
( '9', '14', '3' ),
( '10', '10', '3' ),
( '10', '13', '2' ),
( '10', '14', '2' ),
( '11', '11', '2' ),
( '11', '14', '3' ),
( '12', '11', '7' ),
( '12', '14', '10' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "ProductsTable" ----------------------------
BEGIN;

INSERT INTO `ProductsTable`(`product_id`,`product_type_id`,`name`,`profit_percentage`,`production_time_in_mins`,`quantity_available`,`quantity_required`) VALUES 
( '9', '1', 'Chair', '16', '1', '15', '13' ),
( '10', '1', 'Table', '16', '1', '15', '13' ),
( '11', '2', 'STEEL CAN', '16', '1', '15', '13' ),
( '12', '2', 'STEEL BENCH', '15', '1', '25', '11' ),
( '13', '1', 'STEEL BENCH', '16', '9', '32', '43' );
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
( '9', 'Wire', '20', '12', '150' ),
( '10', 'Wood', '20', '10', '120' ),
( '11', 'Steel', '30', '15', '170' ),
( '12', 'Iron', '30', '15', '270' ),
( '13', 'Teak', '30', '15', '250' ),
( '14', 'Nails', '40', '15', '300' ),
( '15', 'Sticks', '40', '15', '250' );
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
( '12', '2', 'Prem Kumar', 'prem@gmail.com', NULL ),
( '13', '2', 'Praba', 'praba@gmail.com', NULL );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "WorkersTable" -----------------------------
BEGIN;

INSERT INTO `WorkersTable`(`worker_id`,`product_type_id`,`name`,`factory_id`,`status`) VALUES 
( '20', '1', 'Worker 1', '19', 'FREE' ),
( '21', '1', 'Worker 2', '19', 'FREE' ),
( '22', '2', 'Worker 3', '20', 'FREE' ),
( '23', '2', 'Worker 4', '20', 'FREE' ),
( '24', '3', 'Worker 5', '21', 'FREE' ),
( '25', '3', 'Worker 6', '21', 'FREE' ),
( '26', '1', 'worker 1', '19', 'FREE' );
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


