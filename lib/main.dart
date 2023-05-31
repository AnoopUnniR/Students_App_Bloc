import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:register_student/application_bloc/addStudent/add_student_bloc.dart';
import 'package:register_student/application_bloc/homePage/home_page_bloc.dart';
import 'package:register_student/db/model/data_model.dart';
import 'package:register_student/presentation/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }

  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>AddStudentBloc(),
        ),
        BlocProvider(
          create: (context) =>HomePageBloc(),
        ),
      ],
      child: MaterialApp(
         debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.light(),
        home: const HomePage(),
      ),
    );
  }
}

