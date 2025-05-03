document.getElementById("order").style.display="none";
document.getElementById("order-customer-id-div").style.display="none";
document.getElementById("order-vendor-id-div").style.display="none";



document.getElementById("add-order-form").addEventListener("submit", addOrder);
document.getElementById("update-order-form").addEventListener("submit", updateOrder);
document.getElementById("delete-order-form").addEventListener("submit", deleteOrder);
document.getElementById("get-order-form").addEventListener("submit", getOrder);
document.getElementById("get-order-all-form").addEventListener("submit", getAllOrders);

document.getElementById("order-all-table").style.display="none";
document.getElementById("order-table").style.display="none";

//-------------*************----------------
//MANAGE WORKERS
//-------------*************----------------
function addOrder(event) {
    console.log("addOrder Called.")
    event.preventDefault();
    const url = "http://localhost:8080/order/";
    const data = {
        factory_id : document.getElementById("order-factory-id").value,
        product_type_id :document.getElementById("order-type-id").value,
        name : document.getElementById("order-name").value
    };
    sendPOSTRequest(url, data, function(response) {
        console.log("Response from server:", response);
        for (let resp in response) {
            alert(resp + " : " + response[resp]);
        }
    });
}

function updateOrder(event) {
    console.log("UpdateOrder Called.")
    event.preventDefault();
    const url = "http://localhost:8080/order/";
    const data = {
        order_id : document.getElementById("u-order-id").value,
        factory_id :document.getElementById("u-order-factory-id").value,
        product_type_id : document.getElementById("u-order-type-id").value,
        name : document.getElementById("u-order-name").value
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

function deleteOrder(event) {
    console.log("deleteOrder Called.")
    event.preventDefault();
    const url = "http://localhost:8080/order/"+document.getElementById("d-order-id").value+"/delete";
    console.log(url)
    sendDELETERequest(url, function(response) {
        console.log("Response from server:", response);
        alert(response);
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
            row.innerHTML = `
                <td>${order.order_id}</td>
                <td>${order.order_type}</td>
                <td>${order.name}</td>
                <td>${order.factory_id}</td>
                <td>${order.factory_name}</td>
            `;
            tableBody.appendChild(row);
        });
    });
}

function getOrder(event) {
    event.preventDefault();
    const url = "http://localhost:8080/order/"+document.getElementById("g-order-id").value;
    sendGETRequest(url, function(response) {
        console.log(response);

        if(response === null) {
            alert("No factory found for the given factory ID")
        } else {
            document.getElementById("order-table").style.display="none";
            document.getElementById("order-table").style.display="block";
            const tableBody = document.querySelector("#order-table tbody");
            tableBody.innerHTML = "";
            const row = document.createElement("tr");
            row.innerHTML = `
                <td>${response.order_id}</td>
                <td>${response.order_type}</td>
                <td>${response.name}</td>
                <td>${response.factory_id}</td>
                <td>${response.factory_name}</td>
            `;
            tableBody.appendChild(row);
        }
    });
}