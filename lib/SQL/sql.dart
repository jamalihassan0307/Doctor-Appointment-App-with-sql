import 'package:connect_to_sql_server_directly/connect_to_sql_server_directly.dart';
// import 'package:flutter/material.dart';

class SQL {
  static var database = "DOASQL";
  static var ip = "192.168.117.235";
  // static var ip = "192.168.100.7";
  // static var ip = "192.168.188.235";
  // static var ip = "192.168.137.205";
  static final connectToSqlServerDirectlyPlugin = ConnectToSqlServerDirectly();
  static Future connection()  {
   
 
    return  connectToSqlServerDirectlyPlugin.initializeConnection(
      ip,
      database,
      'ali',   
      '12345',
      instance: 'node',
    ); 
  }

  static Future post(String query) {
    print("query${query}");
    connection();
    return connectToSqlServerDirectlyPlugin.getStatusOfQueryResult(query);
  }
static Future get(String query) async {
  print("query: $query");
   connection();
  try {
  
    return connectToSqlServerDirectlyPlugin.getRowsOfQueryResult(query);
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
