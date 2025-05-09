
<?php
define('mb', 1048576);
function filterRequest($request, $isJson = false) {
    $value = $_POST[$request] ?? $_GET[$request] ?? null;

    if ($value !== null) {
        return $isJson ? $value : htmlspecialchars(strip_tags($value));
    } else {
        // لا تطبع أي شيء هنا لتجنب كسر JSON
        return null;
    }
}

 

 function imageupload($Files)
{
    global $msgerror;

    $uploaded = $_FILES[$Files];

    // إذا كان ملف واحد وليس متعدد
    if (!is_array($uploaded['name'])) {
        $uploaded = [
            'name' => [$uploaded['name']],
            'tmp_name' => [$uploaded['tmp_name']],
            'size' => [$uploaded['size']]
        ];
    }

    $total = count($uploaded['name']);
    $file_name = [];

    for ($i = 0; $i < $total; $i++) {
        $imagename = rand(1000, 10000) . $uploaded['name'][$i];
        $imagetmp = $uploaded['tmp_name'][$i];
        $imagesize = $uploaded['size'][$i];

        $allowExt = ["png", "jpg", "gif", "pdf"];
        $ext = strtolower(pathinfo($imagename, PATHINFO_EXTENSION));

        if (!in_array($ext, $allowExt)) {
            $msgerror[] = "Ext";
        }

        if ($imagesize > 8 * 1024 * 1024) { // 8 MB
            $msgerror[] = "Size";
        }

        if (empty($msgerror)) {
            move_uploaded_file($imagetmp, "../upload/" . $imagename);
            $file_name[] = $imagename;
        } else {
            return "fail";
        }
    }

    return $file_name;
}




function  deleteFile($dir, $imagename)
{
   if (file_exists($dir . "/" . $imagename)) {
      unlink($dir . "/" . $imagename);
   }
}
?>