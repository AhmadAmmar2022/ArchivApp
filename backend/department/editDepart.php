<?php
include "../connect.php";

$departname  = filterRequest("depart_name");
$departid    = filterRequest("depart_id");

$stmp = $con->prepare("UPDATE `departments` SET `depart_name` = ? WHERE `depart_id` = ? ");

$stmp->execute(array(
   $departname ,$departid 
));

$cont_row = $stmp->rowCount();

if ($cont_row > 0) {
   echo json_encode(array( "status" => "success"));
} else {
   echo  json_encode(array("status" => "erorr"));
}
