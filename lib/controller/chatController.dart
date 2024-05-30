import 'package:doctor_appointment_app/SQL/sql.dart';
import 'package:doctor_appointment_app/model/massage.dart';
// import 'package:doctor_appointment_app/staticdata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  static ChatController get my => Get.find();
  bool showEmoji = false;
  final textController = TextEditingController();
  List<Message> list = [];


  sendallsms(String roomid) {
    print("smssmsmsmsm${sendMessageList.length}");
  String query = "INSERT INTO dbo.${roomid} VALUES ";
  List<String> valuesList = [];
  
  for (var i = 0; i < sendMessageList.length; i++) {
    valuesList.add("(${sendMessageList[i].toJson()})");
  }
  sendMessageList.clear();
  query += valuesList.join(", ");
  
  SQL.post(query);
}


  Future getAllMessages(String chatid) async {
   list.clear();
    String id1 = chatid.replaceAll(RegExp(r'[^a-zA-Z]'), '');
    print("data1${chatid}  sdsf${id1}");
    var value = await SQL.get("select * from dbo.${id1}").then((value) {
      if (value==null) {
         list.clear();
      } else {
        print("errrrrrrrrrr$value");
        try {
            List<Map<String, dynamic>> tempResult =
                  value.cast<Map<String, dynamic>>();
             

              for (var e in tempResult) {
                list.add(Message.fromJson(e));
                update();
              }
              list.sort(
      (a, b) => b.sent!.compareTo(a.sent!),
    );update();
        } catch (e) {
          print("iyfryu$e");
        }
         
      }
   
    });
    print("asdasdadas${list}");
    update(["sms"]);
    return value;

  }

  Future<void> updateMessageReadStatus(Message message, String chatid) async {
     String id1 = chatid.replaceAll(RegExp(r'[^a-zA-Z]'), '');
    print("data1${chatid}  sdsf${id1}");
    // firestore
    //     .collection('chatroom')
    //     .doc(chatid)
    //     .collection('chats')
    //     .doc(message.sent)
    //     .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
     try {
      String query = "UPDATE dbo.${id1} SET ";
      query += "readn = '${DateTime.now().millisecondsSinceEpoch.toString()}'";

      query += " WHERE sent = '${message.sent}'";
      SQL.Update(query);
    } catch (e) {
      print("errrrrro${e}");
    }
  }

  Future<void> deleteMessage(Message message, String chatid) async {
    if (list.any((element) => element.sent==message.sent)) {
      list.removeWhere((element) => element.sent==message.sent);
      
      print("found");
      update();
    } else {
      print("skip not found");
    }
    
     String id1 = chatid.replaceAll(RegExp(r'[^a-zA-Z]'), '');
   
         try {
      String query = "DELETE FROM dbo.${id1} WHERE sent='${message.sent}';";
      SQL.post(query);
    } catch (e) {
    }
  }
listupdate(message){ 


 list.add(message);
    print("adddddddddddd");
    update(["sms"]);  list.sort(
      (a, b) => b.sent!.compareTo(a.sent!),
    );

}
List<Message> sendMessageList=[];
   sendMessage(String rid, String msg, String from, String image,
     String name)  {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    // String name = StaticData.chatRoomId(from, rid);

    // String id1 = name.replaceAll(RegExp(r'[^a-zA-Z]'), '');
    final Message message =
        Message(toId: rid, msg: msg, readn: '', fromId: from, sent: time);
        
                       textController.text = '';
   listupdate(message);
   sendMessageList.add(message);
   
//     try {
//        SQL
//           .get("INSERT INTO dbo.${id1} VALUES (${message.toJson()})")
//           .then((value)  {
//         try {
//           if (value[0].toString().substring(0, 4) == "Invalid ") {
//             print("errrrrrrrrrrrrror2131");
//               // SQL
//               //   .get("INSERT INTO dbo.${id1} VALUES (${message.toJson()})");
//           }
//         } catch (e) {
// //           print("asddafdsf${value[0]}");
// //           if (value[0] == "E") { 
// //             var a= SQL.get(
// //                 "CREATE TABLE ${id1} (toId VARCHAR(255),msg VARCHAR(MAX),readn VARCHAR(255),fromId VARCHAR(255),sent VARCHAR(255));");
// // if (a=="Error: java.sql.SQLException: There is already an object named '$id1' in the database.") {
// //   print("table exist already");
// // }else{  SQL
// //                 .get("INSERT INTO dbo.${id1} VALUES (${message.toJson()})");
// // print("gdgdggi76786868");
// // }
           
          
//           // } else {
//           //   print("errrrrrrrrrrrrror");
//           //  }

//           // print("errrrrrrrrrrrrror");
//           // await SQL.get(
//           //     "CREATE TABLE ${id1} (toId VARCHAR(255),msg VARCHAR(MAX),readn VARCHAR(255),fromId VARCHAR(255),sent VARCHAR(255));");
//           // await SQL.get("INSERT INTO dbo.${id1} VALUES (${message.toJson()})");
//         }
      // });
    // } catch (e) {}

  }
}
