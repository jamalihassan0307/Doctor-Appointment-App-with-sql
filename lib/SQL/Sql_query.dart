// import 'dart:collection';

import 'package:doctor_appointment_app/SQL/sqflite.dart';
import 'package:doctor_appointment_app/SQL/sql.dart';
import 'package:doctor_appointment_app/model/admin/AppointmentModel.dart';
import 'package:doctor_appointment_app/model/admin/DoctorSlot.dart';
import 'package:doctor_appointment_app/model/massage.dart';
// import 'package:doctor_appointment_app/model/patient/patientmodel.dart';
import 'package:doctor_appointment_app/staticdata.dart';
// import 'package:sqflite/sqflite.dart';

class SQLQuery{
  
  
  
  //////////////////////////////////////////
  /////////////////////////////////////////////
  ////////////////////////////////////////////////
  ///
  ///             SQL CREATE TABLE
  ///
  /////////////////////////////////////////////////
  //////////////////////////////////////////////////
  
  static Future  createTable1(id1)async{
   var aa="CREATE TABLE ${id1} (toId VARCHAR(255),msg VARCHAR(MAX),readn VARCHAR(255),fromId VARCHAR(255),sent VARCHAR(255));";
  if (StaticData.localdatabase) {
    try {
    var result = await SQLService.randomCreateTable(aa);
    
return result;
  } catch (e) {
    print("Error in random_create_table: $e");
    return [];
  }
  } else {
    try {
    var result = await SQL.get(aa);
    
return result;
  } catch (e) {
    print("Error in createTable1: $e");
    return [];
  }
  }
 
  }

static Future  createTable2(name)async{
   var aa ="CREATE TABLE ${name} (toId VARCHAR(255),msg VARCHAR(MAX),readn VARCHAR(255),fromId VARCHAR(255),sent VARCHAR(255));";
  if (StaticData.localdatabase) {
    try {
    var result = await SQLService.randomCreateTable(aa);
    
return result;
  } catch (e) {
    print("Error in random_create_table: $e");
    return [];
  }
  } else {
    try {
    var result = await SQL.get(aa);
    
return result;
  } catch (e) {
    print("Error in createTable1: $e");
    return [];
  }
  }
 
  }
 
static Future  createTable3(name)async{
   var aa ="CREATE TABLE ${name} (id VARCHAR(255) PRIMARY KEY,indexn INT,patientid VARCHAR(255),doctorname VARCHAR(255),doctorid VARCHAR(255),startTime VARCHAR(255),endTime VARCHAR(255),patientName VARCHAR(255),isAvailable bit,date varchar(255));";
  if (StaticData.localdatabase) {
    try {
    var result = await SQLService.randomCreateTable(aa);
    
return result;
  } catch (e) {
    print("Error in random_create_table: $e");
    return [];
  }
  } else {
    try {
    var result = await SQL.get(aa);
    
return result;
  } catch (e) {
    print("Error in createTable1: $e");
    return [];
  }
  }
 
  }
 
