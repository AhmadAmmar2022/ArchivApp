<?php
include "../connect.php";

$contra_name = filterRequest("name");
$contra_date = filterRequest("date");
$contra_des = filterRequest("description");

$type_id = filterRequest("type_id");
$filesname = imageupload('files');


$stmp = $con->prepare(" INSERT INTO `archives` (`name`, `date`,`description`,`type_id`) VALUES (?,?,?,?)");

$stmp->execute(array(
  $contra_name, $contra_date, $contra_des, $type_id
));



$s = $con->prepare(" SELECT * FROM `archives` order by id DESC LIMIT 1");
$s->execute();
$data = $s->fetch(PDO::FETCH_ASSOC);
$contra_id = $data['id'];


for ($i = 0; $i < count($filesname); $i++) {
  $stmpp = $con->prepare(" INSERT INTO `files_name` (`file_name`, `archiv_id`) VALUES (?,?)");
  $stmpp->execute(array(
    $filesname[$i], $contra_id
  ));
}

$cont_row = $stmp->rowCount();
if ($cont_row > 0) {
  echo json_encode(array("status" => "success"));
} else {
  echo  json_encode(array("status " => "erorr"));
} 
   

   
  // else {
  //   echo  json_encode(array("status "=>"erorr"));
  //  }
