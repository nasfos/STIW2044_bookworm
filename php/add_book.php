<?php
include_once("dbconnect.php");
$bookid = $_POST['BOOKID'];
$booktitle = $_POST['TITLE'];
$author = $_POST['AUTHOR'];
$publisher = $_POST['PUBLISHER'];
$bookyear = $_POST['YEAR'];
$bookedition = $_POST['EDITION'];
$bookcategory = $_POST['CATEGORY'];
$isbn = $_POST['ISBN'];
$cover = $_POST['COVER'];
$useremail = $_POST['USEREMAIL'];
$encoded_string = $_POST["encoded_string"];
$status = "Available";

$decoded_string = base64_decode($encoded_string);
$path = '../images/bookimages/'.$cover.'.jpg';
$is_written = file_put_contents($path, $decoded_string);

if ($is_written > 0) {
    $sqlregister = "INSERT INTO BOOK(BOOKID,TITLE,AUTHOR,PUBLISHER,YEAR,EDITION,CATEGORY,ISBN,COVER,USEREMAIL) VALUES('$bookid','$booktitle','$author','$publisher','$bookyear','$bookedition','$bookcategory','$isbn','$cover',$useremail)";
    if ($conn->query($sqlregister) === TRUE){
        echo "success";
    }else{
        echo "failed";
    }
}else{
    echo "failed";
}

?>