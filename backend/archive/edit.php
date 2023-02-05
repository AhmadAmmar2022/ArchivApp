<?php
include "../connect.php";
   
$contra_name=filterRequest("contra_name");
$contra_date=filterRequest("contra_date");
$contra_issigned=filterRequest("contra_issigned");
$contra_salary=filterRequest("contra_salary");
$imagename=filterRequest("contra_image");
$contra_id=filterRequest("contra_id");
$docid=filterRequest("doc_id");



if (isset($_FILES['file'])) {
   deleteFile("../upload",$imagename);
   $imagename = imageupload('file');
  
} 
$stmp = $con->prepare("UPDATE `contract` SET `contra_name` = ?, `contra_date` = ?, `contra_salary` = ?, `contra_issigned` = ? ,`contra_image`= ?,`doc_id` = ? WHERE contra_id = ?");

$stmp->execute(array(
 $contra_name,$contra_date,$contra_salary,$contra_issigned,$imagename,$docid,$contra_id
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