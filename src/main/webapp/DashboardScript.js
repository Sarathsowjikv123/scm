document.addEventListener("DOMContentLoaded", function () {

    document.getElementById("factory").style.display="none";

    document.getElementById("worker").style.display="none";

    document.getElementById("customer-and-vendor").style.display="none";

    document.getElementById("machine").style.display="none";

    document.getElementById("raw-material").style.display="none";

    document.getElementById("product").style.display="none";

    document.getElementById("order").style.display="none";
    document.getElementById("order-customer-id-div").style.display="none";
    document.getElementById("order-vendor-id-div").style.display="none";

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

    document.getElementById("add-machine-form").addEventListener("submit", addMachine);
    document.getElementById("update-machine-form").addEventListener("submit", updateMachine);
    document.getElementById("delete-machine-form").addEventListener("submit", deleteMachine);
    document.getElementById("get-machine-form").addEventListener("submit", getMachine);
    document.getElementById("get-machine-all-form").addEventListener("submit", getAllMachines);

    document.getElementById("add-raw-material-form").addEventListener("submit", addRawMaterial);
    document.getElementById("update-raw-material-form").addEventListener("submit", updateRawMaterial);
    document.getElementById("delete-raw-material-form").addEventListener("submit", deleteRawMaterial);
    document.getElementById("get-raw-material-form").addEventListener("submit", getRawMaterial);
    document.getElementById("get-raw-material-all-form").addEventListener("submit", getAllRawMaterials);

    document.getElementById("add-product-form").addEventListener("submit", addProduct);
    document.getElementById("update-product-form").addEventListener("submit", updateProduct);
    document.getElementById("delete-product-form").addEventListener("submit", deleteProduct);
    document.getElementById("get-product-form").addEventListener("submit", getProduct);
    document.getElementById("get-product-all-form").addEventListener("submit", getAllProducts);

    document.getElementById("add-order-form").addEventListener("submit", addOrder);
    document.getElementById("delete-order-form").addEventListener("submit", deleteOrder);
    document.getElementById("get-order-form").addEventListener("submit", getOrder);
    document.getElementById("get-order-all-form").addEventListener("submit", getAllOrders);
    document.getElementById("update-po-form").addEventListener("submit", updatePO);
    document.getElementById("get-po-all-form").addEventListener("submit", getAllpo);
    document.getElementById("get-po-form").addEventListener("submit", getpobyId);




    document.getElementById("factory-table").style.display="none";
    document.getElementById("factory-table-all").style.display="none";

    document.getElementById("worker-all-table").style.display="none";
    document.getElementById("worker-table").style.display="none";

    document.getElementById("customer-table").style.display="none";
    document.getElementById("customer-all-table").style.display="none";
    document.getElementById("vendor-table").style.display="none";
    document.getElementById("vendor-all-table").style.display="none";

    document.getElementById("machine-table").style.display="none";
    document.getElementById("machine-all-table").style.display="none";

    document.getElementById("raw-material-table").style.display="none";
    document.getElementById("raw-material-all-table").style.display="none";

    document.getElementById("product-all-table").style.display="none";
    document.getElementById("product-table").style.display="none";

    document.getElementById("order-all-table").style.display="none";
    document.getElementById("order-table").style.display="none";
    document.getElementById("po-all-table").style.display="none";
    document.getElementById("po-table").style.display="none";
});

const selectOrderType = document.getElementById('order-type');

