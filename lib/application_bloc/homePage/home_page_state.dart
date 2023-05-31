part of 'home_page_bloc.dart';

class HomePageState {
  final List<StudentModel> studentList;
  final bool loading;

  HomePageState({required this.studentList, required this.loading});

  factory HomePageState.initial() {
    return HomePageState(studentList: [], loading: false);
  }
}
