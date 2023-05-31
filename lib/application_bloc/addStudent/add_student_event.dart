part of 'add_student_bloc.dart';


 class AddStudentEvent {}

class AddStudent extends AddStudentEvent {
  final StudentModel student;

  AddStudent({required this.student});

}