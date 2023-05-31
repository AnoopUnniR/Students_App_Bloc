import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:register_student/db/model/data_model.dart';
import 'package:register_student/infrastructure/db_service_funct.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final DbServiceFunctions studentDbFunctions = DbServiceFunctions();

  HomePageBloc() : super(HomePageState.initial()) {
    on<HomePageEvent>((event, emit) async {
      //initial state
      emit(HomePageState(studentList: [], loading: false));

      //getting list
      final result = await studentDbFunctions.getStudents();

      //display
      emit(HomePageState(studentList: result, loading: false));
    });

    on<DeleteStudent>((event, emit) async {
      await studentDbFunctions.deleteStudentDetails(event.index);
      add(DisplayStudents());
    });

    on<EditStudent>((event, emit) async {
      await studentDbFunctions.updateStudentDetails(event.student);
      add(DisplayStudents());
    });
  }
}
