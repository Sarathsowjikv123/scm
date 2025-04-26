document.addEventListener("DOMContentLoaded", function () {

    document.getElementById("factory").style.display="none";

    document.getElementById("worker").style.display="none";

    document.getElementById("customer-and-vendor").style.display="none";

    document.getElementById("add-factory-form").addEventListener("submit", addFactory);
    document.getElementById("update-factory-form").addEventListener("submit", updateFactory);
    document.getElementById("delete-factory-form").addEventListener("submit", deleteFactory);
    document.getElementById("get-factory-form").addEventListener("submit", getFactory);
    document.getElementById("get-factory-form-all").addEventListener("submit", getFactoryAll);

    document.getElementById("update-org-form").addEventListener("submit", updateOrgInfo);
    document.getElementById("delete-org-form").addEventListener("submit", deleteOrgInfo);

    document.getElementById("add-worker-form").addEventListener("submit", addWorker);
    document.getElementById("update-worker-form").addEventListener("submit", updateWorker);
    document.getElementById("delete-worker-form").addEventListener("submit", deleteWorker);
    document.getElementById("get-worker-form").addEventListener("submit", getWorker);
    document.getElementById("get-worker-all-form").addEventListener("submit", getAllWorkers);

    document.getElementById("add-worker-form").addEventListener("submit", addWorker);
    document.getElementById("update-worker-form").addEventListener("submit", updateWorker);
    document.getElementById("delete-worker-form").addEventListener("submit", deleteWorker);
    document.getElementById("get-worker-form").addEventListener("submit", getWorker);
    document.getElementById("get-worker-all-form").addEventListener("submit", getAllWorkers);


    document.getElementById("add-customer-and-vendor-form").addEventListener("submit", addCustomerAndVendor);
    document.getElementById("update-customer-and-vendor-form").addEventListener("submit", updateCustomerAndVendor);
    document.getElementById("delete-customer-and-vendor-form").addEventListener("submit", deleteCustomerAndVendor);
    document.getElementById("get-customer-all-form").addEventListener("submit", getAllCustomer);
    document.getElementById("get-vendor-all-form").addEventListener("submit", getAllVendor);
    document.getElementById("get-customer-form").addEventListener("submit", getCustomer);
    document.getElementById("get-vendor-form").addEventListener("submit", getVendor);


    document.getElementById("factory-table").style.display="none";
    document.getElementById("factory-table-all").style.display="none";

    document.getElementById("worker-all-table").style.display="none";
    document.getElementById("worker-table").style.display="none";

    document.getElementById("customer-table").style.display="none";
    document.getElementById("customer-all-table").style.display="none";
    document.getElementById("vendor-table").style.display="none";
    document.getElementById("vendor-all-table").style.display="none";
});

//-------------*************----------------
//MANAGE CUSTOMERS AND VENDORS
//-------------*************----------------
function addCustomerAndVendor(event) {
    console.log("addCustomerAndVendor Called.")
    event.preventDefault();
    const url = "http://localhost:8080/customer_and_vendor/";
    const data = {
        org_id : document.getElementById("customer-and-vendor-org_id").value,
        name :document.getElementById("customer-and-vendor-name").value,
        email : document.getElementById("customer-and-vendor-email").value,
        customerorvendor : document.getElementById("customer-or-vendor").value
    };
    sendPOSTRequest(url, data, function(response) {
        console.log("Response from server:", response);
        for (let resp in response) {
            alert(resp + " : " + response[resp]);
        }
    });
}

function updateCustomerAndVendor(event) {
    console.log("UpdateCustomerAndVendor Called.")
    event.preventDefault();
    const ID = document.getElementById("u-customer-and-vendor-id").value;
    const cOrV = document.getElementById("u-customer-or-vendor").value;
    let url = "";
    if(cOrV == 1) {
        url = "http://localhost:8080/customer_and_vendor/customers/"+ID;
    } else {
        url = "http://localhost:8080/customer_and_vendor/vendors/"+ID;
    }
    const data = {
        name : document.getElementById("u-customer-and-vendor-name").value,
        email : document.getElementById("u-customer-and-vendor-email").value,
    };
    console.log(url)
    console.log(data)
    sendPUTRequest(url, data, function(response) {
        console.log("Response from server:", response);
        for (let resp in response) {
            alert(resp + " : " + response[resp]);
        }
    });
}

