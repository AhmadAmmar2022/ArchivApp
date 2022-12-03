<?php
include "connect.php"; 
$stmp = $con->prepare("DELETE FROM `users`  WHERE age=15 ");
$stmp->execute();
;
// $stmp->execute(array(  
//     "fi"=>"Roodi",
//     "la"=> "Ali",
//     "ag"=> "35" 
// ));
 $count= $stmp ->rowCount();
    if ( $count >0)
      {
        echo "succees";
         
      }
    else {
        echo "no -results";
    }

?>


<!-- update 
     $stmp = $con->prepare("UPDATE `users` SET firstname=? , lastname =? WHERE age=? ");
$stmp->execute(array(
  "saher" ,"jasme",15   
)); -->


 
<!-- echo "<pre>";
print_r($users);
echo "</pre>";
  
echo json_encode($users); -->
  

<!-- insert
    
$stmp = $con->prepare("INSERT INTO `users` (`firstname`, `lastname`, `age`) VALUES (:fi, :la, :ag) ");
$stmp->execute(array(
    "fi"=>"Roodi",
    "la"=> "Ali",
    "ag"=> "35"
)); -->
 
