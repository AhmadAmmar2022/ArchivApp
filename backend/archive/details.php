<?php
include "../connect.php";
   
$id=filterRequest("id");
$stmp = $con->prepare("select * FROM archives where archives.id=?");

$stmp->execute(array(
 $id
)); 

 $cont_row =$stmp ->rowCount(); 
 $data =$stmp->fetchAll(PDO::FETCH_ASSOC);
 if ($cont_row >0)
   { 
    echo json_encode(array("status" =>"success","data"=>$data));
      }
      else {
      echo  json_encode(array("status "=>"erorr"));
   }
  ?>
 