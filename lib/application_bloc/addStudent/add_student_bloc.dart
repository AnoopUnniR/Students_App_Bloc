import 'package:bloc/bloc.dart';
import 'package:register_student/db/model/data_model.dart';
import 'package:register_student/infrastructure/db_service_funct.dart';

part 'add_student_event.dart';
part 'add_student_state.dart';

class AddStudentBloc extends Bloc<AddStudentEvent, AddStudentState> {
  final DbServiceFunctions _studentDbFunctions = DbServiceFunctions();

  AddStudentBloc() : super(AddStudentState()) {
    on<AddStudent>((event, emit) async {
      await _studentDbFunctions.insertStudentDetails(event.student);
    });
  }
}
