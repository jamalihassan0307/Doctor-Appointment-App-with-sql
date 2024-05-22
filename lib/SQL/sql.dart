import 'package:connect_to_sql_server_directly/connect_to_sql_server_directly.dart';

class SQL {
  static var database = "DOASQL";
  static var ip = "192.168.100.7";
  static final connectToSqlServerDirectlyPlugin = ConnectToSqlServerDirectly();
  static Future<void> connection() {
    return connectToSqlServerDirectlyPlugin.initializeConnection(
      ip,
      // '192.168.1.48',
      database,
      'sa',
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
    await connection();
    try {
      var result =
          await connectToSqlServerDirectlyPlugin.getRowsOfQueryResult(query);
      if (result == null || result.isEmpty) {
        throw Exception("No data returned or query failed");
      }
      return result;
    } catch (e) {
      print("errrrrrre${e}");
      throw Exception("Failed to execute query: $e");
    }
  }

  static Future Update(String query) {
    print("query${query}");
    connection();
    return connectToSqlServerDirectlyPlugin.getStatusOfQueryResult(query);
  }
}
