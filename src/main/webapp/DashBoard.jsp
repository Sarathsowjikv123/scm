<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<html>
<head>
    <title>Dashboard</title>
    <link rel="stylesheet" href="DashboardStyle.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
</head>
<body>
<%
if (session.getAttribute("user-name") == null || session.getAttribute("pass-word") == null || session.getAttribute("org-id") == null) {
response.sendRedirect("http://localhost:8080");
}
int orgId = 0;
String userName = (String) session.getAttribute("user-name");
String password = (String) session.getAttribute("pass-word");
if(session.getAttribute("org-id") != null){
    orgId = (int) session.getAttribute("org-id");
}
%>
<!-- Header -->
<center><h2>Production Planning and Supply Chain Management</h2></center>
<center><h3>DashBoard</h3></center>
<center><h3 id="welcome-msg"></h3></center>
<div class="top-right-buttons">
    <form action="/user/logout" method="get" id="login-form">
        <input type="submit" value="Logout" id="logout-btn">
    </form>
    <button type="button" onclick="showUpdateOrg()">Update Org</button>
    <form action="" method="delete" id="delete-org-form">
        <input type="hidden" id="d-org-id">
        <input type="submit" value="Delete Org">
    </form>
</div>

<center>
    <button type="button" onclick="showFactoryOperations()"><i class="bi bi-building"></i> Manage Factories</button>
    <button type="button" onclick="showWorkerOperations()"><i class="bi bi-person-badge"></i> Manage Workers</button>
    <button type="button" onclick="showCustomerAndVendorOperations()"><i class="bi bi-person-square"></i> Manage Customers And Vendors</button>
    <button type="button" onclick="showMachineOperations()"><i class="bi bi-gear"></i> Manage Machines</button>
    <button type="button" onclick="showRawMaterialOperations()"><i class="bi bi-layers"></i> Manage Raw Materials</button>
    <button type="button" onclick="showProductOperations()"><i class="bi bi-bag"></i> Manage Products</button><br><br>
    <button type="button" onclick="showOrderOperations()" id="manage-order-button"><i class="bi bi-diagram-3"></i> Manage Orders</button>
    <button type="button" onclick="showMaterialRequiredOperations()" id="manage-material-required-button"><i class="bi bi-file-earmark-spreadsheet"></i> Manage Raw Materials Requirements</button>
</center>

<!-- Org Forms -->
<div id="update-org" class="org">
    <form action="" method="put" id="update-org-form">
        <h3>Update Org</h3>
        <input type="hidden" id="u-org-u-id">
        Name : <input type="text" id="u-org-name" name="u-org-name" required><br>
        E-mail : <input type="email" id="u-org-email" name="u-org-email" required><br>
        New Password : <input type="password" id="u-org-password" name="u-org-password" required><br>
        Confirm New Password : <input type="password" id="u-org-confirm-pass-word" name="u-org-password" required><br>
        <p id="u-org-update"></p><br>
        <input type="submit" id="u-org-submit-btn">
    </form>
</div>

