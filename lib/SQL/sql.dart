import 'package:connect_to_sql_server_directly/connect_to_sql_server_directly.dart';
import 'package:flutter/material.dart';

class SQL {
  static var database = "DOASQL";
  // static var ip = "192.168.100.7";
  // static var ip = "192.168.188.235";
  static var ip = "192.168.137.205";
  static final connectToSqlServerDirectlyPlugin = ConnectToSqlServerDirectly();
  static Future connection() async {
   
     await connectToSqlServerDirectlyPlugin.initializeConnection(
      ip,
      // '192.168.1.48',
      database,
      'ali',   
      '12345',
      instance: 'node',
    ).then(( a){
        //  if (a==null) {
           
        //  } else {
           
        //  } 
    print("errrrrrrorrrrrrrr${a}");  
    return Future(() => true);
    });
 
  
    return ;
  }

  static Future post(String query) {
    print("query${query}");
    connection();
    return connectToSqlServerDirectlyPlugin.getStatusOfQueryResult(query);
  }
static Future get(String query) async {
  print("query: $query");
  await connection();
  // return await connectToSqlServerDirectlyPlugin.getRowsOfQueryResult(query);
  try {
    var result =await connectToSqlServerDirectlyPlugin.getRowsOfQueryResult(query);
       
    if (result == null || result.isEmpty) {
      return Exception("No data returned or query failed");
    }
    return result;
  } catch (e) {
    print("Error occurred: $e");
  }
}


  static Future Update(String query) {
    print("query${query}");
    connection();
    return connectToSqlServerDirectlyPlugin.getStatusOfQueryResult(query);
  }
}
