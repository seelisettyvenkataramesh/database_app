 
import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'Employees..dart';
void main() async{


  WidgetsFlutterBinding.ensureInitialized();

 final database = openDatabase(
   
   join(await getDatabasesPath(),'emp_database.db'),
   onCreate: (db,version){
     return db.execute(
       'CREATE TABLE Employees(id INTEGER PRIMARY KEY,name TEXT,email TEXT)',

     );


  },
   version: 1,
 );

 Future<List<Employees>> EmployeeList() async {

   final db = await database;
   final List<Map<String,dynamic>> maps = await db.query('Employees');
       return  List.generate(maps.length, (index) {
         return Employees(id: maps [index]['id'], name:maps [index]['name'], email: maps[index]['email']);
       });

 }
 print(await EmployeeList());

 Future<void>updateEmployees(Employees,employees)async {

   final db = await database;

   await db.update('Employees',
       employees.toMap(),
     where: 'id=?',
     whereArgs: [employees.id],
    );

 }
  Future<void>deleteEmployees(int id)async {

    final db = await database;

    await db.delete('Employees',

      where: 'id=?',
      whereArgs: [id],
    );

  }
  Future<void>insertEmployee(Employees employees) async{
final db =await database;

await db.insert('Employees', employees.toMap(),
conflictAlgorithm: ConflictAlgorithm.replace);
 }




 var ramesh = Employees(id: 01, name: "Ramesh", email: 'Ramesh@gmail.com');
  var suresh = Employees(id: 02, name: "Suresh", email: 'Suresh@gmail.com');
  var adi = Employees(id: 03, name: "AdiLakshmi", email: 'Adilakshmi@gmail.com');
  var kesava=Employees(id: 04, name: 'kesava', email: 'kesava@gmail.com');

  ramesh = Employees(id: ramesh.id+6, name: ramesh.name, email: ramesh.email);
  await updateEmployees(ramesh, ramesh);

await insertEmployee(ramesh);
await insertEmployee(suresh);
await insertEmployee(adi);
await insertEmployee(kesava);
}



