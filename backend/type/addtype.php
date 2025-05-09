<?php
include "../connect.php";

// استلام البيانات من Flutter
$type_name = filterRequest("type_name");
$type_color = filterRequest("type_color");
$user_id = filterRequest("user_id"); 





// 👈 استلام user_id

// تعديل الاستعلام لإضافة user_id
$stmp = $con->prepare("INSERT INTO `doctype` (`type_name`, `type_color`, `user_id`) VALUES (?, ?, ?)");
$stmp->execute(array($type_name, $type_color, $user_id));

$cont_row = $stmp->rowCount(); 
if ($cont_row > 0) { 
  echo json_encode(array("status" => "success"));
} else {
  echo json_encode(array("status" => "error"));
}
?>
