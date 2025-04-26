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
</center>

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

<div id="factory" class="factory">
    <center><h2>Manage Factories</h2></center>
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

<div id="worker" class="worker">
    <center><h2>Manage Workers</h2></center>
    <button type="button" onclick="closeWorkerOperations()" class="close-button"><i class="bi bi-x"></i> Close</button>
    <div id="add-worker">
        <form action="" method="post" id="add-worker-form">
            <h3>Add Worker</h3>
            Name : <input type="text" id="worker-name" name="worker-name" required><br>
            Product type Id :
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
