// ignore_for_file: unused_local_variable

import 'package:doctor_appointment_app/SQL/sql.dart';
import 'package:logging/logging.dart';
// import 'package:signalr_netcore/hub_connection.dart';
// import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:signalr_netcore/signalr_client.dart';

class LiveServer {
  static HubConnection? hubConnection;

  static Future<void> Connect() async {
    try {
      await SQL.connection();

      if (hubConnection != null &&
          hubConnection!.state == HubConnectionState.Connected) {
        return;
      }

      Logger.root.level = Level.ALL;
      Logger.root.onRecord.listen((LogRecord rec) {
        print('${rec.level.name}: ${rec.time}: ${rec.message}');
      });

      final transportProtLogger = Logger("SignalR - transport");

      final httpOptions = HttpConnectionOptions(
        logger: transportProtLogger,
        requestTimeout: 5000,
      );

      String serverUrl = "http://${SQL.ip}:5000/chathub";

      print("Attempting to connect to SignalR server at $serverUrl");

      hubConnection = HubConnectionBuilder()
          .withUrl(serverUrl, options: httpOptions)
          .withAutomaticReconnect()
          .build();

      await hubConnection!.start();
      print("Connected to SignalR server");
    } catch (e) {
      print("Exception in SignalR connection: " + e.toString());
    }
  }

  static void Disconnect() async {
    try {
      if (hubConnection!.state != HubConnectionState.Disconnected) {
        await hubConnection!.stop();
      }
    } catch (e) {
      print("exception Disconnect" + e.toString());
    }
  }

  static Future<Object?> Send(String method, List<Object>? args) async {
    try {
      if (hubConnection!.state != HubConnectionState.Connected) {
        print(method +
            " connection is not connected" +
            hubConnection!.state.toString());
        await Connect();
        print(method + " connection is " + hubConnection!.state.toString());
      }
      return await hubConnection!.invoke(method, args: args);
    } catch (e) {
      print("");
      print("exception send:::$method " + e.toString());
    }
    return null;
  }

  static void On(String method, void Function(List<Object?>?) newMethod) async {
    try {
      if (hubConnection!.state != HubConnectionState.Connected) {
        await Connect();
      }
      hubConnection!.on(method, newMethod);
    } catch (e) {
      print("exception on" + e.toString());
    }
  }

  static void onclose(void Function({Exception? error}), callback) {
    try {
      hubConnection!.onclose(callback);
    } catch (e) {
      print("on close Error:: $e");
    }
  }

  static void onreconnected(
      void Function({String? connectionId}) callback) async {
    var res = await hubConnection!.onreconnected(callback);
    print("reson of reconnect $res");
  }
}
