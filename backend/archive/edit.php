<?php
include "../connect.php";

// 1) جلب الحقول النصية
$archiv_id   = filterRequest("archiv_id");
$name        = filterRequest("name");
$date        = filterRequest("date");
$description = filterRequest("description");

// 2) صورة أو أكثر جديدة (multipart) تحت مفتاح new_files[]
//    وقائمة الصور المحذوفة JSON-encoded تحت deleted_files
$deletedJson = filterRequest("deleted_files", true); // استلام الصور المحذوفة كـ JSON
$deleted = json_decode($deletedJson, true) ?? []; // تحويل الـ JSON إلى مصفوفة PHP

// التحقق من الصور المحذوفة
if (!empty($deleted)) {
    foreach ($deleted as $fileToDelete) {
        $justName = basename($fileToDelete); // الحصول على اسم الصورة فقط
        $fullPath = __DIR__ . "/../upload/" . $justName;

        // حذف من السيرفر إن وجد
        if (file_exists($fullPath)) {
            unlink($fullPath);
        }

        // حذف من قاعدة البيانات دائمًا
        $delStmt = $con->prepare("DELETE FROM `files_name` WHERE archiv_id = ? AND file_name = ?");
        $delStmt->execute([$archiv_id, $justName]);

    }
}



// -- تحديث بيانات الأرشيف --
$upd = $con->prepare("
    UPDATE `archives`
    SET `name` = ?, `date` = ?, `description` = ?
    WHERE `id` = ?
");
$upd->execute([$name, $date, $description, $archiv_id]);

// -- رفع الصور الجديدة إن وُجدت --
if (!empty($_FILES['new_files'])) {
    // نفّذتُم سابقاً دالة imageupload() التي تعيد array من أسماء الملفات المرفوعة
    $newNames = imageupload('new_files');
    $ins = $con->prepare("
        INSERT INTO `files_name` (`file_name`, `archiv_id`)
        VALUES (?, ?)
    ");
    foreach ($newNames as $fname) {
        $ins->execute([$fname, $archiv_id]);
    }
}

echo json_encode(["status" => "success"]);
