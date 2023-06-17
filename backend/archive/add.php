<?php
include "../connect.php";

$contra_name = filterRequest("contra_name");
$contra_date = filterRequest("contra_date");
$contra_issigned = filterRequest("contra_issigned");
$contra_salary = filterRequest("contra_salary");
$doc_id = filterRequest("doc_id");
$filesname = imageupload('files');


$stmp = $con->prepare(" INSERT INTO `contract` (`contra_name`, `contra_date`,`contra_issigned`,`contra_salary`,`doc_id`) VALUES (?,?,?,?,?)");

$stmp->execute(array(
  $contra_name, $contra_date, $contra_issigned, $contra_salary, $doc_id
));



$s = $con->prepare(" SELECT * FROM `contract` order by contra_id DESC LIMIT 1");
$s->execute();
$data = $s->fetch(PDO::FETCH_ASSOC);
$contra_id = $data['contra_id'];
print_r($data);
echo ($contra_id);

for ($i = 0; $i < count($filesname); $i++) {
  $stmpp = $con->prepare(" INSERT INTO `files_name` (`file_name`, `contra_id`) VALUES (?,?)");
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
