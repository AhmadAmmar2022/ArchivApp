<?php
include "../connect.php";
   
$depart_id =filterRequest("depart_id");
$imagename=filterRequest("image_name");
$stmp = $con->prepare("DELETE FROM `departments` where `depart_id`=? ");
$stmp->execute(array(
  $depart_id
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