<!-- Factory Forms -->
<div id="factory" class="factory">
    <center><h2>Manage Factories</h2></center>
    <!--<center>
    <button type="button" onclick="showWorkerOperations()"><i class="bi bi-person-badge"></i> Manage Workers</button>
    <button type="button" onclick="showMachineOperations()"><i class="bi bi-gear"></i> Manage Machines</button>
    <button type="button" onclick="showRawMaterialOperations()"><i class="bi bi-layers"></i> Manage Raw Materials</button>
    </center>-->
    <button type="button" onclick="closeFactoryOperations()" class="close-button"><i class="bi bi-x"></i> Close</button>
    <div id="add-factory">
        <form action="/factory/" method="post" id="add-factory-form">
            <h3>Add New Factory</h3>
            <input type="hidden" id="org-id">
            Name : <input type="text" id="factory-name" name="factory-name" required><br>
            Location :
            <select name="factory-location" id="factory-location" required>
                <option value="India">India</option>
                <option value="Australia">Australia</option>
            </select><br>
            Factory Type :
            <select name="factory-type" id="factory-type" required>
            </select><br>
            <input type="submit">
        </form>
    </div>
    <div id="update-factory">
        <form action="" method="put" id="update-factory-form">
            <h3>Update Factory</h3>
            <input type="hidden" id="u-org-id">
            Factory Id : <input type="number" id="u-factory-id" name="factory-id" required><br>
            Name : <input type="text" id="u-factory-name" name="factory-name" required><br>
            Location :
            <select name="factory-type" id="u-factory-location" required>
                <option value="India">India</option>
                <option value="Australia">Australia</option>
            </select><br>
            Factory Type :
            <select name="factory-type" id="u-factory-type" required>
            </select><br>
            <input type="submit">
        </form>
    </div>
    <div id="delete-factory">
        <form action="" method="delete" id="delete-factory-form">
            <h3>Delete Factory</h3>
            Factory Id : <input type="number" id="d-factory-id" name="factory-id" required><br>
            <input type="submit">
        </form>
    </div>
    <div id="get-factory">
        <form action="" method="get" id="get-factory-form">
            <h3>Get Factory</h3>
            Factory Id : <input type="number" id="g-factory-id" name="factory-id" required><br>
            <input type="submit">
            <p id="g-new-factory-get"></p>
        </form>
        <table id="factory-table">
            <thead>
                <tr>
                    <td>Factory Id</td>
                    <td>Org Id</td>
                    <td>Factory Name</td>
                    <td>Factory Location</td>
                    <td>Org Name</td>
                    <td>Factory Type</td>
                    <td>Date Created</td>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <div id="get-factory-all">
        <form action="" method="get" id="get-factory-form-all">
            <h3>Get Factory All</h3>
            <input type="submit">
            <p id="g-new-factory-get-all"></p>
        </form>
        <table id="factory-table-all">
            <thead>
            <tr>
                <td>Factory Id</td>
                <td>Org Id</td>
                <td>Factory Name</td>
                <td>Factory Location</td>
                <td>Org Name</td>
                <td>Factory Type</td>
                <td>Date Created</td>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>

<!-- Worker Forms -->
<div id="worker" class="worker">
    <center><h2>Manage Workers</h2></center>
    <button type="button" onclick="closeWorkerOperations()" class="close-button"><i class="bi bi-x"></i> Close</button>
    <div id="add-worker">
        <form action="" method="post" id="add-worker-form">
            <h3>Add Worker</h3>
            Name : <input type="text" id="worker-name" name="worker-name" required><br>
            Worker type Id :
            <select id="worker-type-id" name="worker-type-id" required>
            </select><br>
            Factory Id :
            <select id="worker-factory-id" name="worker-factory-id" required>
            </select><br>
            <input type="submit" id="add-worker-submit-btn">
        </form>
    </div>
    <div id="update-worker">
        <form action="" method="put" id="update-worker-form">
            <h3>Update Worker</h3>
            Worker Id :
            <input type="text" id="u-worker-id" name="u-worker-id" required><br>
            Name : <input type="text" id="u-worker-name" name="u-worker-name" required><br>
            Product type Id :
            <select id="u-worker-type-id" name="u-worker-type-id" required>
            </select><br>
            Factory Id :
            <select id="u-worker-factory-id" name="u-worker-factory-id" required>
            </select><br>
            <input type="submit" id="u-worker-submit-btn">
        </form>
    </div>
    <div id="delete-worker">
        <form action="" method="delete" id="delete-worker-form">
            <h3>Delete Worker</h3>
            <input type="text" id="d-worker-id" required>
            <input type="submit" id="d-worker-submit-btn">
        </form>
    </div>
    <div id="get-worker">
        <form action="" method="get" id="get-worker-form">
            <h3>Get Worker</h3>
            <input type="text" id="g-worker-id" required>
            <input type="submit" id="g-worker-submit-btn">
        </form>
        <table id="worker-table">
            <thead>
            <tr>
                <td>Worker Id</td>
                <td>Worker Type</td>
                <td>Worker Name</td>
                <td>Factory Id</td>
                <td>Factory Name</td>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <div id="get-worker-all">
        <form action="" method="get" id="get-worker-all-form">
            <h3>Get All Workers</h3>
            <input type="submit" id="g-worker-all-submit-btn">
        </form>
        <table id="worker-all-table">
            <thead>
            <tr>
                <td>Worker Id</td>
                <td>Worker Type</td>
                <td>Worker Name</td>
                <td>Factory Id</td>
                <td>Factory Name</td>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>

