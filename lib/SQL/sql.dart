import 'package:connect_to_sql_server_directly/connect_to_sql_server_directly.dart';
// import 'package:flutter/material.dart';

class SQL {
  static var database = "DOASQL";
  // static var ip = "192.168.117.235";
  static var ip = "192.168.100.7";
  // static var ip = "192.168.88.235";
  // static var ip = "127.0.0.1";
  // static var ip = "192.168.188.235";
  
  // static var ip = "192.168.137.205";
  static final connectToSqlServerDirectlyPlugin = ConnectToSqlServerDirectly();
  static Future<void> connection() {
    return connectToSqlServerDirectlyPlugin.initializeConnection(
      ip,
      database,
      'ali',
      '12345',
      instance: 'node',
    );
  }

  static Future post(String query) async {
    print("query:4657894678464 $query");
    await connection();

    return connectToSqlServerDirectlyPlugin.getStatusOfQueryResult(query);
  }

  static Future delete(String query) {
    print("query: $query");
    // await connection();
    return connectToSqlServerDirectlyPlugin.getStatusOfQueryResult(query);
  }

  static Future<dynamic> get(String query) {
    print("query: $query");
    // await connection();
    return connectToSqlServerDirectlyPlugin.getRowsOfQueryResult(query);
  }

  static Future<dynamic> Update(String query) {
    print("query: $query");
    // await connection();
    return connectToSqlServerDirectlyPlugin.getStatusOfQueryResult(query);
  }
}
