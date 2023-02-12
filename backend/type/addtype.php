<?php
include "../connect.php";
   
$type_name=filterRequest("type_name");
$type_color	=filterRequest("type_color");


  $stmp = $con->prepare("INSERT INTO `doctype` (`type_name`, `type_color`) VALUES (?,?)");
  $stmp->execute(array(
    $type_name,$type_color,
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