import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment_app/SQL/sql.dart';
import 'package:doctor_appointment_app/model/massage.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  static ChatController get my => Get.find();
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static FirebaseStorage storage = FirebaseStorage.instance;
  bool showEmoji = false;
  final textController = TextEditingController();
  List<Message> list = [];
  Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(String chatid) {
    return firestore
        .collection('chatroom')
        .doc(chatid)
        .collection('chats')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  // Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(String id) {
  //   return firestore
  //       .collection('Admin')
  //       .where('id', isEqualTo: id)
  //       .snapshots();
  // }

  Future getAllMessages(String chatid) async {
    String id1 = chatid.substring(0, 20).replaceAll(RegExp(r'[^a-zA-Z]'), '');
    print("data1${chatid}  sdsf${id1}");
    var value = await SQL.get("select * from dbo.${id1}");
    print("asdasdadas${value}");
    return value;

    // return firestore
    //     .collection('chatroom')
    //     .doc(chatid)
    //     .collection('chats')
    //     .orderBy('sent', descending: true)
    //     .snapshots();
  }

  Future<void> updateMessageReadStatus(Message message, String chatid) async {
    firestore
        .collection('chatroom')
        .doc(chatid)
        .collection('chats')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  Future<void> deleteMessage(Message message, String chatid) async {
    await firestore
        .collection('chatroom')
        .doc(chatid)
        .collection('chats')
        .doc(message.sent)
        .delete();
  }

  Future<void> sendMessage(String rid, String msg, String from, String image,
      String tokken, String name) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    String name = StaticData.chatRoomId(from, rid);

    String id1 = name.substring(0, 20).replaceAll(RegExp(r'[^a-zA-Z]'), '');
    final Message message =
        Message(toId: rid, msg: msg, readS: '', fromId: from, sent: time);
    list.add(message);
    print("adddddddddddd");
    update(["sms"]);

    list.sort(
      (a, b) => b.sent!.compareTo(a.sent!),
    );

    try {
      await SQL
          .get("INSERT INTO dbo.${id1} VALUES (${message.toJson()})")
          .then((value) async {
        try {
          if (value[0].toString().substring(0, 4) == "Invalid ") {
            print("errrrrrrrrrrrrror2131");
            await SQL.get(
                "CREATE TABLE ${id1} (toId VARCHAR(255),msg VARCHAR(MAX),readn VARCHAR(255),fromId VARCHAR(255),sent VARCHAR(255));");
            await SQL
                .get("INSERT INTO dbo.${id1} VALUES (${message.toJson()})");
          }
        } catch (e) {
          print("asddafdsf${value[0]}");
          if (value[0] == "E") {
          } else {
            print("errrrrrrrrrrrrror");
            await SQL.get(
                "CREATE TABLE ${id1} (toId VARCHAR(255),msg VARCHAR(MAX),readn VARCHAR(255),fromId VARCHAR(255),sent VARCHAR(255));");
            await SQL
                .get("INSERT INTO dbo.${id1} VALUES (${message.toJson()})");
          }

          // print("errrrrrrrrrrrrror");
          // await SQL.get(
          //     "CREATE TABLE ${id1} (toId VARCHAR(255),msg VARCHAR(MAX),readn VARCHAR(255),fromId VARCHAR(255),sent VARCHAR(255));");
          // await SQL.get("INSERT INTO dbo.${id1} VALUES (${message.toJson()})");
        }
      });
    } catch (e) {}
    // final ref = firestore
    //     .collection('chatroom')
    //     .doc(StaticData.chatRoomId(rid, from))
    //     .collection('chats');
    // await ref.doc(time).set(message.toJson()).then((value) {});

    // StaticData.sendNotifcation(name, msg, tokken);
  }
}
