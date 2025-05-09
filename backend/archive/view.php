<?php
include "../connect.php";

$typeid = filterRequest("type_id");
$search = isset($_GET['search']) ? $_GET['search'] : null;

if ($search) {
    $stmp = $con->prepare("SELECT * FROM archives WHERE type_id = ? AND name LIKE ?");
    $stmp->execute([$typeid, "%$search%"]);
} else {
    $stmp = $con->prepare("SELECT * FROM archives WHERE type_id = ?");
    $stmp->execute([$typeid]);
}

$cont_row = $stmp->rowCount();
$data = $stmp->fetchAll(PDO::FETCH_ASSOC);

if ($cont_row > 0) {
    echo json_encode(array("status" => "success", "data" => $data));
} else {
    echo json_encode(array("status" => "error", "message" => "No data found"));
}
?>