<!-- Customer and Vendor Forms -->
<div id="customer-and-vendor" class="customer-and-vendor">
    <center><h2>Manage Customers And Vendors</h2></center>
    <button type="button" onclick="closeCustomerAndVendorOperations()" class="close-button"><i class="bi bi-x"></i> Close</button>
    <div id="add-customer-and-vendor">
        <form action="" method="post" id="add-customer-and-vendor-form">
            <h3>Add Customer And Vendor</h3>
            Name : <input type="text" id="customer-and-vendor-name" name="customer-and-vendor-name" required><br>
            Email : <input type="text" id="customer-and-vendor-email" name="customer-and-vendor-email" required><br>
            Customer Or Vendor :
            <select id="customer-or-vendor" name="customer-or-vendor" required>
                <option value="1">Customer</option>
                <option value="2">Vendor</option>
            </select><br>
            <input type="hidden" id="customer-and-vendor-org_id">
            <input type="submit" id="add-customer-and-vendor-submit-btn">
        </form>
    </div>
    <div id="update-customer-and-vendor">
        <form action="" method="post" id="update-customer-and-vendor-form">
            <h3>Update Customer And Vendor</h3>
            ID : <input type="text" id="u-customer-and-vendor-id" required>
            Name : <input type="text" id="u-customer-and-vendor-name" name="u-customer-and-vendor-name" required><br>
            Email : <input type="text" id="u-customer-and-vendor-email" name="u-customer-and-vendor-email" required><br>
            Customer Or Vendor :
            <select id="u-customer-or-vendor" name="u-customer-or-vendor" required>
                <option value="1">Customer</option>
                <option value="2">Vendor</option>
            </select><br>
            <input type="hidden" id="u-customer-and-vendor-org_id">
            <input type="submit" id="u-customer-and-vendor-submit-btn">
        </form>
    </div>
    <div id="delete-customer-and-vendor">
        <form action="" method="delete" id="delete-customer-and-vendor-form">
            <h3>Delete Customer And Vendor</h3>
            ID : <input type="text" id="d-customer-and-vendor-id" required>
            Customer Or Vendor :
            <select id="d-customer-or-vendor" name="d-customer-or-vendor" required>
                <option value="1">Customer</option>
                <option value="2">Vendor</option>
            </select><br>
            <input type="submit" id="d-customer-and-vendor-submit-btn">
        </form>
    </div>

    <div id="get-customer-all">
        <form action="" method="get" id="get-customer-all-form">
            <h3>Get All Customers</h3>
            <input type="submit" id="g-customer-all-submit-btn">
        </form>
        <table id="customer-all-table">
            <thead>
            <tr>
                <td>Customer Id</td>
                <td>Name</td>
                <td>Org Id</td>
                <td>Org Name</td>
                <td>Email</td>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>

    <div id="get-vendor-all">
        <form action="" method="get" id="get-vendor-all-form">
            <h3>Get All Vendors</h3>
            <input type="submit" id="g-vendor-all-submit-btn">
        </form>
        <table id="vendor-all-table">
            <thead>
            <tr>
                <td>Vendor Id</td>
                <td>Name</td>
                <td>Org Id</td>
                <td>Org Name</td>
                <td>Email</td>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>

    <div id="get-customer">
        <form action="" method="get" id="get-customer-form">
            <h3>Get Customer</h3>
            <input type="text" id="g-customer-id" required>
            <input type="submit" id="g-customer-submit-btn">
        </form>
        <table id="customer-table">
            <thead>
            <tr>
                <td>Customer Id</td>
                <td>Name</td>
                <td>Org Id</td>
                <td>Org Name</td>
                <td>Email</td>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>

    <div id="get-vendor">
        <form action="" method="get" id="get-vendor-form">
            <h3>Get Vendor</h3>
            <input type="text" id="g-vendor-id" required>
            <input type="submit" id="g-vendor-submit-btn">
        </form>
        <table id="vendor-table">
            <thead>
            <tr>
                <td>Vendor Id</td>
                <td>Name</td>
                <td>Org Id</td>
                <td>Org Name</td>
                <td>Email</td>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>

