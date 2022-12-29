<?php
include "../connect.php";
   
$type_name=filterRequest("type_name");
$imagename=imageupload('file');
if ($imagename !="fail")
{
  $stmp = $con->prepare("INSERT INTO `doctype` (`type_name`, `type_img`) VALUES (?,?)");
  $stmp->execute(array(
    $type_name,$imagename,
  )); 
   $cont_row =$stmp ->rowCount(); 
   if ($cont_row >0)
     { 
    echo json_encode (array("status" =>"success"));
     }
    else {
    echo  json_encode(array("status "=>"erorr"));
    }
   } 
  else {
    echo  json_encode(array("status "=>"erorr"));
   }
  ?>