<?php
include "../connect.php";

// التحقق من إرسال user_id
if (!isset($_GET['user_id'])) {
    echo json_encode(array("status" => "error", "message" => "No user_id received"));
    exit();
}

$user_id = $_GET['user_id'];
$search = isset($_GET['search']) ? '%' . $_GET['search'] . '%' : null;

// الاستعلام مع أو بدون فلترة
if ($search) {
    $stmp = $con->prepare("SELECT * FROM `doctype` WHERE `user_id` = ? AND `type_name` LIKE ?");
    $stmp->execute([$user_id, $search]);
} else {
    $stmp = $con->prepare("SELECT * FROM `doctype` WHERE `user_id` = ?");
    $stmp->execute([$user_id]);
}

$cont_row = $stmp->rowCount(); 
$data = $stmp->fetchAll(PDO::FETCH_ASSOC);

if ($cont_row > 0) { 
    echo json_encode(array("status" => "success", "data" => $data));
} else {
    echo json_encode(array("status" => "error", "message" => "No data found"));
}
?>
