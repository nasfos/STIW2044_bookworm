<?php
error_reporting(0);
include_once("dbconnect.php");

if(isset($_POST['email'])){
$email = $_POST['email'];
$password = sha1($_POST['password']);

$sqllogin = "SELECT * FROM USER WHERE EMAIL = '$email' AND PASSWORD = '$password'";
$result = $conn->query($sqllogin);

if ($result->num_rows > 0) {
    while ($row = $result ->fetch_assoc()){
        echo "success,".$row["NAME"].",".$row["PHONE"].",".$row["DATEREG"];
    }
}else{
    echo "failed";
}
}
?>