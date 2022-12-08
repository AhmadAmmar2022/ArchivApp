<?php
include "../connect.php";
   
$userid=filterRequest("user_id");
$stmp = $con->prepare(" SELECT * FROM  `contract`  WHERE `user_id` =?");

$stmp->execute(array(
 $userid
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