  //////////////////////////////////////////
  /////////////////////////////////////////////
  ////////////////////////////////////////////////
  ///
  ///             SQL Simple data query
  ///
  /////////////////////////////////////////////////
  //////////////////////////////////////////////////
 


static Future  getdata(query)async{
  if (StaticData.localdatabase) {
    try {
    var result = await SQLService.get (query);
    
return result;
  } catch (e) {
    print("Error in Simple get query: $e");
    return [];
  }
  } else {
    try {
    var result = await SQL.get(query);
    
return result;
  } catch (e) {
    print("Error in  Simple get query: $e");
    return [];
  }
  }
 
  }
static Future  postdata(query)async{
  if (StaticData.localdatabase) {
    try {
    var result = await SQLService.post (query);
    print("hjvg$result");
    
return result;
  } catch (e) {
    print("Error in Simple post query: $e");
    return [];
  }
  } else {
    try {
    var result = await SQL.post(query);
    
return result;
  } catch (e) {
    print("Error in  Simple post query: $e");
    return [];
  }
  }
 
  }
   
static Future  updatedata(String tableName, Map<String, dynamic> map, String id,query)async{
  if (StaticData.localdatabase) {
    try {
    var result = await SQLService.updateData(tableName, map, id);
    
return result;
  } catch (e) {
    print("Error in Simple update query: $e");
    return [];
  }
  } else {
    try {
    var result = await SQL.Update(query);
    
return result;
  } catch (e) {
    print("Error in  Simple update query: $e");
    return [];
  }
  }
 
  }
static Future  deletedata(query)async{
  if (StaticData.localdatabase) {
    try {
    var result = await SQLService.delete (query);
    
return result;
  } catch (e) {
    print("Error in Simple update query: $e");
    return [];
  }
  } else {
    try {
    var result = await SQL.delete(query);
    
return result;
  } catch (e) {
    print("Error in  Simple update query: $e");
    return [];
  }
  }
 
  }
static Future  createTabledata(query)async{
  if (StaticData.localdatabase) {
    try {
    var result = await SQLService.randomCreateTable (query);
    
return result;
  } catch (e) {
    print("Error in Simple random_create_table query: $e");
    return [];
  }
  } else {
    try {
    var result = await SQL.post(query);
    
return result;
  } catch (e) {
    print("Error in  Simple random_create_table query: $e");
    return [];
  }
  }
 
  }