function deleteCustomerAndVendor(event) {
    console.log("deleteWorker Called.")
    event.preventDefault();
    const ID = document.getElementById("d-customer-and-vendor-id").value;
    const cOrV = document.getElementById("d-customer-or-vendor").value;
    let url = "";
    if(cOrV == 1) {
        url = "http://localhost:8080/customer_and_vendor/customers/"+ID;
    } else {
        url = "http://localhost:8080/customer_and_vendor/vendors/"+ID;
    }
    console.log(url)
    sendDELETERequest(url, function(response) {
        console.log("Response from server:", response);
        for (let resp in response) {
            alert(resp + " : " + response[resp]);
        }
    });
}

function getAllCustomer(event) {
    event.preventDefault();
    const url = "http://localhost:8080/customer_and_vendor/customers"
    console.log("get all cust called");
    sendGETRequest(url, function(response) {
        document.getElementById("customer-all-table").style.display="none";
        document.getElementById("customer-all-table").style.display="block";
        const tableBody = document.querySelector("#customer-all-table tbody");
        tableBody.innerHTML = "";
        response.forEach(cOrv => {
            const row = document.createElement("tr");
            row.innerHTML = `
                <td>${cOrv.customer_or_vendor_id}</td>
                <td>${cOrv.name}</td>
                <td>${cOrv.org_id}</td>
                <td>${cOrv.org_name}</td>
                <td>${cOrv.email}</td>
            `;
            tableBody.appendChild(row);
        });
    });
}

function getAllVendor(event) {
    event.preventDefault();
    const url = "http://localhost:8080/customer_and_vendor/vendors"
    console.log("get all vend called");
    sendGETRequest(url, function(response) {
        document.getElementById("vendor-all-table").style.display="none";
        document.getElementById("vendor-all-table").style.display="block";
        const tableBody = document.querySelector("#vendor-all-table tbody");
        tableBody.innerHTML = "";
        response.forEach(cOrv => {
            const row = document.createElement("tr");
            row.innerHTML = `
                <td>${cOrv.customer_or_vendor_id}</td>
                <td>${cOrv.name}</td>
                <td>${cOrv.org_id}</td>
                <td>${cOrv.org_name}</td>
                <td>${cOrv.email}</td>
            `;
            tableBody.appendChild(row);
        });
    });
}

function getCustomer(event) {
    event.preventDefault();
    const url = "http://localhost:8080/customer_and_vendor/customers/"+document.getElementById("g-customer-id").value;
    sendGETRequest(url, function(response) {
        console.log(response);

        if(response === null) {
            alert("No Customer found for the given factory ID")
        } else {
            document.getElementById("customer-table").style.display="none";
            document.getElementById("customer-table").style.display="block";
            const tableBody = document.querySelector("#customer-table tbody");
            tableBody.innerHTML = "";
            const row = document.createElement("tr");
            row.innerHTML = `
                <td>${response.customer_or_vendor_id}</td>
                <td>${response.name}</td>
                <td>${response.org_id}</td>
                <td>${response.org_name}</td>
                <td>${response.email}</td>
            `;
            tableBody.appendChild(row);
        }
    });
}

function getVendor(event) {
    event.preventDefault();
    const url = "http://localhost:8080/customer_and_vendor/vendors/"+document.getElementById("g-vendor-id").value;
    sendGETRequest(url, function(response) {
        console.log(response);

        if(response === null) {
            alert("No Vendor found for the given factory ID")
        } else {
            document.getElementById("vendor-table").style.display="none";
            document.getElementById("vendor-table").style.display="block";
            const tableBody = document.querySelector("#vendor-table tbody");
            tableBody.innerHTML = "";
            const row = document.createElement("tr");
            row.innerHTML = `
                <td>${response.customer_or_vendor_id}</td>
                <td>${response.name}</td>
                <td>${response.org_id}</td>
                <td>${response.org_name}</td>
                <td>${response.email}</td>
            `;
            tableBody.appendChild(row);
        }
    });
}

//-------------*************----------------
//MANAGE WORKERS
//-------------*************----------------
function addWorker(event) {
    console.log("addWorker Called.")
    event.preventDefault();
    const url = "http://localhost:8080/worker/";
    const data = {
        factory_id : document.getElementById("worker-factory-id").value,
        product_type_id :document.getElementById("worker-type-id").value,
        name : document.getElementById("worker-name").value
    };
    sendPOSTRequest(url, data, function(response) {
        console.log("Response from server:", response);
        for (let resp in response) {
            alert(resp + " : " + response[resp]);
        }
    });
}

