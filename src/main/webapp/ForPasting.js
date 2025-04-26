document.getElementById("machine").style.display="none";

document.getElementById("add-machine-form").addEventListener("submit", addMachine);
    document.getElementById("update-machine-form").addEventListener("submit", updateMachine);
    document.getElementById("delete-machine-form").addEventListener("submit", deleteMachine);
    document.getElementById("get-machine-form").addEventListener("submit", getMachine);
    document.getElementById("get-machine-all-form").addEventListener("submit", getAllMachines);
    
    
    
    
    
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
            name : document.getElementById("machine-name").value
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
            worker_id : document.getElementById("u-machine-id").value,
            factory_id :document.getElementById("u-machine-factory-id").value,
            product_type_id : document.getElementById("u-machine-type-id").value,
            name : document.getElementById("u-machine-name").value
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
                    <td>${machine.worker_id}</td>
                    <td>${machine.worker_type}</td>
                    <td>${machine.name}</td>
                    <td>${machine.factory_id}</td>
                    <td>${machine.factory_name}</td>
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
    
    
    
    function closeMachineOperations() {
        document.getElementById("machine").style.display = "none";
    }
