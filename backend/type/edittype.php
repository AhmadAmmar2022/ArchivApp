<?php
include "../connect.php";

$typename = filterRequest("type_name");
$typeid = filterRequest("type_id");
$imagename = filterRequest("type_img");

if (isset($_FILES['file'])){
    
   deleteFile("../upload" , $imagename) ;
   $imagename = imageUpload("file");
  

} 



$stmp = $con->prepare("UPDATE `doctype` SET `type_name` = ?, `type_img` = ?  WHERE `type_id` = ? ");

$stmp->execute(array(
 $typename,$imagename,$typeid
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
  