  //////////////////////////////////////////
  /////////////////////////////////////////////
  ////////////////////////////////////////////////
  ///
  ///             SQL GET Querys
  ///
  /////////////////////////////////////////////////
  //////////////////////////////////////////////////
static Future  getAllMessages(id1)async{
  if (StaticData.localdatabase) {
    try {
    var result = await SQLService.get ('SELECT * FROM $id1');
    
return result;
  } catch (e) {
    print("Error in getAllMessages: $e");
    return [];
  }
  } else {
    try {
    var result = await SQL.get('SELECT * FROM $id1');
    
return result;
  } catch (e) {
    print("Error in getAllMessages: $e");
    return [];
  }
  }
 
  }


static Future  getdoctorSlotes(id1)async{
  if (StaticData.localdatabase) {
    try {
    var result = await SQLService.get ('SELECT * FROM $id1');
    
return result;
  } catch (e) {
    print("Error in getdoctorSlotes: $e");
    return [];
  }
  } else {
    try {
    var result = await SQL.get('SELECT * FROM $id1');
    
return result;
  } catch (e) {
    print("Error in getdoctorSlotes: $e");
    return [];
  }
  }
 
  }
static Future  getpatientmessage(id1)async{
  if (StaticData.localdatabase) {
    try {
    var result = await SQLService.get ('SELECT * FROM $id1');
    
return result;
  } catch (e) {
    print("Error in getpatientmessage: $e");
    return [];
  }
  } else {
    try {
    var result = await SQL.get('SELECT * FROM $id1');
    
return result;
  } catch (e) {
    print("Error in getpatientmessage: $e");
    return [];
  }
  }
 
  }
static Future  getForSignin(query)async{
  if (StaticData.localdatabase) {
    
    try {
    var result = await SQLService.get (query);
    
return result;
  } catch (e) {
    print("Error in getpatient: $e");
    return [];
  }
  } else {
    try {
    var result = await SQL.get(query);
    
return result;
  } catch (e) {
    print("Error in getpatient: $e");
    return [];
  }
  }
 
  }




static Future  getAllDoctor()async{
  if (StaticData.localdatabase) {
    try {
    var result = await SQLService.get ('SELECT * FROM DoctorModel');
    
return result;
  } catch (e) {
    print("Error in getAllDoctor: $e");
    return [];
  }
  } else {
    try {
    var result = await SQL.get('SELECT * FROM DoctorModel');
    
return result;
  } catch (e) {
    print("Error in getAllDoctor: $e");
    return [];
  }
  }
 
  }
static Future  getAllpatient()async{
  if (StaticData.localdatabase) {
    try {
    var result = await SQLService.get ('SELECT * FROM PatientModel');
    
return result;
  } catch (e) {
    print("Error in PatientModel: $e");
    return [];
  }
  } else {
    try {
    var result = await SQL.get('SELECT * FROM PatientModel');
    
return result;
  } catch (e) {
    print("Error in PatientModel: $e");
    return [];
  }
  }
 
  }



static Future<List<Map<String, dynamic>>> getpatientmessageRead(String id1, String selectedJoinType, String id2) async {
  String query;

  if (selectedJoinType == 'FULL OUTER Join') {
    query = '''
      SELECT 
        ed.toId,
        ed.fromId,
        ed.msg, 
        ed.readn, 
        ed.sent
      FROM 
        $id1 ed
      LEFT JOIN
        $id2 bd
      ON 
        ed.toId = bd.toId

      UNION ALL

      SELECT 
        bd.toId,
        bd.fromId, 
        bd.msg, 
        bd.readn,
        bd.sent 
      FROM 
        $id2 bd
      LEFT JOIN
        $id1 ed
      ON 
        bd.toId = ed.toId
      WHERE 
        ed.toId IS NULL;
    ''';}
   else if (selectedJoinType == 'Right Join') {
    query = '''
      SELECT 
        ed.toId,
        ed.fromId,
        ed.msg, 
        ed.readn, 
        ed.sent
      FROM 
        $id2 ed
      LEFT JOIN
        $id1 bd
      ON 
        ed.toId = bd.toId

     
    ''';
  } else {
    query = '''
      SELECT 
        ed.toId,
        ed.fromId,
        ed.msg, 
        ed.readn, 
        ed.sent
      FROM 
        $id1 ed
      $selectedJoinType
        $id2 bd
      ON 
        ed.toId = bd.toId

    
    ''';
  }

  print("Executing query: $query");

  try {
    var result;
    if (StaticData.localdatabase) {
      result = await SQLService.get(query);
    } else {
      result = await SQL.get(query);
    }
    return result;
  } catch (e) {
    print("Error in getpatientmessage: $e");
    return [];
  }
}

static Future  getdotormessageRead(id1,selectedJoinType,id2)async{
  var query='';
  if (selectedJoinType == 'FULL OUTER Join') {
    query = '''
      SELECT 
        ed.toId,
        ed.fromId,
        ed.msg, 
        ed.readn, 
        ed.sent
      FROM 
        $id1 ed
      LEFT JOIN
        $id2 bd
      ON 
        ed.toId = bd.toId

      UNION ALL

      SELECT 
        bd.toId,
        bd.fromId, 
        bd.msg, 
        bd.readn,
        bd.sent 
      FROM 
        $id2 bd
      LEFT JOIN
        $id1 ed
      ON 
        bd.toId = ed.toId
      WHERE 
        ed.toId IS NULL;
    ''';}
  else if (selectedJoinType == 'Right Join') {
    query = '''
      SELECT 
        ed.toId,
        ed.fromId,
        ed.msg, 
        ed.readn, 
        ed.sent
      FROM 
        $id2 ed
      LEFT JOIN
        $id1 bd
      ON 
        ed.toId = bd.toId

     
    ''';
  } else {
    query = '''
      SELECT 
        ed.toId,
        ed.fromId,
        ed.msg, 
        ed.readn, 
        ed.sent
      FROM 
        $id1 ed
      $selectedJoinType
        $id2 bd
      ON 
        ed.toId = bd.toId

    
    ''';
  }
    print("query45667567$query");
  if (StaticData.localdatabase) {
    try {
    var result = await SQLService.get (query);
    
return result;
  } catch (e) {
    print("Error in getdotormessageRead: $e");
    return [];
  }
  } else {
    try {
    var result = await SQL.get(query);
    
return result;
  } catch (e) {
    print("Error in getdotormessageRead: $e");
    return [];
  }
  }
 
  }
  
