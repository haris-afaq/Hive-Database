import 'package:hive_database/models/notesModel.dart';
import 'package:hive_flutter/adapters.dart';

class Boxes {
  static Box<NotesModel> getData = Hive.box<NotesModel>("Notes");
}
