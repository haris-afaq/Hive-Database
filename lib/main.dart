import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_database/models/notesModel.dart';
import 'package:hive_database/view/homeScreen.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  // add these lines to initalize hive
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  //Addding adapter to NotedModelAdapter
  Hive.registerAdapter(NotesModelAdapter());
  // Opening Box

  await Hive.openBox<NotesModel>('Notes');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Database',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