function updateWorker(event) {
    console.log("UpdateWorker Called.")
    event.preventDefault();
    const url = "http://localhost:8080/worker/";
    const data = {
        worker_id : document.getElementById("u-worker-id").value,
        factory_id :document.getElementById("u-worker-factory-id").value,
        product_type_id : document.getElementById("u-worker-type-id").value,
        name : document.getElementById("u-worker-name").value
    };
    console.log(url)
    console.log(data)
    sendPUTRequest(url, data, function(response) {
        console.log("Response from server:", response);
        for (let resp in response) {
            alert(resp + " : " + response[resp]);
        }
    });
}

function deleteWorker(event) {
    console.log("deleteWorker Called.")
    event.preventDefault();
    const url = "http://localhost:8080/worker/"+document.getElementById("d-worker-id").value+"/delete";
    console.log(url)
    sendDELETERequest(url, function(response) {
        console.log("Response from server:", response);
        alert(response);
    });
}

function getAllWorkers(event) {
    event.preventDefault();
    const url = "http://localhost:8080/worker/";
    sendGETRequest(url, function(response) {
        document.getElementById("worker-all-table").style.display="none";
        document.getElementById("worker-all-table").style.display="block";
        const tableBody = document.querySelector("#worker-all-table tbody");
        tableBody.innerHTML = "";
        response.forEach(worker => {
            const row = document.createElement("tr");
            row.innerHTML = `
                <td>${worker.worker_id}</td>
                <td>${worker.worker_type}</td>
                <td>${worker.name}</td>
                <td>${worker.factory_id}</td>
                <td>${worker.factory_name}</td>
            `;
            tableBody.appendChild(row);
        });
    });
}

function getWorker(event) {
    event.preventDefault();
    const url = "http://localhost:8080/worker/"+document.getElementById("g-worker-id").value;
    sendGETRequest(url, function(response) {
        console.log(response);

        if(response === null) {
            alert("No factory found for the given factory ID")
        } else {
            document.getElementById("worker-table").style.display="none";
            document.getElementById("worker-table").style.display="block";
            const tableBody = document.querySelector("#worker-table tbody");
            tableBody.innerHTML = "";
            const row = document.createElement("tr");
            row.innerHTML = `
                <td>${response.worker_id}</td>
                <td>${response.worker_type}</td>
                <td>${response.name}</td>
                <td>${response.factory_id}</td>
                <td>${response.factory_name}</td>
            `;
            tableBody.appendChild(row);
        }
    });
}
//-------------*************----------------
//MANAGE ORGANIZATION
//-------------*************----------------


function updateOrgInfo(event) {
    console.log("Update Org Form");
    event.preventDefault();

    const xhttp = new XMLHttpRequest();
    const url = "http://localhost:8080/user/"+document.getElementById("u-org-u-id").value+"/update";

    const data = {
        name : document.getElementById("u-org-name").value,
        email : document.getElementById("u-org-email").value,
        password : document.getElementById("u-org-password").value
    };

    xhttp.open("PUT", url, true);
    xhttp.setRequestHeader("Content-Type", "application/json");

    xhttp.onload = function () {
        const response = JSON.parse(xhttp.responseText);
        console.log(response);
        alert(JSON.stringify(response));
    };
    xhttp.send(JSON.stringify(data));
}

function deleteOrgInfo(event) {
    event.preventDefault();

    const xhttp = new XMLHttpRequest();
    const url = "http://localhost:8080/user/"+document.getElementById("d-org-id").value+"/delete";

    xhttp.open("DELETE", url, true);
    xhttp.setRequestHeader("Content-Type", "application/json");

    xhttp.onload = function () {
        if (xhttp.status === 200) {
            const response = JSON.parse(xhttp.responseText);
            console.log(response);
            alert(JSON.stringify(response));
            window.location.href = "http://localhost:8080";
        } else {
            console.error("Error:", xhttp.statusText);
        }
    };
    xhttp.send();
}


//-------------*************----------------
//MANAGE FACTORY
//-------------*************----------------

function addFactory(event) {
    event.preventDefault();

    const xhttp = new XMLHttpRequest();
    const url = "http://localhost:8080/factory/";

    const data = {
        org_id : document.getElementById("org-id").value,
        name : document.getElementById("factory-name").value,
        location : document.getElementById("factory-location").value,
        product_type_id : document.getElementById("factory-type").value

    };

    xhttp.open("POST", url, true);
    xhttp.setRequestHeader("Content-Type", "application/json");

    xhttp.onload = function () {
        const response = JSON.parse(xhttp.responseText);
        console.log(response);
        alert(JSON.stringify(response));
    };
    xhttp.send(JSON.stringify(data));
}