<!-- Machine Forms -->
<div id="machine" class="machine">
    <center><h2>Manage Machines</h2></center>
    <button type="button" onclick="closeMachineOperations()" class="close-button"><i class="bi bi-x"></i> Close</button>
    <div id="add-machine">
        <form action="" method="post" id="add-machine-form">
            <h3>Add Machine</h3>
            Machine Name : <input type="text" id="machine-name" name="machine-name" required><br>
            Machine type Id :
            <select id="machine-type-id" name="machine-type-id" required>
            </select><br>
            Factory Id :
            <select id="machine-factory-id" name="machine-factory-id" required>
            </select><br>
            Repair Cost : <input type="number" name="machine-repair-cost" id="machine-repair-cost"><br>
            <input type="submit" id="add-machine-submit-btn">
        </form>
    </div>
    <div id="update-machine">
        <form action="" method="put" id="update-machine-form">
            <h3>Update Machine</h3>
            Machine Id :
            <input type="text" id="u-machine-id" name="u-machine-id" required><br>
            Machine Name : <input type="text" id="u-machine-name" name="u-machine-name" required><br>
            Product type Id :
            <select id="u-machine-type-id" name="u-machine-type-id" required>
            </select><br>
            Factory Id :
            <select id="u-machine-factory-id" name="u-machine-factory-id" required>
            </select><br>
            Repair Cost : <input type="number" name="u-machine-repair-cost"  id="u-machine-repair-cost"><br>
            <input type="submit" id="u-machine-submit-btn">
        </form>
    </div>
    <div id="delete-machine">
        <form action="" method="delete" id="delete-machine-form">
            <h3>Delete Machine</h3>
            <input type="number" id="d-machine-id" required>
            <input type="submit" id="d-machine-submit-btn">
        </form>
    </div>
    <div id="get-machine">
        <form action="" method="get" id="get-machine-form">
            <h3>Get Machine</h3>
            <input type="text" id="g-machine-id" required>
            <input type="submit" id="g-machine-submit-btn">
        </form>
        <table id="machine-table">
            <thead>
            <tr>
                <td>Machine Id</td>
                <td>Machine Type</td>
                <td>Machine Name</td>
                <td>Machine Status</td>
                <td>Factory Id</td>
                <td>Factory Name</td>
                <td>Repair Cost</td>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <div id="get-machine-all">
        <form action="" method="get" id="get-machine-all-form">
            <h3>Get All Machines</h3>
            <input type="submit" id="g-machine-all-submit-btn">
        </form>
        <table id="machine-all-table">
            <thead>
            <tr>
                <td>Machine Id</td>
                <td>Machine Type</td>
                <td>Machine Name</td>
                <td>Machine Status</td>
                <td>Factory Id</td>
                <td>Factory Name</td>
                <td>Repair Cost</td>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>

<!-- RawMaterial Forms -->
<div id="raw-material" class="raw-material">
    <center><h2>Manage RawMaterials</h2></center>
    <button type="button" onclick="closeRawMaterialOperations()" class="close-button"><i class="bi bi-x"></i> Close</button>
    <div id="add-raw-material">
        <form action="" method="post" id="add-raw-material-form">
            <h3>Add RawMaterial</h3>
            RawMaterial Name : <input type="text" id="raw-material-name" name="raw-material-name" required><br>
            Initial Quantity Available : <input type="number" name="raw-material-initial-quantity-available" id="raw-material-initial-quantity-available"><br>
            Initial Quantity Required : <input type="number" name="raw-material-initial-quantity-required" id="raw-material-initial-quantity-required"><br>
            Cost of Raw Material : <input type="number" name="raw-material-cost" id="raw-material-cost"><br>
            <input type="submit" id="add-raw-material-submit-btn">
        </form>
    </div>
    <div id="update-raw-material">
        <form action="" method="put" id="update-raw-material-form">
            <h3>Update RawMaterial</h3>
            RawMaterial Id :
            <input type="text" id="u-raw-material-id" name="u-raw-material-id" required><br>
            RawMaterial Name : <input type="text" id="u-raw-material-name" name="u-raw-material-name" required><br>
            New Quantity Available : <input type="number" name="u-raw-material-initial-quantity-available" id="u-raw-material-initial-quantity-available"><br>
            New Quantity Required : <input type="number" name="u-raw-material-initial-quantity-required" id="u-raw-material-initial-quantity-required"><br>
            Cost of Raw Material : <input type="number" name="raw-material-cost" id="u-raw-material-cost"><br>
            <input type="submit" id="u-raw-material-submit-btn">
        </form>
    </div>
    <div id="delete-raw-material">
        <form action="" method="delete" id="delete-raw-material-form">
            <h3>Delete RawMaterial</h3>
            <input type="number" id="d-raw-material-id" required>
            <input type="submit" id="d-raw-material-submit-btn">
        </form>
    </div>
    <div id="get-raw-material">
        <form action="" method="get" id="get-raw-material-form">
            <h3>Get RawMaterial</h3>
            <input type="text" id="g-raw-material-id" required>
            <input type="submit" id="g-raw-material-submit-btn">
        </form>
        <table id="raw-material-table">
            <thead>
            <tr>
                <td>RawMaterial Id</td>
                <td>RawMaterial Name</td>
                <td>Quantity Available</td>
                <!--<td>Quantity Required</td>-->
                <td>Cost</td>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <div id="get-raw-material-all">
        <form action="" method="get" id="get-raw-material-all-form">
            <h3>Get All RawMaterials</h3>
            <input type="submit" id="g-raw-material-all-submit-btn">
        </form>
        <table id="raw-material-all-table">
            <thead>
            <tr>
                <td>RawMaterial Id</td>
                <td>RawMaterial Name</td>
                <td>Quantity Available</td>
                <!--<td>Quantity Required</td>-->
                <td>Cost</td>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>

