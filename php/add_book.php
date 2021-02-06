<?php
include_once("dbconnect.php");

if(isset($_POST['title'])){
$booktitle = $_POST['title'];
$author = $_POST['author'];
$publisher = $_POST['publisher'];
$bookyear = $_POST['year'];
$bookedition = $_POST['edition'];
$bookcategory = $_POST['category'];
$isbn = $_POST['isbn'];
$cover = $_POST['cover'];
$useremail = $_POST['useremail'];
$encoded_string = $_POST["encoded_string"];

$decoded_string = base64_decode($encoded_string);
$path = '../images/bookimages/'.$cover.'.jpg';
$is_written = file_put_contents($path, $decoded_string);

if ($is_written > 0) {
    $sqlregister = "INSERT INTO BOOK(TITLE,AUTHOR,PUBLISHER,YEARS,EDITION,CATEGORY,ISBN,COVER,USEREMAIL) VALUES('$booktitle','$author','$publisher','$bookyear','$bookedition','$bookcategory','$isbn','$cover','$useremail')";
    if ($conn->query($sqlregister) === TRUE){
        echo "success";
    }else{
        echo "failed";
    }
}else{
    echo "failed";
}
}
?>