  static Future  selectJoinType(queryType,doctorId)async{
    var query='';
     switch (queryType) {
    case 'WHERE':
      query = '''
        SELECT * FROM AppointmentModel
        WHERE status = 2 AND doctorid = '$doctorId'
      ''';
      break;

    case 'LIMIT':
    if(StaticData.localdatabase)
     query = '''
    SELECT * FROM AppointmentModel
    WHERE doctorid = '$doctorId'
    ORDER BY createdtime DESC
    LIMIT 10;
  ''';
  else
      query = '''
       SELECT top 10 * FROM AppointmentModel
        WHERE doctorid = '$doctorId'
      ORDER BY createdtime DESC
      ''';
      break;

    case 'ORDER BY':
      query = '''
        SELECT * FROM AppointmentModel
        WHERE doctorid = '$doctorId'
        ORDER BY rating DESC
      ''';
      break;

    case 'GROUP BY':
      query = '''
        SELECT patientname, COUNT(*) AS appointment_count 
        FROM AppointmentModel
        WHERE doctorid = '$doctorId'
        GROUP BY patientname
      ''';
      break;

    case 'HAVING':
      query = '''
        SELECT patientname, COUNT(rating) AS appointment_count
        FROM AppointmentModel
        WHERE doctorid = '$doctorId'
        GROUP BY patientname
        HAVING AVG(rating) > 3
      ''';
      break;

    default:
      query = '''
        SELECT * FROM AppointmentModel
        WHERE doctorid = '$doctorId'
      ''';
  }

  print("Executing query: $query");
  if (StaticData.localdatabase) {
    try {
    var result = await SQLService.get (query);
    
return result;
  } catch (e) {
    print("Error in selectJoinType: $e");
    return [];
  }
  } else {
    try {
    var result = await SQL.get(query);
    
return result;
  } catch (e) {
    print("Error in selectJoinType: $e");
    return [];
  }
  }
 
  }
  static Future  selectJoinTypePatient(queryType,patientId)async{
    var query='';
     switch (queryType) {
    case 'WHERE':
      query = '''
        SELECT * FROM AppointmentModel
        WHERE status = 2 AND patientid = '$patientId'
      ''';
      break;

    case 'LIMIT':
     if(StaticData.localdatabase)
     query = '''
    SELECT * FROM AppointmentModel
    WHERE patientid = '$patientId'
    ORDER BY createdtime DESC
    LIMIT 10;
  ''';
  else
      query = '''
       SELECT top 10 * FROM AppointmentModel
        WHERE patientid = '$patientId'
      ORDER BY createdtime DESC
      ''';
      break;

    case 'ORDER BY':
      query = '''
        SELECT * FROM AppointmentModel
        WHERE patientid = '$patientId'
        ORDER BY rating DESC
      ''';
      break;

    case 'GROUP BY':
      query = '''
        SELECT doctorname, COUNT(*) AS appointment_count 
        FROM AppointmentModel
        WHERE patientid = '$patientId'
        GROUP BY doctorname
      ''';
      break;

    case 'HAVING':
      query = '''
        SELECT doctorname, COUNT(rating) AS appointment_count
        FROM AppointmentModel
        WHERE patientid = '$patientId'
        GROUP BY doctorname
        HAVING AVG(rating) > 3
      ''';
      break;

    default:
      query = '''
        SELECT * FROM AppointmentModel
        WHERE patientid = '$patientId'
      ''';
  
  }

  print("Executing query: $query");
  if (StaticData.localdatabase) {
    try {
    var result = await SQLService.get (query);
    
return result;
  } catch (e) {
    print("Error in selectJoinTypePatient: $e");
    return [];
  }
  } else {
    try {
    var result = await SQL.get(query);
    
return result;
  } catch (e) {
    print("Error in selectJoinTypePatient: $e");
    return [];
  }
  }
 
  }




