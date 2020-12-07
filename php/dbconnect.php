<?php
$servername = "localhost";
$username   = "id15576268_middleton";
$password   = "UiCOFahko1&?05_-";
$dbname     = "id15576268_bookworm";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
// 	echo "failed";
}
// else{
// 	echo "success";
// }
?>