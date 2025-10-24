import 'package:hive/hive.dart';
part 'notesModel.g.dart';
/*after ading part 'example.g.dart' run the below command in terminal

flutter packages pub run build_runner build

*/

/*
After this add the adopter in main.dart
*/

@HiveType(typeId: 0)
class NotesModel extends HiveObject {
  @HiveField(0)
  String? title;

  @HiveField(1)
  String? description;

  NotesModel({required this.title, this.description});
}
