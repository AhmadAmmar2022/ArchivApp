<?php
include "../connect.php";

$typename  = filterRequest("type_name");
$typeid    = filterRequest("type_id");
$typecolor = filterRequest("type_color");

$stmp = $con->prepare("UPDATE `doctype` SET `type_name` = ?,`type_color` = ? WHERE `type_id` = ? ");

$stmp->execute(array(
   $typename, $typecolor, $typeid
));

$cont_row = $stmp->rowCount();

if ($cont_row > 0) {
   echo json_encode(array("status" => "success"));
} else {
   echo  json_encode(array("status" => "erorr"));
}
