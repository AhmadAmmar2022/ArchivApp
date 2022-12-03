<?php 
 function filterRequest($requst) {
   
 return htmlspecialchars(strip_tags($_POST[$requst]));
    
  
 }
?>