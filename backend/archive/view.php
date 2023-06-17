<?php
include "../connect.php";
   
$typeid=filterRequest("type_id");
$stmp = $con->prepare("select * FROM contract where contract.doc_id=?");


$stmp->execute(array(
 $typeid
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