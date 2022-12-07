<?php
include "../connect.php";
   
$username=filterRequest("username");
$password=filterRequest("password");

$stmp = $con->prepare(" SELECT * FROM users  WHERE `username`= ? AND `password`= ?  ");

$stmp->execute(array(
 $username,$password,
)); 

 $cont_row =$stmp ->rowCount(); 
 $data =$stmp->fetch(PDO::FETCH_ASSOC);
 if ($cont_row >0)
   { 
    echo json_encode(array("status" =>"success","data"=>$data));
      }
      else {
      echo  json_encode(array("status "=>"erorr"));
      }
  ?>