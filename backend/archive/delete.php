<?php
include "../connect.php";
   
$contra_id =filterRequest("contra_id");
$imagename=filterRequest("image_name");
$stmp = $con->prepare("DELETE FROM `contract` where `contra_id`=? ");
$stmp->execute(array(
 $contra_id
)); 
 $cont_row =$stmp ->rowCount(); 
 if ($cont_row >0  )
   { 
      deleteFile("../upload",$imagename);
      echo json_encode (array("status" =>"success"));
   }
  else {
  echo  json_encode(array("status "=>"erorr"));
  }
  ?>