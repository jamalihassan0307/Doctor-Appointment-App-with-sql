import 'package:cloud_firestore/cloud_firestore.dart';
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

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(String chatid) {
    return firestore
        .collection('chatroom')
        .doc(chatid)
        .collection('chats')
        .orderBy('sent', descending: true)
        .snapshots();
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
    //message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    //message to send
    final Message message =
        Message(toId: rid, msg: msg, read: '', fromId: from, sent: time);

    final ref = firestore
        .collection('chatroom')
        .doc(StaticData.chatRoomId(rid, from))
        .collection('chats');
    await ref.doc(time).set(message.toJson()).then((value) {});
    StaticData.sendNotifcation(name, msg, tokken);
  }
}
