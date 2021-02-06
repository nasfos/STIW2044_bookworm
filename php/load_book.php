<?php
error_reporting(0);
include_once("dbconnect.php");
$category = "for exchange";
// $type = $_POST['type'];

$sql = "SELECT * FROM BOOK WHERE CATEGORY = '$category'"; 
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $response["exchange_book"] = array();
    while ($row = $result ->fetch_assoc()){
        $booklist = array();
        $booklist[bookid] = $row["BOOKID"];
        $booklist[title] = $row["TITLE"];
        $booklist[author] = $row["AUTHOR"];
        $booklist[publisher] = $row["PUBLISHER"];
        $booklist[years] = $row["YEARS"];
        $booklist[edition] = $row["EDITION"];
        $booklist[category] = $row["CATEGORY"];
        $booklist[isbn] = $row["ISBN"];
        $booklist[cover] = $row["COVER"];
        $booklist[dateadd] = $row["DATEADD"];
        $booklist[useremail] = $row["USEREMAIL"];
        array_push($response["exchange_book"], $booklist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>