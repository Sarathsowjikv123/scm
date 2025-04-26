<div id="machine" class="machine">
    <center><h2>Manage Workers</h2></center>
    <button type="button" onclick="closeWorkerOperations()" class="close-button"><i class="bi bi-x"></i> Close</button>
    <div id="add-machine">
        <form action="" method="post" id="add-machine-form">
            <h3>Add Machine</h3>
            Name : <input type="text" id="machine-name" name="machine-name" required><br>
            Product type Id :
            <select id="machine-type-id" name="machine-type-id" required>
            </select><br>
            Factory Id :
            <select id="machine-factory-id" name="machine-factory-id" required>
            </select><br>
            <input type="submit" id="add-machine-submit-btn">
        </form>
    </div>
    <div id="update-machine">
        <form action="" method="put" id="update-machine-form">
            <h3>Update Machine</h3>
            Machine Id :
            <input type="text" id="u-machine-id" name="u-machine-id" required><br>
            Name : <input type="text" id="u-machine-name" name="u-machine-name" required><br>
            Product type Id :
            <select id="u-machine-type-id" name="u-machine-type-id" required>
            </select><br>
            Factory Id :
            <select id="u-machine-factory-id" name="u-machine-factory-id" required>
            </select><br>
            <input type="submit" id="u-machine-submit-btn">
        </form>
    </div>
    <div id="delete-machine">
        <form action="" method="delete" id="delete-machine-form">
            <h3>Delete Machine</h3>
            <input type="text" id="d-machine-id" required>
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
                <td>Factory Id</td>
                <td>Factory Name</td>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <div id="get-machine-all">
        <form action="" method="get" id="get-machine-all-form">
            <h3>Get All Workers</h3>
            <input type="submit" id="g-machine-all-submit-btn">
        </form>
        <table id="machine-all-table">
            <thead>
            <tr>
                <td>Machine Id</td>
                <td>Machine Type</td>
                <td>Machine Name</td>
                <td>Factory Id</td>
                <td>Factory Name</td>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>