<!-- Product Forms -->
<div id="product" class="product">
    <center><h2>Manage Products</h2></center>
    <button type="button" onclick="closeProductOperations()" class="close-button"><i class="bi bi-x"></i> Close</button>
    <div id="add-product">
        <form action="" method="post" id="add-product-form">
            <h3>Add Product</h3>
            Name : <input type="text" id="product-name" name="product-name" required><br>
            Product type Id :
            <select id="product-type-id" name="product-type-id" required>
            </select><br>
            Initial Quantity Available : <input type="number" id="product-quantity-available" name="product-quantity-available">
            Initial Quantity Required : <input type="number" id="product-quantity-required" name="product-quantity-required">
            Production Time in Minutes : <input type="number" id="production-time-in-mins" name="production-time-in-mins">
            Profit Percentage : <input type="number" id="profit-percentage" name="profit-percentage">
            <input type="submit" id="add-product-submit-btn">
        </form>
    </div>
    <div id="update-product">
        <form action="" method="put" id="update-product-form">
            <h3>Update Product</h3>
            Product Id : <input type="number" id="u-product-id" name="u-profit-id">
            Name : <input type="text" id="u-product-name" name="u-product-name" required><br>
            Product type Id :
            <select id="u-product-type-id" name="u-product-type-id" required>
            </select><br>
            New Quantity Available : <input type="number" id="u-product-quantity-available" name="u-product-quantity-available">
            New Quantity Required : <input type="number" id="u-product-quantity-required" name="u-product-quantity-required">
            Production Time in Minutes : <input type="number" id="u-production-time-in-mins" name="u-production-time-in-mins">
            Profit Percentage : <input type="number" id="u-profit-percentage" name="u-profit-percentage">
            <input type="submit" id="u-product-submit-btn">
        </form>
    </div>
    <div id="delete-product">
        <form action="" method="delete" id="delete-product-form">
            <h3>Delete Product</h3>
            <input type="text" id="d-product-id" required>
            <input type="submit" id="d-product-submit-btn">
        </form>
    </div>
    <div id="get-product">
        <form action="" method="get" id="get-product-form">
            <h3>Get Product</h3>
            <input type="text" id="g-product-id" required>
            <input type="submit" id="g-product-submit-btn">
        </form>
        <table id="product-table">
            <thead>
            <tr>
                <td>Product Id</td>
                <td>Product Name</td>
                <td>Product Type</td>
                <td>Quantity Available</td>
                <!--<td>Quantity Required</td>-->
                <td>Cost Price</td>
                <td>Selling Price</td>
                <td>Production Time in Minutes</td>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <div id="get-product-all">
        <form action="" method="get" id="get-product-all-form">
            <h3>Get All Products</h3>
            <input type="submit" id="g-product-all-submit-btn">
        </form>
        <table id="product-all-table">
            <thead>
            <tr>
                <td>Product Id</td>
                <td>Product Name</td>
                <td>Product Type</td>
                <td>Quantity Available</td>
                <!--<td>Quantity Required</td>-->
                <td>Cost Price</td>
                <td>Selling Price</td>
                <td>Production Time in Minutes</td>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>

