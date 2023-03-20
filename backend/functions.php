
<?php
define('mb', 1048576);
function filterRequest($requst)
{

   return htmlspecialchars(strip_tags($_POST[$requst]));
}


function  imageupload($Files)
{


   global $msgerror;
   $total = count($_FILES['file']['name']);
   echo $total;
   $file_name =  array();
   for ($i = 0; $i < $total; $i++) {

      $imagename = rand(1000, 10000) . $_FILES[$Files]['name'][$i];
      $imagetmp = $_FILES[$Files]['tmp_name'][$i];
      $imagesize = $_FILES[$Files]['size'][$i]; // i
      $allowExt = array("png", "jpg", "gif", "pdf");
      $stringtoarray = explode(".", $imagename);
      $ext = end($stringtoarray);
      $ext = strtolower($ext);
      if (!empty($imagename) && !in_array($ext, $allowExt)) {
         $msgerror[] = "Ext";
      }
      if ($imagesize > 8 * mb) {
         $msgerror[] = "size ";
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