function updateFactory(event) {
    event.preventDefault();

    const xhttp = new XMLHttpRequest();
    const url = "http://localhost:8080/factory/"+document.getElementById("u-factory-id").value+"/update";

    const data = {
        org_id : document.getElementById("u-org-id").value,
        name : document.getElementById("u-factory-name").value,
        location : document.getElementById("u-factory-location").value,
        product_type_id : document.getElementById("u-factory-type").value,
        factory_id : document.getElementById("u-factory-id").value
    };

    xhttp.open("PUT", url, true);
    xhttp.setRequestHeader("Content-Type", "application/json");

    xhttp.onload = function () {
        const response = JSON.parse(xhttp.responseText);
        console.log(response);
        alert(JSON.stringify(response));
    };
    xhttp.send(JSON.stringify(data));
}

function deleteFactory(event) {
    event.preventDefault();

    const xhttp = new XMLHttpRequest();
    const url = "http://localhost:8080/factory/"+document.getElementById("d-factory-id").value+"/delete";

    xhttp.open("DELETE", url, true);
    xhttp.setRequestHeader("Content-Type", "application/json");

    xhttp.onload = function () {
        const response = JSON.parse(xhttp.responseText);
        console.log(response);
        alert(JSON.stringify(response));
    };
    xhttp.send();
}

function getFactory(event) {
    event.preventDefault();

    const xhttp = new XMLHttpRequest();
    const url = "http://localhost:8080/factory/"+document.getElementById("g-factory-id").value;

    xhttp.open("GET", url, true);
    xhttp.setRequestHeader("Content-Type", "application/json");

    xhttp.onload = function () {
        const factoryData = JSON.parse(xhttp.responseText);
        console.log(factoryData.length);
        console.log(factoryData);
        if (xhttp.status === 500) {
             alert("No factory found for the given factory ID !!!");
        } else {
            document.getElementById("factory-table").style.display="none";
            document.getElementById("factory-table").style.display="block";
            const tableBody = document.querySelector("#factory-table tbody");
            tableBody.innerHTML = "";
            const row = document.createElement("tr");
            row.innerHTML = `
                <td>${factoryData.factory_id}</td>
                <td>${factoryData.org_id}</td>
                <td>${factoryData.factory_name}</td>
                <td>${factoryData.location}</td>
                <td>${factoryData.org_name}</td>
                <td>${factoryData.type}</td>
                <td>${factoryData.date_created}</td>
            `;
            tableBody.appendChild(row);
        }


    };
    xhttp.send();
}

function getFactoryAll(event) {
    event.preventDefault();

    const xhttp = new XMLHttpRequest();
    const url = "http://localhost:8080/factory/";

    xhttp.open("GET", url, true);
    xhttp.setRequestHeader("Content-Type", "application/json");

    xhttp.onload = function () {
        const factoryData = JSON.parse(xhttp.responseText);
        document.getElementById("factory-table-all").style.display="block";
        const tableBody = document.querySelector("#factory-table-all tbody");
        tableBody.innerHTML = "";
        factoryData.forEach(factory => {
            const row = document.createElement("tr");
            row.innerHTML = `
                <td>${factory.factory_id}</td>
                <td>${factory.org_id}</td>
                <td>${factory.factory_name}</td>
                <td>${factory.location}</td>
                <td>${factory.org_name}</td>
                <td>${factory.type}</td>
                <td>${factory.date_created}</td>
            `;
            tableBody.appendChild(row);
        });
    };
    xhttp.send();
}


//-------------*************----------------
//SHOW FORMS
//-------------*************----------------

function showFactoryOperations() {
    document.getElementById("factory").style.display = "block";
    const url = "http://localhost:8080/product_type/";
    sendGETRequest(url, function(response) {

        //Populating Factory Option in add factory form
        const select = document.getElementById('factory-type');
        response.forEach(res => {
            const option = document.createElement('option');
            option.value = res.product_type_id;
            option.textContent = res.product_type;
            select.appendChild(option);
        });

        //Populating Factory Option in update factory form
        const uselect = document.getElementById('u-factory-type');
        response.forEach(res => {
            const uoption = document.createElement('option');
            uoption.value = res.product_type_id;
            uoption.textContent = res.product_type;
            uselect.appendChild(uoption);
        });
    });
}

function closeFactoryOperations() {
    document.getElementById("factory").style.display = "none";
}

