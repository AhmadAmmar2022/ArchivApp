<?php
include "../connect.php";
   
$username=filterRequest("username");
$password=filterRequest("password");
$email=filterRequest("email");




$stmp = $con->prepare(" INSERT INTO `users`(`username`, `password`, `email`) VALUES (?,?,?)");


$stmp->execute(array(
 $username,$password,$email
)); 

 $cont_row =$stmp ->rowCount(); 
 
 if ($cont_row >0  )
   { 
      echo json_encode (array("status" =>"success"));
    }
   else {
   echo  json_encode(array("status "=>"erorr"));
   }
  ?>