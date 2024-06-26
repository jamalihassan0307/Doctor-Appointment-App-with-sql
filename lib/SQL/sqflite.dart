import 'dart:io';
// import 'package:doctor_appointment_app/SQL/Sql_query.dart';
import 'package:doctor_appointment_app/SQL/sql.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLService {
  static Database? _db;

  static Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await openDB();
    return _db!;
  }

  static Future<void> deleteOldDatabase() async {
    try {
      String databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'doasql.db');
      print("Attempting to delete old database");

      if (await File(path).exists()) {
        await File(path).delete();
        print("Old database deleted");
      }
    } catch (e) {
      print("Error deleting old database: $e");
    }
  }

  static Future<Database> openDB() async {
    try {
      // await deleteOldDatabase();
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'doasql.db');

      Database db = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await createTables(db);
        },
      );
      print("Database opened successfully");
      _db = db;
      return db;
    } catch (e) {
      print("ERROR IN OPEN DATABASE: $e");
      throw Exception("Failed to open database: $e");
    }
  }

  static Future<void> createTables(Database db) async {
    try {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS AppointmentModel (
          id NVARCHAR(255) NOT NULL PRIMARY KEY,
          patientid NVARCHAR(255) NOT NULL,
          doctorid NVARCHAR(255) NOT NULL,
          
          slotsid NVARCHAR(255) NOT NULL,
          time NVARCHAR(255) NOT NULL,
          createdtime BIGINT NOT NULL,
          status INT NOT NULL,
          bio TEXT NOT NULL,
          rating FLOAT NULL
        );
      ''');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS  VisterUser (
        id VARCHAR(255)  PRIMARY KEY,
        patientid VARCHAR(255),
        doctorid VARCHAR(255));
      ''');

     await db.execute('''
  CREATE TABLE IF NOT EXISTS PatientModel (
    id VARCHAR(255) PRIMARY KEY,
    fullname VARCHAR(225),
    phonenumber VARCHAR(100),
    password VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    image NVARCHAR(225)
  );
''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS DoctorSlot (
          id NVARCHAR(255) NOT NULL PRIMARY KEY,
          indexn INT NULL,
          patientid NVARCHAR(255) NULL,
          doctorname NVARCHAR(255) NOT NULL,
          doctorid NVARCHAR(255) NOT NULL,
          startTime NVARCHAR(50) NOT NULL,
          endTime NVARCHAR(50) NOT NULL,
          patientName NVARCHAR(255) NULL,
          isAvailable BIT NOT NULL,
          date NVARCHAR(50) NOT NULL
        );
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS DoctorModel (
          id NVARCHAR(255) NOT NULL PRIMARY KEY,
          fullname NVARCHAR(255) NOT NULL,
          phonenumber NVARCHAR(50) NOT NULL,
          email NVARCHAR(50) UNIQUE,
          password NVARCHAR(255) NOT NULL,
          image NVARCHAR(225) NULL,
          bio NVARCHAR(225) NOT NULL,
          specialty NVARCHAR(255) NOT NULL,
          starttime NVARCHAR(50) NOT NULL,
          endtime NVARCHAR(50) NOT NULL,
          about NVARCHAR(225) NOT NULL,
          address VARCHAR(225) NOT NULL,
          maxAppointmentDuration INT NOT NULL,
          totalrating FLOAT NOT NULL,
          ratingperson INT NOT NULL,
          fee FLOAT NOT NULL
        );
      ''');

      print("Tables created successfully");
    } catch (e) {
      print("ERROR IN CREATE TABLE: $e");
      throw Exception("Failed to create tables: $e");
    }
  }
  static Future<void> dropDoctorListColumn() async {
   await _db?.transaction((txn) async {
      // Rename the original table
      await txn.execute("ALTER TABLE AppointmentModel RENAME TO temp_AppointmentModel");

      // Create the new table without the specified columns
      await txn.execute('''
        CREATE TABLE IF NOT EXISTS AppointmentModel (
          id NVARCHAR(255) NOT NULL PRIMARY KEY,
          patientid NVARCHAR(255) NOT NULL,
          doctorid NVARCHAR(255) NOT NULL,
          slotsid NVARCHAR(255) NOT NULL,
          time NVARCHAR(255) NOT NULL,
          createdtime BIGINT NOT NULL,
          status INT NOT NULL,
          bio TEXT NOT NULL,
          rating FLOAT NULL
        );
      ''');

      // Copy data from the old table to the new table
      await txn.execute('''
        INSERT INTO AppointmentModel (
          id, patientid, doctorid, slotsid, time, createdtime, status, bio, rating
        )
        SELECT 
          id, patientid, doctorid, slotsid, time, createdtime, status, bio, rating
        FROM temp_AppointmentModel
      ''');

      // Drop the old table
      await txn.execute("DROP TABLE temp_AppointmentModel");
    });

    print("Specified columns dropped and AppointmentModel table recreated successfully");
  
  } static Future<void> randomCreateTable(String query) async {
    try {
      await _db?.execute(query);
      print("Table created with query: $query");
    } catch (e) {
      print("ERROR IN CREATING TABLE: $e");
      throw Exception("Failed to create table: $e");
    }
  }

  static Future<List<String>> getAllTables() async {
   
      if (StaticData.localdatabase) {
         try {
         List<Map<String, Object?>>? result = await _db
          ?.rawQuery("SELECT name FROM sqlite_master WHERE type='table';");
          print("434534$result");
      List<String> tables =
          result!.map((row) => row['name'] as String).toList();
      return tables;
    } catch (e) {
      print("Error in getAllTables: $e");
      return [];
    }
      } else {
        print("asiudyuiwqd1");
         var results = await SQL.connectToSqlServerDirectlyPlugin.
         getRowsOfQueryResult("SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE';");
print("asiudyuiwqd${results}");
      // Process the results
     List<String> tables = [];
      for (var row in results) {
        tables.add(row['TABLE_NAME']);
      }


      return tables;
      }
     
  }

  static Future<List<Map<String, dynamic>>?> get(String query) async {
    try {
      print("Executing query: $query");
      return await _db?.rawQuery(query);
    } catch (e) {
      print("ERROR IN GET QUERY: $e");
      throw Exception("Failed to execute get query: $e");
    }
  }

  static Future<int?> post(String query) async {
    try {
      print("Executing insert query: $query");
      return await _db?.transaction((txn) async {
        return await txn.rawInsert(query);
      });
    } catch (e) {
      print("ERROR IN INSERT QUERY: $e");
      throw Exception("Failed to execute insert query: $e");
    }
  }

  // static Future<int?> update(String query) async {
  //   try {
  //     print("Executing update query: $query");
  //     return await _db?.rawUpdate(query);
  //   } catch (e) {
  //     print("ERROR IN UPDATE QUERY: $e");
  //     throw Exception("Failed to execute update query: $e");
  //   }
  // }
  static Future<int?> updateData(
      String tableName, Map<String, dynamic> map, String id) async {
    try {
      String query = 'UPDATE $tableName SET ';
      List<String> columns = [];
      List<dynamic> values = [];

      map.forEach((column, value) {
        columns.add('$column = ?');
        values.add(value);
      });

      query += columns.join(', ');
      query += ' WHERE id = ?';
      values.add(id);

      print("Executing update query: $query with values: $values");
      return await _db?.rawUpdate(query, values);
    } catch (e) {
      print("ERROR IN UPDATE QUERY: $e");
      throw Exception("Failed to execute update query: $e");
    }
  }

  static Future<int?> updateDataid(
    String tableName,
    Map<String, dynamic> map,
    Map<String, dynamic> mapid,
  ) async {
    try {
      String query = 'UPDATE $tableName SET ';
      List<String> columns = [];
      List<dynamic> values = [];

      map.forEach((column, value) {
        columns.add('$column = ?');
        values.add(value);
      });

      query += columns.join(', ');
      mapid.forEach((column, value) {
        query += ' WHERE $column = ? = ?';
        values.add(value);
      });

      print("Executing update query: $query with values: $values");
      return await _db?.rawUpdate(query, values);
    } catch (e) {
      print("ERROR IN UPDATE QUERY: $e");
      throw Exception("Failed to execute update query: $e");
    }
  }

  static Future<int?> delete(String query) async {
    try {
      print("Executing delete query: $query");
      return await _db?.rawDelete(query);
    } catch (e) {
      print("ERROR IN DELETE QUERY: $e");
      throw Exception("Failed to execute delete query: $e");
    }
  }
}