<!-- Order Forms -->
<div id="order" class="order">
    <center><h2>Manage Orders</h2></center>
    <button type="button" onclick="closeOrderOperations()" class="close-button"><i class="bi bi-x"></i> Close</button>
    <div id="add-order">
        <form action="" method="post" id="add-order-form">
            <h3>Add Order</h3>
            Order Type :
            <select id="order-type" name="order-type" required>
                <option value="--SELECT ORDER TYPE--">--SELECT ORDER TYPE--</option>
                <option value="SALES">SALES</option>
                <option value="PURCHASE">PURCHASE</option>
            </select><br>
            <div id="order-customer-id-div">
                Customer Id :
                <select type="number" id="order-customer-id" name="order-customer-id">
                </select><br>
            </div>
            <div id="order-vendor-id-div">
                Vendor Id :
                <select type="number" id="order-vendor-id" name="order-vendor-id">
                </select><br>
            </div>
            <h4>Select Product</h4>
            <select id="productSelect">
                <option value="">-- Select a Product --</option>
            </select>
            <button type="button" onclick="addproduct()">Add Product</button><br><br>
            <h4>Selected Products</h4><br>
            <div id="selectedProductsContainer">
            </div>
            <input type="submit" id="add-order-submit-btn">
        </form>
    </div>
    <div id="delete-order">
        <form action="" method="delete" id="delete-order-form">
            <h3>Delete Order</h3>
            <input type="text" id="d-order-id" required>
            <input type="submit" id="d-order-submit-btn">
        </form>
    </div>
    <div id="get-order">
        <form action="" method="get" id="get-order-form">
            <h3>Get Order</h3>
            <input type="text" id="g-order-id" required>
            <input type="submit" id="g-order-submit-btn">
        </form>
        <table id="order-table">
            <thead>
            <tr>
                <td>Order Id</td>
                <td>Product Id</td>
                <td>Product</td>
                <td>Quantity</td>
                <td>Worker Id</td>
                <td>Worker name</td>
                <td>Machine Id</td>
                <td>Machine Name</td>
                <td>Start Time</td>
                <td>End Time</td>
                <td>Status</td>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <div id="get-order-all">
        <form action="" method="get" id="get-order-all-form">
            <h3>Get All Orders</h3>
            <input type="submit" id="g-order-all-submit-btn">
        </form>
        <table id="order-all-table">
            <thead>
            <tr>
                <td>Order Id</td>
                <td>Product Id</td>
                <td>Product</td>
                <td>Quantity</td>
                <td>Worker Id</td>
                <td>Worker name</td>
                <td>Machine Id</td>
                <td>Machine Name</td>
                <td>Start Time</td>
                <td>End Time</td>
                <td>Status</td>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>

    <div id="update-tracking">
        <form action="" method="put" id="update-tracking-form">
            <h3>UPDATE ORDER STATUS</h3>
            Sales Order Id :
            <input type="number" id="u-tracking-id" name="u-tracking-id" required><br>
            Status :
            <select id="u-tracking-status">
                <option value="SHIPPED">SHIPPED</option>
                <option value="IN TRANSIT">IN TRANSIT</option>
                <option value="DELIVERED">DELIVERED</option>
            </select>
            <input type="submit" id="u-tracking-submit-btn">
        </form>
    </div>

    <div id="update-po">
        <form action="" method="put" id="update-po-form">
            <h3>Mark Purchase Order as Received</h3>
            Purchase Order Id :
            <input type="number" id="u-po-id" name="u-po-id" required><br>
            <input type="submit" id="u-po-submit-btn">
        </form>
    </div>

    <div id="get-po-all">
        <form action="" method="get" id="get-po-all-form">
            <h3>Get All Purchase Orders</h3>
            <input type="submit" id="g-po-all-submit-btn">
        </form>
        <table id="po-all-table">
            <thead>
            <tr>
                <td>Order Id</td>
                <td>Vendor Id</td>
                <td>Order Type</td>
                <td>Status</td>
                <td>Ordered Date</td>
                <td>Completed Date</td>
                <td>Product Id</td>
                <td>Product Name</td>
                <td>Quantity</td>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <div id="get-po">
        <form action="" method="get" id="get-po-form">
            <h3>Get Purchase Order</h3>
            <input type="text" id="g-po-id" required>
            <input type="submit" id="g-po-submit-btn">
        </form>
        <table id="po-table">
            <thead>
            <tr>
                <td>Order Id</td>
                <td>Vendor Id</td>
                <td>Order Type</td>
                <td>Status</td>
                <td>Ordered Date</td>
                <td>Completed Date</td>
                <td>Product Id</td>
                <td>Product Name</td>
                <td>Quantity</td>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>

