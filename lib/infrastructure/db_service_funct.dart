import 'package:hive_flutter/adapters.dart';
import 'package:register_student/db/model/data_model.dart';

class DbServiceFunctions {
  Future<List<StudentModel>> getStudents() async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    return studentDB.values.toList();
  }

  Future<void> insertStudentDetails(StudentModel data) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    final id = await studentDB.add(data);
    data.id = id;
  }

  Future<void> deleteStudentDetails(int key) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.deleteAt(key);
  }

  Future updateStudentDetails(StudentModel data) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.put(data.id, data);
  }
}
