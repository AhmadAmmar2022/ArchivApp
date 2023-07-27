<?php
include "../connect.php";
   
$depart_id=filterRequest("depart_id");
$stmp = $con->prepare("select * FROM `employees` where employees.depart_id =?");


$stmp->execute(array(
  $depart_id
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
  