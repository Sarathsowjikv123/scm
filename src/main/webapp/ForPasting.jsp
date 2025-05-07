<div id="material-required" class="material-required">
    <center><h2>Manage materialRequired</h2></center>
    <button type="button" onclick="closematerialRequiredOperations()" class="close-button"><i class="bi bi-x"></i> Close</button>
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
            <button type="button" onclick="addrawMaterial()">Add Raw Material</button><br><br>
            <h4>Selected Raw Material</h4><br>
            <div id="selectedRawMaterialsContainer">
            </div>
            <input type="submit" id="add-material-required-submit-btn">
        </form>
    </div>
    <div id="delete-material-required">
        <form action="" method="delete" id="delete-material-required-form">
            <h3>Delete materialRequired</h3>
            <input type="text" id="d-material-required-id" required>
            <input type="submit" id="d-material-required-submit-btn">
        </form>
    </div>
    <div id="get-material-required">
        <form action="" method="get" id="get-material-required-form">
            <h3>Get materialRequired</h3>
            <input type="text" id="g-material-required-id" required>
            <input type="submit" id="g-material-required-submit-btn">
        </form>
        <table id="material-required-table">
            <thead>
            <tr>
                <td>materialRequired Id</td>
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
    <div id="get-material-required-all">
        <form action="" method="get" id="get-material-required-all-form">
            <h3>Get All materialRequired</h3>
            <input type="submit" id="g-material-required-all-submit-btn">
        </form>
        <table id="material-required-all-table">
            <thead>
            <tr>
                <td>materialRequired Id</td>
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

    <div id="update-po">
        <form action="" method="put" id="update-po-form">
            <h3>Mark Purchase materialRequired as Received</h3>
            Purchase materialRequired Id :
            <input type="number" id="u-po-id" name="u-po-id" required><br>
            <input type="submit" id="u-po-submit-btn">
        </form>
    </div>

    <div id="update-tracking">
        <form action="" method="put" id="update-tracking-form">
            <h3>UPDATE ORDER STATUS</h3>
            Purchase materialRequired Id :
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

    <div id="get-po-all">
        <form action="" method="get" id="get-po-all-form">
            <h3>Get All Purchase materialRequired</h3>
            <input type="submit" id="g-po-all-submit-btn">
        </form>
        <table id="po-all-table">
            <thead>
            <tr>
                <td>materialRequired Id</td>
                <td>Vendor Id</td>
                <td>materialRequired Type</td>
                <td>Status</td>
                <td>materialRequired Date</td>
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
            <h3>Get Purchase materialRequired</h3>
            <input type="text" id="g-po-id" required>
            <input type="submit" id="g-po-submit-btn">
        </form>
        <table id="po-table">
            <thead>
            <tr>
                <td>materialRequired Id</td>
                <td>Vendor Id</td>
                <td>materialRequired Type</td>
                <td>Status</td>
                <td>materialRequired Date</td>
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