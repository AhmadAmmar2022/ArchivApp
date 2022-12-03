import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;



class  Request{
  
getRequest(String url)async{
  try{ 
    
    var response =await http.get(Uri.parse(url));
    if (response.statusCode==200)
       {
            var responsebody=jsonDecode(response.body);
            return responsebody;
       }
     }
  catch (e){
   print("==========================");
    print(e);
  }

}
postRequest(String url ,Map data)async{
  try{ 
    
    var response =await http.post(Uri.parse(url),body: data);
    if (response.statusCode==200)
       {
            var responsebody=jsonDecode(response.body);
            return responsebody;
       }
     else
        {
      
        print("${response.statusCode}");
    
         } 
     
     
     }
     
  catch (e){
    print("==========================>");
    print(e);
  }
}
}