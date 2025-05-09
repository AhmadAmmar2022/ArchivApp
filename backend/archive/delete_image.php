<?php
include "../connect.php";

$archiv_id = filterRequest("archiv_id");

// جلب أسماء الصور المرتبطة
$stmtFiles = $con->prepare("SELECT file_name FROM files_name WHERE archiv_id = ?");
$stmtFiles->execute([$archiv_id]);
$files = $stmtFiles->fetchAll(PDO::FETCH_ASSOC);

// حذف الصور من المجلد
foreach ($files as $file) {
    $filePath = __DIR__ . "/../upload/" . basename($file['file_name']);
    if (file_exists($filePath) && is_file($filePath)) {
        unlink($filePath);
    }
}

// حذف مسارات الصور من جدول files_name
$delFiles = $con->prepare("DELETE FROM files_name WHERE archiv_id = ?");
$delFiles->execute([$archiv_id]);

// حذف السجل من جدول الأرشيف
$delArchive = $con->prepare("DELETE FROM archives WHERE id = ?");
$delArchive->execute([$archiv_id]);

if ($delArchive->rowCount() > 0) {
    echo json_encode(["status" => "success"]);
} else {
    echo json_encode(["status" => "error", "message" => "Archive not found"]);
}
?>
