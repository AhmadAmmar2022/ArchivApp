
<?php
define('mb', 1048576);
function filterRequest($requst)
{

   return htmlspecialchars(strip_tags($_POST[$requst]));
}


function  imageupload($imagerequesrt)
{
   global $msgerror;
   $imagename = rand(1000, 10000).$_FILES[$imagerequesrt]['name'];
   $imagetmp = $_FILES[$imagerequesrt]['tmp_name'];
   $imagesize = $_FILES[$imagerequesrt]['size'];
   $allowExt = array("png", "jpg", "gif", "pdf");
   $stringtoarray = explode(".", $imagename);
   $ext = end($stringtoarray);
   $ext = strtolower($ext);
   if (!empty($imagename) && !in_array($ext, $allowExt)) {
      $msgerror[] = "Ext";
   }
   if ($imagesize >5 * mb) {
      $msgerror[] = "size ";
   }
   if (empty($msgerror)) {
      move_uploaded_file($imagetmp, "../upload/".$imagename);
      return $imagename;
   } else {
      return "fail";
    
   }
}

 function  deleteFile($dir,$imagename){
    if (file_exists($dir."/".$imagename))
    {
        unlink($dir ."/".$imagename );
    }
 }
?>