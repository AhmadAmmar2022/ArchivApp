<?php
include "../connect.php";

$type_id = filterRequest("type_id");

// جلب جميع الأرشيفات التابعة لهذا المجلد
$stmtArchives = $con->prepare("SELECT id FROM archives WHERE type_id = ?");
$stmtArchives->execute([$type_id]);
$archives = $stmtArchives->fetchAll(PDO::FETCH_ASSOC);

foreach ($archives as $archive) {
    $archiv_id = $archive['id'];

    // جلب الصور المرتبطة بكل أرشيف
    $stmtFiles = $con->prepare("SELECT file_name FROM files_name WHERE archiv_id = ?");
    $stmtFiles->execute([$archiv_id]);
    $files = $stmtFiles->fetchAll(PDO::FETCH_ASSOC);

    // حذف الصور من السيرفر
    foreach ($files as $file) {
        $filePath = __DIR__ . "/../upload/" . basename($file['file_name']);
        if (file_exists($filePath)) {
            unlink($filePath);
        }
    }

    // حذف الصور من قاعدة البيانات
    $delFiles = $con->prepare("DELETE FROM files_name WHERE archiv_id = ?");
    $delFiles->execute([$archiv_id]);

    // حذف الأرشيف نفسه
    $delArchive = $con->prepare("DELETE FROM archives WHERE id = ?");
    $delArchive->execute([$archiv_id]);
}

// أخيرًا، حذف المجلد نفسه
$delType = $con->prepare("DELETE FROM  doctype  WHERE type_id = ?");
$delType->execute([$type_id]);

if ($delType->rowCount() > 0) {
    echo json_encode(["status" => "success"]);
} else {
    echo json_encode(["status" => "error", "message" => "لم يتم العثور على المجلد"]);
}
