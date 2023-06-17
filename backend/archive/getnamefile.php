<?php
include "../connect.php";
   
// $contraid=filterRequest("contra_id");
$stmp = $con->prepare("SELECT * FROM `files_name` " );

$stmp->execute(array(
 
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
 