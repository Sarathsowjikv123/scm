document.addEventListener("DOMContentLoaded", function () {
    document.getElementById("").addEventListener("submit", loginUser);
    document.getElementById("new-org").style.display = "none";
});

function loginUser(event) {
    event.preventDefault();

    const xhttp = new XMLHttpRequest();
    const url = "http://localhost:8080/user/login";

    const data = {
        username: document.getElementById("user-name").value,
        password: document.getElementById("pass-word").value,
    };

    xhttp.open("POST", url, true);
    xhttp.setRequestHeader("Content-Type", "application/json");

    xhttp.onload = function () {
        if (xhttp.status === 200) {
            const response = JSON.parse(xhttp.responseText);
            console.log(response);
            document.getElementById("insert-result").innerHTML = JSON.stringify(response, null, 2);
        } else {
            console.error("Error:", xhttp.statusText);
        }
    };
    xhttp.send(JSON.stringify(data));
}


function sendOTP() {
    console.log("Send OTP Called !!!");
}