  //////////////////////////////////////////
  /////////////////////////////////////////////
  ////////////////////////////////////////////////
  ///
  ///             SQL POST Querys
  ///
  /////////////////////////////////////////////////
  //////////////////////////////////////////////////
  ///
  ///

static Future  postSendAllMessage(roomid,sendMessageList)async{
  String query = "INSERT INTO ${roomid} VALUES ";
  List<String> valuesList = [];
  
  for (var i = 0; i < sendMessageList.length; i++) {
    valuesList.add("(${sendMessageList[i].toJson()})");
  }
  
  query += valuesList.join(", ");
 
  if (StaticData.localdatabase) {
    try {
    var result = await SQLService.post(query);
    
return result;
  } catch (e) {
    print("Error in postSendAllMessage: $e");
    return [];
  }
  } else {
    try {
      
    var result = await   SQL.post(query);
    
return result;
  } catch (e) {
    print("Error in postSendAllMessage: $e");
    return [];
  }
  }
 
  }
static Future  postInsertData(id1,DoctorSlot  e)async{
   String query = "INSERT INTO ${id1} VALUES (${e.toMap()})";
  
  

  if (StaticData.localdatabase) {
    try {
    var result = await SQLService.post(query);
    
return result;
  } catch (e) {
    print("Error in postInsertData: $e");
    return [];
  }
  } else {
    try {
      
    var result = await   SQL.post(query);
    
return result;
  } catch (e) {
    print("Error in postInsertData: $e");
    return [];
  }
  }
 
  }
static Future  postInsertAppointment(AppointmentModel  model12)async{
   
                         String query   ="INSERT INTO AppointmentModel VALUES (${model12.toMap()})";


  if (StaticData.localdatabase) {
    try {
    var result = await SQLService.post(query);
    
return result;
  } catch (e) {
    print("Error in postInsertAppointment: $e");
    return [];
  }
  } else {
    try {
      
    var result = await   SQL.post(query);
    
return result;
  } catch (e) {
    print("Error in postInsertAppointment: $e");
    return [];
  }
  }
 
  }
  //////////////////////////////////////////
  /////////////////////////////////////////////
  ////////////////////////////////////////////////
  ///
  ///             SQL update table
  ///
  /////////////////////////////////////////////////
  //////////////////////////////////////////////////
  ///
  ///
  
static Future  updateSlotsStatus(id1,status,id)async{
    String query = "UPDATE ${id1} SET ";
      query += "isAvailable = $status";

      query += " WHERE id = '${id}'";


  if (StaticData.localdatabase) {
    try {  var map={
          'isAvailable':'${status}'
        };
    var result = await SQLService.updateData("${id1}", map, id);
    
return result;
  } catch (e) {
    print("Error in updateSlotsStatus: $e");
    return [];
  }
  } else {
    try {
      
    var result = await   SQL.Update(query);
    
return result;
  } catch (e) {
    print("Error in updateSlotsStatus: $e");
    return [];
  }
  }
 
  }
static Future  updateAppointmentStatus(status,id)async{
    String query = "UPDATE AppointmentModel SET ";
      query += "status = $status";

      query += " WHERE id = '${id}'";


  if (StaticData.localdatabase) {
    try {
        var map={
          'status':'${status}'
        };
    var result = await SQLService.updateData("AppointmentModel", map, id);
    
return result;
  } catch (e) {
    print("Error in updateAppointmentStatus: $e");
    return [];
  }
  } else {
    try {
      
    var result = await   SQL.Update(query);
    
return result;
  } catch (e) {
    print("Error in updateAppointmentStatus: $e");
    return [];
  }
  }
 
  }
static Future  updateRating(fullrating,id)async{
    String query = "UPDATE AppointmentModel SET ";
      query += "rating = $fullrating";

      query += " WHERE id = '${id}'";


  if (StaticData.localdatabase) {
    try {
        var map={
          'rating':'${fullrating}'
        };
    var result = await SQLService.updateData('AppointmentModel', map, id);
    
return result;
  } catch (e) {
    print("Error in updateAppointmentStatus: $e");
    return [];
  }
  } else {
    try {
      
    var result = await   SQL.Update(query);
    
return result;
  } catch (e) {
    print("Error in updateAppointmentStatus: $e");
    return [];
  }
  }
 
  }

static Future  updateDoctortotalRating(fullrating,id,total)async{
     String query = "UPDATE DoctorModel SET ";
      query += "totalrating = $fullrating";
      query += "ratingperson = $total";

      query += " WHERE id = '${id}'";


  if (StaticData.localdatabase) {
    try {
        var map={
          'totalrating':'${fullrating}',
          'ratingperson':'${total}'
        };
    var result = await SQLService.updateData('DoctorModel', map, id);
    
return result;
  } catch (e) {
    print("Error in updateAppointmentStatus: $e");
    return [];
  }
  } else {
    try {
      
    var result = await   SQL.Update(query);
    
return result;
  } catch (e) {
    print("Error in updateAppointmentStatus: $e");
    return [];
  }
  }
 
  }


static Future  updateMessageReadStatus(id1,Message message)async{
  String query = "UPDATE ${id1} SET ";
      query += "readn = '${DateTime.now().millisecondsSinceEpoch.toString()}'";

      query += " WHERE sent = '${message.sent}'";


  if (StaticData.localdatabase) {
    try {
  var map={
          'readn':'${DateTime.now().millisecondsSinceEpoch.toString()}'
        };
  var mapid={
          'sent':'${message.sent}'
        };
    var result = await SQLService.updateDataid('${id1}', map, mapid);
    
return result;
  } catch (e) {
    print("Error in updateMessageReadStatus: $e");
    return [];
  }
  } else {
    try {
      
    var result = await   SQL.Update(query);
    
return result;
  } catch (e) {
    print("Error in updateMessageReadStatus: $e");
    return [];
  }
  }
 
  }

static Future  updateSlotsStatus1(id1,status,id)async{
 
      String query = "UPDATE ${id1} SET ";
      query += "isAvailable = $status";

      query += " WHERE id = '${id}'";


  if (StaticData.localdatabase) {
    try {
        var map={
          'isAvailable':'${status}'
        };
    var result = await SQLService.updateData('$id1', map, id);
    
return result;
  } catch (e) {
    print("Error in updateSlotsStatus1: $e");
    return [];
  }
  } else {
    try {
      
    var result = await   SQL.Update(query);
    
return result;
  } catch (e) {
    print("Error in updateSlotsStatus1: $e");
    return [];
  }
  }
 
  }





  //////////////////////////////////////////
  /////////////////////////////////////////////
  ////////////////////////////////////////////////
  ///
  ///             SQL delect table
  ///
  /////////////////////////////////////////////////
  //////////////////////////////////////////////////
  ///
  ///

static Future  delecttable(name)async{
  String query = "drop table ${name}";
  
  
 
  if (StaticData.localdatabase) {
    try {
    var result = await SQLService.delete(query);
    
return result;
  } catch (e) {
    print("Error in delecttable: $e");
    return [];
  }
  } else {
    try {
      
    var result = await   SQL.delete(query);
    
return result;
  } catch (e) {
    print("Error in delecttable: $e");
    return [];
  }
  }
 
  }
static Future  deleteMessage(id1,Message message)async{
  String query = "DELETE FROM ${id1} WHERE sent='${message.sent}';";
  
  
 
  if (StaticData.localdatabase) {
    try {
    var result = await SQLService.delete(query);
    
return result;
  } catch (e) {
    print("Error in deleteMessage: $e");
    return [];
  }
  } else {
    try {
      
    var result = await   SQL.delete(query);
    
return result;
  } catch (e) {
    print("Error in deleteMessage: $e");
    return [];
  }
  }
 
  }




}
