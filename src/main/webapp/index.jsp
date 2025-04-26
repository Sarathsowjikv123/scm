<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Management Dashboard</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<center>
    <h2>Production Planning and Supply Chain Management</h2>
    <h3>User Login</h3>
    <form action="/user/login" method="post" id="login-form">
        User Name: <input type="text" name="user-name" id="user-name" required><br>
        Password: <input type="password" name="pass-word" id="pass-word" required><br>
        <input type="submit" value="Login">
    </form>
    <form id="show-new-org-form">
        <input type="submit" value="New Org">
    </form>
    <!--<div id="insert-result"></div>-->
    <div id="new-org">
        <form action="/user/add" method="post" id="new-org-form">
            Org Name: <input type="text" name="org-name" id="org-name" required><br>
            Org Email: <input type="email" name="org-email" id="org-email" required><br>
            Org Password: <input type="password" name="org-pass-word" id="org-pass-word" required><br>
            Confirm Password: <input type="text" name="org-confirm-pass-word" id="org-confirm-pass-word" required><br>
            <input type="submit" value="Create New Org" id="new-org-submit-btn">
            <p id="new-org-msg"></p>
        </form>
    </div>
    <!--<div id="new-org-result"></div>-->
</center>
<script>
    document.getElementById("new-org").style.display = "none";
    document.getElementById("show-new-org-form").addEventListener("submit", showAddNewOrgForm);
    function showAddNewOrgForm(event) {
        event.preventDefault();
        document.getElementById("new-org").style.display = "block";
        document.getElementById("new-org-submit-btn").style.opacity = "0.5";
        document.getElementById("new-org-submit-btn").disabled = true;
        document.getElementById("new-org-msg").innerHTML = "Passwords Doesn't Match";
    }

    document.getElementById("org-confirm-pass-word").addEventListener("input", function(event){
        let pass = document.getElementById("org-pass-word").value;
        let confirmPass = document.getElementById("org-confirm-pass-word").value;
        if(pass === confirmPass) {
            document.getElementById("new-org-submit-btn").style.opacity = "1";
            document.getElementById("new-org-submit-btn").disabled = false;
            document.getElementById("new-org-msg").innerHTML = "Passwords Match";
        } else {
            document.getElementById("new-org-submit-btn").style.opacity = "0.5";
            document.getElementById("new-org-submit-btn").disabled = true;
            document.getElementById("new-org-msg").innerHTML = "Passwords Doesn't Match";
        }
    });

    document.getElementById("org-pass-word").addEventListener("input", function(event){
        let pass = document.getElementById("org-pass-word").value;
        let confirmPass = document.getElementById("org-confirm-pass-word").value;
        if(pass === confirmPass) {
            document.getElementById("new-org-submit-btn").style.opacity = "1";
            document.getElementById("new-org-submit-btn").disabled = false;
            document.getElementById("new-org-msg").innerHTML = "Passwords Match";
        } else {
            document.getElementById("new-org-submit-btn").style.opacity = "0.5";
            document.getElementById("new-org-submit-btn").disabled = true;
            document.getElementById("new-org-msg").innerHTML = "Passwords Doesn't Match";
        }
    });

    function removeAddNewOrgForm() {
        document.getElementById("new-org").style.display = "none";
    }

    document.getElementById("new-org-form").addEventListener("submit", addNewOrg);
    function addNewOrg(event) {
        event.preventDefault();

        const xhttp = new XMLHttpRequest();
        const url = "http://localhost:8080/user/add";

        const data = {
            name : document.getElementById("org-name").value,
            email : document.getElementById("org-email").value,
            password : document.getElementById("org-pass-word").value
        };

        xhttp.open("POST", url, true);
        xhttp.setRequestHeader("Content-Type", "application/json");

        xhttp.onload = function () {
            if (xhttp.status === 200) {
                const response = JSON.parse(xhttp.responseText);
                console.log(response);
                alert("New Org Created Successfully !!!. Login Again to Continue.")
                removeAddNewOrgForm();
            } else {
                console.error("Error:", xhttp.statusText);
            }
        };
        xhttp.send(JSON.stringify(data));
    }
</script>
</body>
</html>
