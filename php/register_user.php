<?php
include_once ("dbconnect.php");

if(isset($_POST['name'])){
$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$password = sha1($_POST['password']);
$otp = rand(1000,9999);

    $sqlinsert = "INSERT INTO USER(NAME,EMAIL,PHONE,PASSWORD,OTP) VALUES ('$name','$email','$phone','$password','$otp')";
    if ($conn->query($sqlinsert) === TRUE){
        sendEmail($otp,$email);
       echo "success";
    }else {
        echo "failed";
    }
}

function sendEmail($otp,$email){
    $from = "noreply@bookworm.com";
    $to = $email;
    $subject = "BOOKWORM: Verify your account!";
    $message = "Use the following link to verify your account :"."\n http://middleton.000webhostapp.com/stiw2044/php/verify_account.php?email=".$email."&key=".$otp;
    $headers = "From:" . $from;
    mail($email,$subject,$message, $headers);
}
?>