function showUpdateOrg() {
    document.getElementById("update-org").style.display="block";
    document.getElementById("u-org-submit-btn").style.opacity = "0.5";
    document.getElementById("u-org-submit-btn").disabled = true;
}

function showWorkerOperations() {
    document.getElementById("worker").style.display = "block";
    const url = "http://localhost:8080/factory/";
    sendGETRequest(url, function(response) {

        //Populating Factory Option in add worker form
        const select = document.getElementById('worker-factory-id');
        response.forEach(res => {
            const option = document.createElement('option');
            option.value = res.factory_id;
            option.textContent = "Factory : " + res.factory_name + ", Location : "+ res.location + ", Organization : " + res.org_name + ", Factory Type: " + res.type;
            select.appendChild(option);
        });

        //Populating Factory Option in update worker form
        const uselect = document.getElementById('u-worker-factory-id');
        response.forEach(res => {
            const uoption = document.createElement('option');
            uoption.value = res.factory_id;
            uoption.textContent = "Factory : " + res.factory_name + ", Location : "+ res.location + ", Organization : " + res.org_name + ", Factory Type: " + res.type;
            uselect.appendChild(uoption);
        });
    });
    const url2 = "http://localhost:8080/product_type/";
    sendGETRequest(url2, function(response) {

        //Populating product type Option in add worker form
        const wtselect = document.getElementById('worker-type-id');
        response.forEach(res => {
            const wtoption = document.createElement('option');
            wtoption.value = res.product_type_id;
            wtoption.textContent = res.product_type;
            wtselect.appendChild(wtoption);
        });

        //Populating product type Factory Option in update worker form
        const uwtselect = document.getElementById('u-worker-type-id');
        response.forEach(res => {
            const uwtoption = document.createElement('option');
            uwtoption.value = res.product_type_id;
            uwtoption.textContent = res.product_type;
            uwtselect.appendChild(uwtoption);
        });
    });

}

function closeWorkerOperations() {
    document.getElementById("worker").style.display = "none";
}

function showCustomerAndVendorOperations() {
    document.getElementById("customer-and-vendor").style.display = "block";
}

function closeCustomerAndVendorOperations() {
    document.getElementById("customer-and-vendor").style.display = "none";
}






//-------------*************----------------
//SENDING REQUESTS
//-------------*************----------------
function sendPOSTRequest(url, data, callback) {
    console.log("sendPOSTRequest Called.")
    const xhttp = new XMLHttpRequest();
    xhttp.open("POST", url, true);
    xhttp.setRequestHeader("Content-Type", "application/json");

    xhttp.onload = function() {
            const response = JSON.parse(xhttp.responseText);
            callback(response);
    };
    xhttp.send(JSON.stringify(data));
}

function sendPUTRequest(url, data, callback) {
    console.log("sendPUTRequest Called.")
    const xhttp = new XMLHttpRequest();
    xhttp.open("PUT", url, true);
    xhttp.setRequestHeader("Content-Type", "application/json");

    xhttp.onload = function() {
        if (xhttp.status >= 200 && xhttp.status < 300) {
            const response = JSON.parse(xhttp.responseText);
            callback(response);
        } else {
            console.error("Error in request:", xhttp.statusText);
            callback(null);
        }
    };
    xhttp.onerror = function() {
        console.error("Network error");
        callback(null);
    };
    xhttp.send(JSON.stringify(data));
}

function sendDELETERequest(url, callback) {
    console.log("sendDELETERequest Called.")
    const xhttp = new XMLHttpRequest();
    xhttp.open("DELETE", url, true);
    xhttp.setRequestHeader("Content-Type", "application/json");

    xhttp.onload = function() {
        if (xhttp.status >= 200 && xhttp.status < 300) {
            const response = JSON.parse(xhttp.responseText);
            callback(response);
        } else {
            console.error("Error in request:", xhttp.statusText);
            callback(null);
        }
    };
    xhttp.onerror = function() {
        console.error("Network error");
        callback(null);
    };
    xhttp.send();
}

function sendGETRequest(url, callback) {
    console.log("sendGETRequest Called.")
    const xhttp = new XMLHttpRequest();
    xhttp.open("GET", url, true);
    xhttp.setRequestHeader("Content-Type", "application/json");

    xhttp.onload = function() {
        if (xhttp.status >= 200 && xhttp.status < 300) {
            const response = JSON.parse(xhttp.responseText);
            callback(response);
        } else {
            console.error("Error in request:", xhttp.statusText);
            callback(null);
        }
    };
    xhttp.onerror = function() {
        console.error("Network error");
        callback(null);
    };
    xhttp.send();
}
