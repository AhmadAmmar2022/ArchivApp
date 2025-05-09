<?php
include "../connect.php";
   
$stmp = $con->prepare("select * FROM users ");
$stmp -> execute();
$data =$stmp->fetchAll(PDO::FETCH_ASSOC);
print_r($data);