<!-- Order Forms -->
<div id="order" class="order">
    <center><h2>Manage Orders</h2></center>
    <button type="button" onclick="closeOrderOperations()" class="close-button"><i class="bi bi-x"></i> Close</button>
    <div id="add-order">
        <form action="" method="post" id="add-order-form">
            <h3>Add Order</h3>
            Order Type :
            <select id="order-type" name="order-type" required>
                <option value="SALES">SALES</option>
                <option value="PURCHASE">PURCHASE</option>
            </select><br>
            <div id="order-customer-id-div">
                Customer Id :
                <select id="order-customer-id" name="order-customer-id" required>
                </select><br>
            </div>
            <div id="order-vendor-id-div">
                Vendor Id :
                <select id="order-vendor-id" name="order-vendor-id" required>
                </select><br>
            </div>
            <h4>Select Products</h4>
            <div id="productsContainer">
                <!-- Products will be populated here -->
            </div>
            <input type="submit" id="add-order-submit-btn">
        </form>
    </div>
    <!--
        <div id="update-order">
            <form action="" method="put" id="update-order-form">
                <h3>Update Order</h3>
                Order Id :
                <input type="text" id="u-order-id" name="u-order-id" required><br>
                Name : <input type="text" id="u-order-name" name="u-order-name" required><br>
                Product type Id :
                <select id="u-order-type-id" name="u-order-type-id" required>
                </select><br>
                Factory Id :
                <select id="u-order-factory-id" name="u-order-factory-id" required>
                </select><br>
                <input type="submit" id="u-order-submit-btn">
            </form>
        </div>
    -->
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
</div>
