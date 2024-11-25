import 'package:first_app/pages/pages.dart';
import 'package:first_app/repositories/setting_repository.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_app/repositories/quiz_repository.dart';

// void main() {
//   runApp(MyApp());
// }

void main() async {
  await Hive.initFlutter();
  SettingsResposity sr = await SettingsResposity.create();
  //quiz repo is private function therefore we need to create it before calling in repoprovidor
  QuizRepository qr = await QuizRepository.create(sr: sr);
  runApp(MyApp(qr: qr));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.qr}) : super(key: key);
  final QuizRepository qr;

  @override
  Widget build(BuildContext context) {
    //return RepositoryProvider(
    //  create: (context) => QuizRepository(), this two line so that the quiz code is loaded once only
    return RepositoryProvider(
      create: (context) => qr,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Homepage(),
      ),
    );
  }
}
