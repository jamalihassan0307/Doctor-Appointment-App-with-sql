import 'package:doctor_appointment_app/SQL/Sql_query.dart';
import 'package:doctor_appointment_app/SQL/sqflite.dart';
import 'package:doctor_appointment_app/SQL/sql.dart';
import 'package:doctor_appointment_app/model/massage.dart';
import 'package:doctor_appointment_app/staticdata.dart';
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
  SQLQuery.postSendAllMessage(roomid, sendMessageList).then((value){
    sendMessageList.clear();
  });
}


  Future getAllMessages(String chatid) async {
   list.clear();
    String id1 = chatid.replaceAll(RegExp(r'[^a-zA-Z]'), '');
    print("data1${chatid}  sdsf${id1}");
    var value = await SQLQuery.getAllMessages(id1).then((value) {
      
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
      
      SQLQuery.updateMessageReadStatus(id1, message);
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
     
      SQLQuery.deleteMessage(id1, message);
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
     String name)  async {
      
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    String name = StaticData.chatRoomId(from, rid);
    String id1 = name.replaceAll(RegExp(r'[^a-zA-Z]'), '');
    final Message message =
        Message(toId: rid, msg: msg, readn: '', fromId: from, sent: time);
        list.add(message);
          list.sort(
      (a, b) => b.sent!.compareTo(a.sent!),
    );
        textController.clear();
        update();
   var createTableQuery = '''
  CREATE TABLE IF NOT EXISTS ${id1}  (
    toId TEXT,
    msg TEXT,
    readn TEXT,
    fromId TEXT,
    sent TEXT
  )
  ''';

  // var insertQuery = '''
  // INSERT INTO ${id1} (id, toId, msg, readn, fromId, sent) VALUES (
  //   '${message.toId}',
  //   '${message.msg}',
  //   '${message.readn}',
  //   '${message.fromId}',
  //   '${message.sent}'
  // )
  // ''';
var query='INSERT INTO ${id1} VALUES (${message.toJson()})';
    try {
      if (StaticData.localdatabase) {
   await SQLService.post(createTableQuery);
      try {
    var result = await SQLService.post(query);
    print("resultresult${result.toString()}");

  } catch (e) {
    print("Error in updateprofile: $e");
 
  }
       }else{
 try {
      
    var result = await   SQL.Update(query);
    print("resultresult${result.toString()}");

  } catch (e) {
    print("Error in updateprofile: $e");
    
  }
       }
      
        
    } catch (e) {}

  }
}
