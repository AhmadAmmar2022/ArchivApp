<?php
include "../connect.php";
   
$contraid=filterRequest("contra_id");
$stmp = $con->prepare("select * FROM `files_name` where files_name.archiv_id=?" );// i

$stmp->execute(array(
  $contraid
)); 

 $cont_row =$stmp ->rowCount(); 
 $data =$stmp->fetchAll(PDO::FETCH_ASSOC);
 if ($cont_row >0)
   { 
    echo json_encode(array("status" =>"success","data"=>$data));// 
    }

      else {
      echo  json_encode(array("status "=>"erorr"));// 
          }
  ?>
 