<div id="material-required" class="material-required">
    <center><h2>Manage materialRequired</h2></center>
    <button type="button" onclick="closeMaterialRequiredOperations()" class="close-button"><i class="bi bi-x"></i> Close</button>
    <div id="add-material-required">
        <form action="" method="post" id="add-material-required-form">
            <h3>Add materialRequired</h3>
            Product Id :
            <select id="material-required-product-id" name="material-required-product-id" required>
            </select><br>
            <h4>Select Raw Materials</h4>
            <select id="rawMaterialSelect">
                <option value="">-- Select a Raw Material --</option>
            </select>
            <button type="button" onclick="addMaterialR()">Add Raw Material</button><br><br>
            <h4>Selected Raw Material</h4><br>
            <div id="selectedRawMaterialsContainer">
            </div>
            <input type="submit" id="add-material-required-submit-btn">
        </form>
    </div>

    <div id="delete-material-required">
        <form action="" method="post" id="delete-material-required-form">
            <h3>Delete materialRequired</h3>
            Product Id :
            <select id="d-material-required-product-id" name="material-required-product-id" required></select><br>
            <input type="submit" id="delete-material-required-submit-btn">
        </form>
    </div>

    <div id="get-bom">
        <form action="" method="get" id="get-bom-form">
            <h3>Get Bill Of Material</h3>
            <select id="g-bom-id"></select><br>
            <input type="submit" id="g-bom-submit-btn">
        </form>
        <table id="bom-table">
            <thead>
            <tr>
                <td>Raw Material Id</td>
                <td>Raw Material</td>
                <td>Quantity</td>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>

<script>
    let userName = "<%= userName %>";
    document.getElementById("welcome-msg").innerText = "Welcome, " + userName + "!";

    let orgId = "<%= orgId %>";
    document.getElementById("org-id").value = orgId;
    document.getElementById("u-org-id").value = orgId;
    document.getElementById("u-org-u-id").value = orgId;
    document.getElementById("d-org-id").value = orgId;
    document.getElementById("customer-and-vendor-org_id").value = orgId;
    document.getElementById("u-customer-and-vendor-org_id").value = orgId;
    document.getElementById("d-customer-and-vendor-org_id").value = orgId;

    document.getElementById("update-org").style.display="none";
    function showUpdateOrg() {
        document.getElementById("update-org").style.display="block";
        document.getElementById("u-org-update").innerHTML = "Passwords Doesn't Match";
    }

    document.getElementById("u-org-confirm-pass-word").addEventListener("input", function(event){
        let pass = document.getElementById("u-org-password").value;
        let confirmPass = document.getElementById("u-org-confirm-pass-word").value;
        if(pass === confirmPass) {
            document.getElementById("u-org-submit-btn").style.opacity = "1";
            document.getElementById("u-org-submit-btn").disabled = false;
            document.getElementById("u-org-update").innerHTML = "Passwords Match";
        } else {
            document.getElementById("u-org-submit-btn").style.opacity = "0.5";
            document.getElementById("u-org-submit-btn").disabled = true;
            document.getElementById("u-org-update").innerHTML = "Passwords Doesn't Match";
        }
    });

    document.getElementById("u-org-password").addEventListener("input", function(event){
        let pass = document.getElementById("u-org-password").value;
        let confirmPass = document.getElementById("u-org-confirm-pass-word").value;
        if(pass === confirmPass) {
            document.getElementById("u-org-submit-btn").style.opacity = "1";
            document.getElementById("u-org-submit-btn").disabled = false;
            document.getElementById("u-org-update").innerHTML = "Passwords Match";
        } else {
            document.getElementById("u-org-submit-btn").style.opacity = "0.5";
            document.getElementById("u-org-submit-btn").disabled = true;
            document.getElementById("u-org-update").innerHTML = "Passwords Doesn't Match";
        }
    });
</script>
<script src="DashboardScript.js"></script>
</body>
</html>
