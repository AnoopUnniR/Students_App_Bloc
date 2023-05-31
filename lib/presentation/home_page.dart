import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_student/application_bloc/homePage/home_page_bloc.dart';

import 'package:register_student/presentation/add_students.dart';
import 'package:register_student/presentation/search.dart';
import 'package:register_student/presentation/student_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomePageBloc>(context).add(DisplayStudents());
    // getAllStudents();
    return Scaffold(
      //title section
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: MySearch());
            },
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
        title: const Text(
          'STUDENT REGISTER',
        ),
      ),

      //List of students
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: BlocBuilder<HomePageBloc, HomePageState>(
                builder: (context, state) {
                  if (state.studentList.isEmpty) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Image.asset('lib/assets/no-data.webp'),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        const Text(
                          'No details added!',
                          style: TextStyle(
                              color: Colors.green,
                              decorationStyle: TextDecorationStyle.solid,
                              fontSize: 20),
                        ),
                        const Spacer(
                          flex: 1,
                        )
                      ],
                    );
                  }
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        final data = state.studentList[index];

                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 5,
                            right: 5,
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              foregroundImage: data.image.toString().isNotEmpty && data.image!=null
                                  ? NetworkImage(data.image.toString())
                                  : const NetworkImage(
                                      'https://th.bing.com/th?q=Profile+Logo&w=120&h=120&c=1&rs=1&qlt=90&cb=1&dpr=1.3&pid=InlineBlock&mkt=en-IN&cc=IN&setlang=en&adlt=moderate&t=1&mw=247'),
                            ),

                            //Delete Section
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: const Text(
                                        'Do you want to delete ?',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      content: Text(
                                        'Confirm to delete student ${data.name}',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            // deleteStudent(index);
                                            BlocProvider.of<HomePageBloc>(
                                                    context)
                                                .add(DeleteStudent(
                                                    index: index));
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Student Deleted Successfully',
                                                ),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          },
                                          child: const Text(
                                            'Delete',
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'Cancel',
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            title: Text(
                              data.name,
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) {
                                    return StudentDetails(
                                      data: data,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        );
                      },
                      separatorBuilder: ((context, index) {
                        return const Divider(
                          color: Colors.white,
                          thickness: 1,
                        );
                      }),
                      itemCount: state.studentList.length);
                },
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(
                        170,
                        50,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) => const AddStudents()),
                        ),
                      );
                    },
                    child: const Text(
                      'Add Student',
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
