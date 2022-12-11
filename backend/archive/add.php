<?php
include "../connect.php";
   
$contra_name=filterRequest("contra_name");
$contra_date=filterRequest("contra_date");
$contra_issigned=filterRequest("contra_issigned");
$contra_salary=filterRequest("contra_salary");
$user_id=filterRequest("user_id");
$stmp = $con->prepare(" INSERT INTO `contract` (`contra_name`, `contra_date`, `user_id`,`contra_issigned`,`contra_salary`) VALUES (?,?,?,?,?)");
$stmp->execute(array(
 $contra_name,$contra_date,$user_id,$contra_issigned,$contra_salary
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