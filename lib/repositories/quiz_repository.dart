import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:first_app/models/models.dart';
import 'package:first_app/repositories/setting_repository.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';

class QuizRepository {
  //create a hive to store the quiz and register the adaptor
  final Box _box; //box contains the all quiz and _quiz has access to the box
  final SettingsResposity _settingsResposity;
  QuizRepository._({required Box box, required SettingsResposity sr})
      : _box = box,
        _settingsResposity = sr;

  static Future<QuizRepository> create({required SettingsResposity sr}) async {
    // as it is static function we can access private _box (it return the quiz repo)
    //register adaptor
    //register quizadaptor
    Hive.registerAdapter(QuizAdapter());
    //register questionadaptor
    Hive.registerAdapter(QuestionAdapter());
    //register the answer adaptor
    Hive.registerAdapter(AnswerAdapter());

    Box box = await Hive.openBox('quiz'); //waiting box to be opened
    return QuizRepository._(box: box, sr: sr); //passing box to quiz repo
  }

  // //get a list of all the quizes which are going to be displayed on the home screen

  List<Quiz> loadQuizList() {
    return _box.values.cast<Quiz>().toList();
  }

  Quiz getQuiz(String key) {
    return _box.get(key, defaultValue: Quiz.empty());
  }

  //function to load data into hive\
  Future<void> storeData(String data) async {
    //load json from bundle
    // var json = jsonDecode(await rootBundle.loadString('assets/quiz.json'));
    var json = jsonDecode(data);

    // print(json); // our program doest know its a quiz
    for (var data in json) {
      Quiz quiz = Quiz.fromMap(data);
      print(quiz.name);
      _box.put(quiz.id, quiz);
    }
  }

  Future<void> checkForUpdate({bool force = false}) async {
  DateTime lastUpdated = _settingsResposity.lastUpdated;

  // Check if update is needed based on time
  if (DateTime.now().difference(lastUpdated) > Duration(minutes: 1)) {
    print("Do our update");
    try {
      // Try fetching the file from the server
      var resp = await http
          .get(Uri.parse('http://localhost:56890/server/quiz.json'))
          .timeout(
            Duration(seconds: 10),
            onTimeout: () => throw TimeoutException("Request timed out"),
          );
      
      // Store the fetched data
      storeData(resp.body);
      _settingsResposity.lastUpdated = DateTime.now();
    } catch (e) {
      print("Failed to fetch data from server: $e");
      
      // Load the fallback JSON from assets if the server fails
      if (_box.isEmpty) {
        try {
          String data = await rootBundle.loadString('assets/quiz.json');
          storeData(data);
        } catch (assetError) {
          print("Failed to load fallback JSON from assets: $assetError");
        }
      }
      return;
    }
  }
}


  void emptyHive() {
    _box.clear();
  }
}
