<?php
//
// Final Project PHP Front END
// Mark Smeltzer 
// Database Design Porject Part 4
//
error_reporting(E_ALL);
ini_set('display_errors', 1);

//connection
function getConnection() {
    require __DIR__ . "/config.php";

    $conn = mysqli_connect($DB_HOST, $DB_USER, $DB_PASS, $DB_NAME);

    if (!$conn) {
        die("Connection unsuccessful: " . mysqli_connect_error());
    }

    return $conn;
}
$message = "";
?>

<!DOCTYPE html>
<html>
<head>
<title>MySQL Operations Demo</title>
<style>
body { font-family: Arial; width: 700px; margin: 20px auto; }
input, select { padding: 5px; margin: 5px; }
button { padding: 6px 12px; }
table { border-collapse: collapse; width: 100%; margin-top: 10px; }
td,th { border: 1px solid #888; padding: 6px; }
</style>
</head>
<body>

<h1>MySQL Operations Demo</h1>

<!-- INSERT CUSTOMER -->
<h2>Insert</h2>
<form method="POST">
    Name: <input type="text" name="ins_name">
    Email: <input type="text" name="ins_email">
    <button name="insertBtn">Insert</button>
</form>

<?php
if (isset($_POST['insertBtn'])) {
    $conn = getConnection();

    $name = $_POST['ins_name'];
    $email = $_POST['ins_email'];

    $parts = explode(" ", $name);
    $first = $parts[0];
    $last  = $parts[1] ?? "";

    $sql = "INSERT INTO Customer (FirstName, LastName, CustomerEmail, CustomerPhoneNumber, Password, AccountCreationDate)
            VALUES ('$first','$last','$email','000-000-0000','pass',NOW())";

    if ($conn->query($sql)) $message = "Insert Success";
}
echo "<p>Message: $message</p>";
?>

<!-- UPDATE CUSTOMER -->
<h2>Update</h2>
<form method="POST">
    Select User:
    <select name="upd_user">
        <?php
        $conn = getConnection();
        $result = $conn->query("SELECT CustomerID, FirstName, LastName FROM Customer");
        while ($r = $result->fetch_assoc()) {
            echo "<option value='{$r['CustomerID']}'>{$r['FirstName']} {$r['LastName']}</option>";
        }
        ?>
    </select><br>

    New Name: <input type="text" name="upd_name">
    New Email: <input type="text" name="upd_email">
    <button name="updateBtn">Update</button>
</form>

<?php
if (isset($_POST['updateBtn'])) {
    $conn = getConnection();

    $id = $_POST['upd_user'];
    $name = $_POST['upd_name'];
    $email = $_POST['upd_email'];

    $parts = explode(" ", $name);
    $first = $parts[0];
    $last  = $parts[1] ?? "";

    $sql = "UPDATE Customer SET FirstName='$first', LastName='$last', CustomerEmail='$email'
            WHERE CustomerID=$id";

    if ($conn->query($sql)) $message = "Update Success";
}
echo "<p>Message: $message</p>";
?>

<!-- DELETE CUSTOMER -->
<h2>Delete</h2>
<form method="POST">
    Select User:
    <select name="del_user">
        <?php
        $conn = getConnection();
        $result = $conn->query("SELECT CustomerID, FirstName, LastName FROM Customer");
        while ($r = $result->fetch_assoc()) {
            echo "<option value='{$r['CustomerID']}'>{$r['FirstName']} {$r['LastName']}</option>";
        }
        ?>
    </select>
    <button name="deleteBtn">Delete</button>
</form>

<?php
if (isset($_POST['deleteBtn'])) {
    $conn = getConnection();
    $id = $_POST['del_user'];

    $conn->query("DELETE FROM Customer WHERE CustomerID=$id");
    echo "<p>Message: Delete Success</p>";
}
?>

<!-- SELECT – DISPLAY ALL CUSTOMERS -->
<h2>Select (Display Customers)</h2>

<?php
$conn = getConnection();

$sql = "SELECT CustomerID, FirstName, LastName, CustomerEmail FROM Customer";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "<table><tr>
            <th>CustomerID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Email</th>
          </tr>";
    
    while ($row = $result->fetch_assoc()) {
        echo "<tr>
                <td>{$row['CustomerID']}</td>
                <td>{$row['FirstName']}</td>
                <td>{$row['LastName']}</td>
                <td>{$row['CustomerEmail']}</td>
              </tr>";
    }

    echo "</table>";
} else {
    echo "<p>No customer records found.</p>";
}
?>
<hr>

<!-- VIEW DEMONSTRATION -->
<h2>View</h2>
<form method="POST">
    Select View:
    <select name="viewname">
        <option value="CustomerOrderOverviewView">CustomerOrderOverviewView</option>
        <option value="ProductSalesView">ProductSalesView</option>
    </select>
    <button name="viewBtn">Show Data</button>
</form>

<?php
if (isset($_POST['viewBtn'])) {
    $conn = getConnection();
    $view = $_POST['viewname'];
    $result = $conn->query("SELECT * FROM $view");

    echo "<table><tr>";
    while ($f = $result->fetch_field()) echo "<th>$f->name</th>";
    echo "</tr>";

    while ($row = $result->fetch_assoc()) {
        echo "<tr>";
        foreach ($row as $v) echo "<td>$v</td>";
        echo "</tr>";
    }
    echo "</table>";
}
?>

<!-- FUNCTION DEMO -->
<h2>Functions & Stored Procedure</h2>

<form method="POST">
    Enter Order ID: <input type="text" name="orderid">
    <button name="funcBtn">Run Function</button>
</form>

<?php
if (isset($_POST['funcBtn'])) {
    $conn = getConnection();
    $oid = $_POST['orderid'];

    $result = $conn->query("SELECT GetOrderTotal($oid) AS total");
    $row = $result->fetch_assoc();

    echo "<p>Result: {$row['total']}</p>";
}
?>

<!-- STORED PROCEDURE DEMO -->
<form method="POST">
    Customer ID: <input type="text" name="cust">
    Product ID: <input type="text" name="prod">
    Quantity: <input type="text" name="qty">
    <button name="procBtn">Execute Procedure</button>
</form>

<?php
if (isset($_POST['procBtn'])) {
    $conn = getConnection();

    $cid = $_POST['cust'];
    $pid = $_POST['prod'];
    $qty = $_POST['qty'];

    $conn->query("CALL PlaceOrder($cid, $pid, $qty)");

    echo "<p>Stored Procedure Executed</p>";
}
?>

<!-- TRIGGER DEMO -->
<h2>Trigger Demonstration</h2>
<p>Insert/Update/Delete above will automatically fire triggers (Stock update, Order log, etc.)</p>

</body>
</html>