selectOrderType.addEventListener('change', function() {
    const selectedValue = selectOrderType.value;
    const selectedText = selectOrderType.options[selectOrderType.selectedIndex].text;
    if(selectedValue === "SALES") {
        document.getElementById("order-customer-id-div").style.display="block";
        document.getElementById("order-vendor-id-div").style.display="none";

        const url = "http://localhost:8080/customer_and_vendor/customers";
        sendGETRequest(url, function(response) {
            const select = document.getElementById('order-customer-id');
            response.forEach(res => {
                const option = document.createElement('option');
                option.value = res.customer_or_vendor_id;
                option.textContent = res.name;
                select.appendChild(option);
            });
        });

        const purl = "http://localhost:8080/product/";
        sendGETRequest(purl, function(response) {

            //Populating Product Option in New Order form
            const select = document.getElementById('productSelect');
            select.innerHTML = '';
            response.forEach(res => {
                const option = document.createElement('option');
                option.value = res.product_id;
                option.textContent = res.name;
                select.appendChild(option);
            });
        });

    } else {
        document.getElementById("order-vendor-id-div").style.display="block";
        document.getElementById("order-customer-id-div").style.display="none";

        const url = "http://localhost:8080/customer_and_vendor/vendors";
        sendGETRequest(url, function(response) {
            const select = document.getElementById('order-vendor-id');
            response.forEach(res => {
                const option = document.createElement('option');
                option.value = res.customer_or_vendor_id;
                option.textContent = res.name;
                select.appendChild(option);
            });
        });

        const rurl = "http://localhost:8080/raw_material/";
        sendGETRequest(rurl, function(response) {

            //Populating Product Option in New Order form
            const select = document.getElementById('productSelect');
            select.innerHTML = '';
            response.forEach(res => {
                const option = document.createElement('option');
                option.value = res.rawMaterial_id;
                option.textContent = res.name;
                select.appendChild(option);
            });
        });
    }
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
//MANAGE MACHINES
//-------------*************----------------
function addMachine(event) {
    console.log("addMachine Called.")
    event.preventDefault();
    const url = "http://localhost:8080/machines/";
    const data = {
        factory_id : document.getElementById("machine-factory-id").value,
        product_type_id :document.getElementById("machine-type-id").value,
        name : document.getElementById("machine-name").value,
        status : "FREE",
        repair_cost : document.getElementById("machine-repair-cost").value
    };
    sendPOSTRequest(url, data, function(response) {
        console.log("Response from server:", response);
        for (let resp in response) {
            alert(resp + " : " + response[resp]);
        }
    });
}

function updateMachine(event) {
    console.log("UpdateMachine Called.")
    event.preventDefault();
    const url = "http://localhost:8080/machines/";
    const data = {
        machine_id : document.getElementById("u-machine-id").value,
        factory_id :document.getElementById("u-machine-factory-id").value,
        product_type_id : document.getElementById("u-machine-type-id").value,
        name : document.getElementById("u-machine-name").value,
        repair_cost : document.getElementById("u-machine-repair-cost").value
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

function deleteMachine(event) {
    console.log("deleteMachine Called.")
    event.preventDefault();
    const url = "http://localhost:8080/machines/"+document.getElementById("d-machine-id").value+"/delete";
    console.log(url)
    sendDELETERequest(url, function(response) {
        console.log("Response from server:", response);
        alert(response);
    });
}

function getAllMachines(event) {
    event.preventDefault();
    const url = "http://localhost:8080/machines/";
    sendGETRequest(url, function(response) {
        document.getElementById("machine-all-table").style.display="none";
        document.getElementById("machine-all-table").style.display="block";
        const tableBody = document.querySelector("#machine-all-table tbody");
        tableBody.innerHTML = "";
        response.forEach(machine => {
            const row = document.createElement("tr");
            row.innerHTML = `
                    <td>${machine.machine_id}</td>
                    <td>${machine.machine_type}</td>
                    <td>${machine.machine_name}</td>
                    <td>${machine.machine_status}</td>
                    <td>${machine.factory_id}</td>
                    <td>${machine.factory_name}</td>
                    <td>${machine.repair_cost}</td>
                `;
            tableBody.appendChild(row);
        });
    });
}

function getMachine(event) {
    event.preventDefault();
    const url = "http://localhost:8080/machines/"+document.getElementById("g-machine-id").value;
    sendGETRequest(url, function(response) {
        console.log(response);

        if(response === null) {
            alert("No factory found for the given factory ID")
        } else {
            document.getElementById("machine-table").style.display="none";
            document.getElementById("machine-table").style.display="block";
            const tableBody = document.querySelector("#machine-table tbody");
            tableBody.innerHTML = "";
            const row = document.createElement("tr");
            row.innerHTML = `
                    <td>${response.machine_id}</td>
                    <td>${response.machine_type}</td>
                    <td>${response.machine_name}</td>
                    <td>${response.machine_status}</td>
                    <td>${response.factory_id}</td>
                    <td>${response.factory_name}</td>
                    <td>${response.repair_cost}</td>
                `;
            tableBody.appendChild(row);
        }
    });
}

//-------------*************----------------
//MANAGE RAW MATERIALS
//-------------*************----------------
function addRawMaterial(event) {
    console.log("addRawMaterial Called.")
    event.preventDefault();
    const url = "http://localhost:8080/raw_material/";
    const data = {
        name : document.getElementById("raw-material-name").value,
        quantityRequired : document.getElementById("raw-material-initial-quantity-required").value,
        quantityAvailable :document.getElementById("raw-material-initial-quantity-available").value,
        price : document.getElementById("raw-material-cost").value
    };
    sendPOSTRequest(url, data, function(response) {
        console.log("Response from server:", response);
        for (let resp in response) {
            alert(resp + " : " + response[resp]);
        }
    });
}

function updateRawMaterial(event) {
    console.log("UpdateRawMaterial Called.")
    event.preventDefault();
    const url = "http://localhost:8080/raw_material/";
    const data = {
        rawMaterialId : document.getElementById("u-raw-material-id").value,
        name : document.getElementById("u-raw-material-name").value,
        quantityRequired : document.getElementById("u-raw-material-initial-quantity-required").value,
        quantityAvailable :document.getElementById("u-raw-material-initial-quantity-available").value,
        price : document.getElementById("u-raw-material-cost").value
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

function deleteRawMaterial(event) {
    console.log("deleteRawMaterial Called.")
    event.preventDefault();
    const url = "http://localhost:8080/raw_material/"+document.getElementById("d-raw-material-id").value+"/delete";
    console.log(url)
    sendDELETERequest(url, function(response) {
        console.log("Response from server:", response);
        alert(response);
    });
}

function getAllRawMaterials(event) {
    event.preventDefault();
    const url = "http://localhost:8080/raw_material/";
    sendGETRequest(url, function(response) {
        document.getElementById("raw-material-all-table").style.display="none";
        document.getElementById("raw-material-all-table").style.display="block";
        const tableBody = document.querySelector("#raw-material-all-table tbody");
        tableBody.innerHTML = "";
        response.forEach(raw_material => {
            const row = document.createElement("tr");
            row.innerHTML = `
                    <td>${raw_material.rawMaterial_id}</td>
                    <td>${raw_material.name}</td>
                    <td>${raw_material.quantity_avail}</td>
                    <td>${raw_material.quantity_req}</td>
                    <td>${raw_material.price}</td>
                `;
            tableBody.appendChild(row);
        });
    });
}

function getRawMaterial(event) {
    event.preventDefault();
    const url = "http://localhost:8080/raw_material/"+document.getElementById("g-raw-material-id").value;
    sendGETRequest(url, function(response) {
        console.log(response);

        if(response === null) {
            alert("No factory found for the given factory ID")
        } else {
            document.getElementById("raw-material-table").style.display="none";
            document.getElementById("raw-material-table").style.display="block";
            const tableBody = document.querySelector("#raw-material-table tbody");
            tableBody.innerHTML = "";
            const row = document.createElement("tr");
            row.innerHTML = `
                    <td>${response.rawMaterial_id}</td>
                    <td>${response.name}</td>
                    <td>${response.quantity_avail}</td>
                    <td>${response.quantity_req}</td>
                    <td>${response.price}</td>
                `;
            tableBody.appendChild(row);
        }
    });
}

//-------------*************----------------
//MANAGE PRODUCTS
//-------------*************----------------
function addProduct(event) {
    console.log("addProduct Called.")
    event.preventDefault();
    const url = "http://localhost:8080/product/";
    const data = {
        productTypeId :document.getElementById("product-type-id").value,
        name : document.getElementById("product-name").value,
        profitPercentage : document.getElementById("profit-percentage").value,
        productionTimeInMins : document.getElementById("production-time-in-mins").value,
        quantityAvailable : document.getElementById("product-quantity-available").value,
        quantityRequired : document.getElementById("product-quantity-required").value
    };
    sendPOSTRequest(url, data, function(response) {
        console.log("Response from server:", response);
        for (let resp in response) {
            alert(resp + " : " + response[resp]);
        }
    });
}

function updateProduct(event) {
    console.log("UpdateProduct Called.")
    event.preventDefault();
    const url = "http://localhost:8080/product/";
    const data = {
        productId :document.getElementById("u-product-id").value,
        productTypeId :document.getElementById("u-product-type-id").value,
        name : document.getElementById("u-product-name").value,
        profitPercentage : document.getElementById("u-profit-percentage").value,
        productionTimeInMins : document.getElementById("u-production-time-in-mins").value,
        quantityAvailable : document.getElementById("u-product-quantity-available").value,
        quantityRequired : document.getElementById("u-product-quantity-required").value
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

function deleteProduct(event) {
    console.log("deleteProduct Called.")
    event.preventDefault();
    const url = "http://localhost:8080/product/"+document.getElementById("d-product-id").value+"/delete";
    console.log(url)
    sendDELETERequest(url, function(response) {
        console.log("Response from server:", response);
        alert(response);
    });
}

function getAllProducts(event) {
    event.preventDefault();
    const url = "http://localhost:8080/product/";
    sendGETRequest(url, function(response) {
        document.getElementById("product-all-table").style.display="none";
        document.getElementById("product-all-table").style.display="block";
        const tableBody = document.querySelector("#product-all-table tbody");
        tableBody.innerHTML = "";
        response.forEach(product => {
            const row = document.createElement("tr");
            row.innerHTML = `
                <td>${product.product_id}</td>
                <td>${product.name}</td>
                <td>${product.product_type}</td>
                <td>${product.quantity_avail}</td>
                <td>${product.quantity_req}</td>
                <td>${product.cost_price}</td>
                <td>${product.selling_price}</td>
                <td>${product.prod_time_in_mins}</td>
            `;
            tableBody.appendChild(row);
        });
    });
}

function getProduct(event) {
    event.preventDefault();
    const url = "http://localhost:8080/product/"+document.getElementById("g-product-id").value;
    sendGETRequest(url, function(response) {
        console.log(response);

        if(response === null) {
            alert("No factory found for the given factory ID")
        } else {
            document.getElementById("product-table").style.display="none";
            document.getElementById("product-table").style.display="block";
            const tableBody = document.querySelector("#product-table tbody");
            tableBody.innerHTML = "";
            const row = document.createElement("tr");
            row.innerHTML = `
                <td>${response.product_id}</td>
                <td>${response.name}</td>
                <td>${response.product_type}</td>
                <td>${response.quantity_avail}</td>
                <td>${response.quantity_req}</td>
                <td>${response.cost_price}</td>
                <td>${response.selling_price}</td>
                <td>${response.prod_time_in_mins}</td>
            `;
            tableBody.appendChild(row);
        }
    });
}

//-------------*************----------------
//MANAGE ORDERS
//-------------*************----------------
const select = document.getElementById('productSelect');
const addedProducts = [];
const quantityOfProducts  = [];

function addOrder(event) {
    event.preventDefault();
    addedProducts.forEach(productName => {
        const quantityInputName = "quantity_" + productName.replace(/\s+/g, '');
        const quantity = document.querySelector(`input[name="${quantityInputName}"]`).value;
        quantityOfProducts.push(quantity);
    });
    console.log("addOrder Called.")
    console.log(addedProducts);
    console.log(quantityOfProducts);

    const url = "http://localhost:8080/order/";
    const orderType = document.getElementById("order-type").value;
    let cOrVId = 0;
    if(orderType === "SALES") {
        cOrVId = document.getElementById("order-customer-id").value;
    } else {
        cOrVId = document.getElementById("order-vendor-id").value;
    }
    const data = {
        order_type : orderType,
        customer_or_vendor_id : cOrVId,
        status : "NOT STARTED",
        products : addedProducts,
        quantities : quantityOfProducts
    };

    console.log(data);
    sendPOSTRequest(url, data, function(response) {
        console.log("Response from server:", response);
        for (let resp in response) {
            alert(resp + " : " + response[resp]);
        }
    });

    document.getElementById('selectedProductsContainer').innerHTML = '';
    addedProducts.length = 0;
    quantityOfProducts.length = 0;
}

function deleteOrder(event) {
    console.log("deleteWorker Called.")
    event.preventDefault();
    const url = "http://localhost:8080/order/"+document.getElementById("d-order-id").value+"/delete";
    console.log(url)
    sendDELETERequest(url, function(response) {
        console.log("Response from server:", response);
        for (let resp in response) {
            alert(resp + " : " + response[resp]);
        }
    });
}

function getOrder(event) {
    event.preventDefault();
    const url = "http://localhost:8080/order/"+document.getElementById("g-order-id").value;
    sendGETRequest(url, function(response) {
        document.getElementById("order-table").style.display="none";
        document.getElementById("order-table").style.display="block";
        const tableBody = document.querySelector("#order-table tbody");
        tableBody.innerHTML = "";
        response.forEach(order => {
            const row = document.createElement("tr");
            row.innerHTML = `
                <td>${order.order_id}</td>
                <td>${order.product_id}</td>
                <td>${order.product_name}</td>
                <td>${order.quantity}</td>
                <td>${order.worker_id}</td>
                <td>${order.worker_name}</td>
                <td>${order.machine_id}</td>
                <td>${order.machine_name}</td>
                <td>${order.start_time}</td>
                <td>${order.end_time}</td>
                <td>${order.status}</td>
            `;
            tableBody.appendChild(row);
        });
    });
}

function getAllOrders(event) {
    event.preventDefault();
    const url = "http://localhost:8080/order/";
    sendGETRequest(url, function(response) {
        document.getElementById("order-all-table").style.display="none";
        document.getElementById("order-all-table").style.display="block";
        const tableBody = document.querySelector("#order-all-table tbody");
        tableBody.innerHTML = "";
        response.forEach(order => {
            const row = document.createElement("tr");
//            if(order.worker_id === undefined && order.worker_name === undefined) {
//                order.worker_id = "NOT ALLOTTED";
//                order.worker_name = "NOT ALLOTTED"
//            }
            row.innerHTML = `
                <td>${order.order_id}</td>
                <td>${order.product_id}</td>
                <td>${order.product_name}</td>
                <td>${order.quantity}</td>
                <td>${order.worker_id}</td>
                <td>${order.worker_name}</td>
                <td>${order.machine_id}</td>
                <td>${order.machine_name}</td>
                <td>${order.start_time}</td>
                <td>${order.end_time}</td>
                <td>${order.status}</td>

            `;
            tableBody.appendChild(row);
        });
    });
}

function updatePO(event) {
    console.log("UpdateProduct Called.")
    event.preventDefault();
    const url = "http://localhost:8080/order/";
    const data = {
        order_id :document.getElementById("u-po-id").value,
        order_status : "COMPLETED",
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


function getAllpo(event) {
    event.preventDefault();
    const url = "http://localhost:8080/order/po";
    sendGETRequest(url, function(response) {
        document.getElementById("po-all-table").style.display="none";
        document.getElementById("po-all-table").style.display="block";
        const tableBody = document.querySelector("#po-all-table tbody");
        tableBody.innerHTML = "";
        response.forEach(order => {
            const row = document.createElement("tr");
            //            if(order.worker_id === undefined && order.worker_name === undefined) {
            //                order.worker_id = "NOT ALLOTTED";
            //                order.worker_name = "NOT ALLOTTED"
            //            }
            row.innerHTML = `
                <td>${order.order_id}</td>
                <td>${order.vendor_id}</td>
                <td>${order.order_type}</td>
                <td>${order.status}</td>
                <td>${order.ordered_date}</td>
                <td>${order.completed_date}</td>
                <td>${order.product_id}</td>
                <td>${order.product_name}</td>
                <td>${order.quantity}</td>
            `;
            tableBody.appendChild(row);
        });
    });
}

function getpobyId(event) {
    event.preventDefault();
    const poId = document.getElementById("g-po-id").value;
    const url = "http://localhost:8080/order/po/"+poId;
    sendGETRequest(url, function(response) {
        document.getElementById("po-table").style.display="none";
        document.getElementById("po-table").style.display="block";
        const tableBody = document.querySelector("#po-table tbody");
        tableBody.innerHTML = "";
        response.forEach(order => {
            const row = document.createElement("tr");
            //            if(order.worker_id === undefined && order.worker_name === undefined) {
            //                order.worker_id = "NOT ALLOTTED";
            //                order.worker_name = "NOT ALLOTTED"
            //            }
            row.innerHTML = `
                <td>${order.order_id}</td>
                <td>${order.vendor_id}</td>
                <td>${order.order_type}</td>
                <td>${order.status}</td>
                <td>${order.ordered_date}</td>
                <td>${order.completed_date}</td>
                <td>${order.product_id}</td>
                <td>${order.product_name}</td>
                <td>${order.quantity}</td>
            `;
            tableBody.appendChild(row);
        });
    });
}



//-------------*************----------------
//SHOW FORMS
//-------------*************----------------

function showFactoryOperations() {
    removeAllDiv();
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
    removeAllDiv();
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
    removeAllDiv();
    document.getElementById("customer-and-vendor").style.display = "block";
}

function closeCustomerAndVendorOperations() {
    document.getElementById("customer-and-vendor").style.display = "none";
}

function showMachineOperations() {
    removeAllDiv();
    document.getElementById("machine").style.display = "block";
    const url = "http://localhost:8080/product_type/";
    sendGETRequest(url, function(response) {

        //Populating Factory Option in add machines form
        const select = document.getElementById('machine-type-id');
        response.forEach(res => {
            const option = document.createElement('option');
            option.value = res.product_type_id;
            option.textContent = res.product_type;
            select.appendChild(option);
        });

        //Populating Factory Option in update machines form
        const uselect = document.getElementById('u-machine-type-id');
        response.forEach(res => {
            const uoption = document.createElement('option');
            uoption.value = res.product_type_id;
            uoption.textContent = res.product_type;
            uselect.appendChild(uoption);
        });
    });

    const furl = "http://localhost:8080/factory/";
    sendGETRequest(furl, function(response) {

        //Populating Factory Option in add machines form
        const select = document.getElementById('machine-factory-id');
        response.forEach(res => {
            const option = document.createElement('option');
            option.value = res.factory_id;
            option.textContent = "Factory : " + res.factory_name + ", Location : "+ res.location + ", Organization : " + res.org_name + ", Factory Type: " + res.type;
            select.appendChild(option);
        });

        //Populating Factory Option in update machines form
        const uselect = document.getElementById('u-machine-factory-id');
        response.forEach(res => {
            const uoption = document.createElement('option');
            uoption.value = res.factory_id;
            uoption.textContent = "Factory : " + res.factory_name + ", Location : "+ res.location + ", Organization : " + res.org_name + ", Factory Type: " + res.type;
            uselect.appendChild(uoption);
        });
    });

}

function closeMachineOperations() {
    document.getElementById("machine").style.display = "none";
}

function showRawMaterialOperations() {
    console.log("show raw material options called")
    removeAllDiv();
    document.getElementById("raw-material").style.display = "block";
}

function closeRawMaterialOperations() {
    document.getElementById("raw-material").style.display = "none";
}

function showProductOperations() {
    removeAllDiv();
    document.getElementById("product").style.display = "block";

    const url = "http://localhost:8080/product_type/";
    sendGETRequest(url, function(response) {

        //Populating Factory Option in add machines form
        const select = document.getElementById('product-type-id');
        response.forEach(res => {
            const option = document.createElement('option');
            option.value = res.product_type_id;
            option.textContent = res.product_type;
            select.appendChild(option);
        });

        //Populating Factory Option in update machines form
        const uselect = document.getElementById('u-product-type-id');
        response.forEach(res => {
            const uoption = document.createElement('option');
            uoption.value = res.product_type_id;
            uoption.textContent = res.product_type;
            uselect.appendChild(uoption);
        });
    });
}

function closeProductOperations() {
    document.getElementById("product").style.display = "none";
}

function showOrderOperations() {
    removeAllDiv();
    document.getElementById("order").style.display = "block";
    const products = [];

//    const url = "http://localhost:8080/product/";
//    const rurl = "http://localhost:8080/raw_material/";
//    sendGETRequest(url, function(response) {
//
//        //Populating Product Option in New Order form
//        const select = document.getElementById('productSelect');
//        select.innerHTML = '';
//        response.forEach(res => {
//            const option = document.createElement('option');
//            option.value = res.product_id;
//            option.textContent = res.name;
//            select.appendChild(option);
//        });
//    });
//
//    sendGETRequest(rurl, function(response) {
//
//        //Populating Product Option in New Order form
//        const select = document.getElementById('productSelect');
//        select.innerHTML = '';
//        response.forEach(res => {
//            const option = document.createElement('option');
//            option.value = res.rawMaterial_id;
//            option.textContent = res.name;
//            select.appendChild(option);
//        });
//    });
}

function addproduct() {
    const selectedValue = select.value;
    const selectedText = select.options[select.selectedIndex].text;
    if (!selectedValue) {
        alert('Please select a product.');
        return;
    }
    if (addedProducts.includes(selectedValue)) {
        alert('This product has already been added.');
        return;
    }
    addedProducts.push(selectedValue);
    const container = document.getElementById('selectedProductsContainer');
    const row = document.createElement('div');
    row.className = 'product-row';
    row.innerHTML = `
        <label>${selectedText}</label>
        <input type="text" name="quantity_${selectedValue.replace(/\s+/g, '')}" placeholder="Quantity">
      `;
    container.appendChild(row);
    select.value = '';
}

function closeOrderOperations() {
    document.getElementById("order").style.display = "none";
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

function removeAllDiv(){
    console.log("remove all div called");
    document.getElementById("factory").style.display = "none";
    document.getElementById("worker").style.display = "none";
    document.getElementById("customer-and-vendor").style.display = "none";
    document.getElementById("raw-material").style.display = "none";
    document.getElementById("product").style.display = "none";
    document.getElementById("order").style.display = "none";
    document.getElementById("machine").style.display = "none";
}
