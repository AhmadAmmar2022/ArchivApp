<?php
include "../connect.php";
   
$type_name=filterRequest("type_name");
  $stmp = $con->prepare("INSERT INTO `departments` (`depart_name`) VALUES (?)");
  $stmp->execute(array(
    $type_name,
  )); 
   $cont_row =$stmp ->rowCount(); 
   if ($cont_row >0)
     { 
    echo json_encode (array("status" =>"success"));
     }
    else {
    echo  json_encode(array("status "=>"erorr"));
    }
    

  ?>