<?php
include_once("dbconnect.php");


if(isset($_POST['bookid'])){
$bookid = $_POST['bookid'];
$quantity = $_POST['quantity'];
$value = $_POST['value'];
$size = $_POST['size'];
$status = $_POST['status'];
$originality = $_POST['originality'];

    $sqladddetails = "INSERT INTO EXCHANGEBOOK(BOOKID,QUANTITY,VALUE,SIZE,STATUS,ORIGINALITY) VALUES('$bookid','$quantity','$value','$size','$status','$originality')";
    if ($conn->query($sqladddetails) === TRUE){
        echo "success";
    }else{
        echo "failed";
    }
}
?>