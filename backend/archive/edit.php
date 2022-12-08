<?php
include "../connect.php";
   
$contra_name=filterRequest("contra_name");
$contra_date=filterRequest("contra_date");
$contra_issigned=filterRequest("contra_issigned");
$contra_id=filterRequest("contra_id");



$stmp = $con->prepare("UPDATE `contract` SET `contra_name`= ?,`contra_date`= ?,`contra_issigned`= ?  WHERE `contra_id`= ?");


$stmp->execute(array(
 $contra_name,$contra_date,$contra_issigned,$contra_id
)); 

 $cont_row =$stmp ->rowCount(); 
 
 if ($cont_row >0  )
   { 
      echo json_encode (array("status" =>" success"));
   }
  else {
  echo  json_encode(array("status "=>"erorr"));
  }
  ?>