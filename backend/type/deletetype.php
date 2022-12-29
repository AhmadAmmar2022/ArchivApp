<?php
include "../connect.php";
   
$type_id =filterRequest("type_id");
$imagename=filterRequest("image_name");
$stmp = $con->prepare("DELETE FROM `doctype` where `type_id`=? ");
$stmp->execute(array(
    $type_id
)); 
 $cont_row =$stmp ->rowCount(); 
 if ($cont_row >0  )
   { 
      deleteFile("../upload",$imagename);
      echo json_encode (array("status"=>"success"));
   }
  else {
  echo  json_encode(array("status"=>"erorr"));
  }
  ?>