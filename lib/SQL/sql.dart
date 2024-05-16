import 'package:connect_to_sql_server_directly/connect_to_sql_server_directly.dart';

class SQL {
  static var database = "DOASQL";
  static final connectToSqlServerDirectlyPlugin = ConnectToSqlServerDirectly();
  static Future<void> connection() {
    return connectToSqlServerDirectlyPlugin.initializeConnection(
      '192.168.100.7',
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

  static Future get(String query) {
    print("query${query}");
    connection();
    return connectToSqlServerDirectlyPlugin.getRowsOfQueryResult(query);
  }

  static Future Update(String query) {
    print("query${query}");
    connection();
    return connectToSqlServerDirectlyPlugin.getStatusOfQueryResult(query);
  }
}
