import 'package:first_app/pages/home/cubit/home_page_cubit.dart';
import 'package:first_app/pages/home/widgets/widgets.dart';
import 'package:first_app/repositories/quiz_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homepage extends StatelessWidget {
  const Homepage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit(
        qr: context.read<QuizRepository>()), // gives access to cubit of quiz repo
      child: Scaffold(
        appBar: AppBar(
          
          centerTitle: true,
          elevation: 4,
          backgroundColor: Colors.teal.shade600, // Teal color for the app bar
          title: Text(
            'Quiz App',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 0, 0, 0),
              letterSpacing: 1.5,
            ),
          ),
          actions: [
            Tooltip(
              message: 'Admin Access',
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DevPage()));
                },
                icon: Icon(Icons.admin_panel_settings, color: Colors.white),
                label: Text(
                  'Dev',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 99, 88, 88),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 2,
                ),
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            // Apply teal to orange gradient background
            gradient: LinearGradient(
              colors: [
                Colors.teal.shade300,  // Starting color (teal)
                const Color.fromARGB(255, 23, 55, 56), // Ending color (orange)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: BlocBuilder<HomePageCubit, HomePageState>(
            builder: (context, state) {
              if (state is HomePageLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is HomePageLoaded) {
                return Column(
                  children: [
                    categories(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.quizzes.length,
                        itemBuilder: (context, index) => QuizCard(quiz: state.quizzes[index]),
                      ),
                    ),
                  ],
                );
              } else {
                return Text('Error');
              }
            },
          ),
        ),
      ),
    );
  }
}

// Elevated button on the home page appbar
class DevPage extends StatelessWidget {
  const DevPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dev Page"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              context.read<QuizRepository>().emptyHive();
            },
            child: Text('Empty Hive'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<QuizRepository>().checkForUpdate(force: true);
            },
            child: Text('Force Update'),
          ),
        ],
      ),
    );
  }
}
