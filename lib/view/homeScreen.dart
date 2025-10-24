import 'package:flutter/material.dart';
import 'package:hive_database/boxes/boxes.dart';
import 'package:hive_database/constants/bigText.dart';
import 'package:hive_database/constants/bodyText.dart';
import 'package:hive_database/constants/colors.dart';
import 'package:hive_database/models/notesModel.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        centerTitle: true,
        backgroundColor: AppColors.greenColor,
        title: Bigtext(title: "Hive Database", color: AppColors.whiteColor),
      ),

      body: ValueListenableBuilder(
        valueListenable: Boxes.getData.listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<NotesModel>();
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, Index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Card(
                  color: AppColors.whiteColor,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Bigtext(
                              title: data[Index].title.toString(),
                              color: AppColors.blackColor,
                            ),

                            Spacer(),
                            IconButton(
                              onPressed: () {
                                delete(data[Index]);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: AppColors.redColor,
                              ),
                            ),

                            IconButton(
                              onPressed: () {
                                _editDialoge(
                                  data[Index],
                                  data[Index].title.toString(),
                                  data[Index].description.toString(),
                                );
                              },
                              icon: Icon(
                                Icons.edit,
                                color: AppColors.greenColor,
                              ),
                            ),
                          ],
                        ),

                        Bodytext(
                          description: data[Index].description.toString(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),

      // body: ValueListenableBuilder(
      //   valueListenable: valueListenable,

      //   builder: builder,
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.greenColor,
        child: Icon(Icons.add, color: AppColors.whiteColor, size: 30),
        onPressed: () {
          _showDialogue();
          debugPrint("Button Pressed");
        },
      ),
    );
  }

  void delete(NotesModel notesModel) async {
    await notesModel.delete();
  }

  Future<void> _editDialoge(
    NotesModel notesModel,
    String title,
    String description,
  ) async {
    titleController.text = title;
    descriptionController.text = description;

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Bigtext(title: "Edit Notes"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  cursorColor: AppColors.greenColor,
                  controller: titleController,
                  decoration: InputDecoration(
                    hint: Text("Title"),
                    // border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: AppColors.greyColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: AppColors.greenColor),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  cursorColor: AppColors.greenColor,
                  maxLines: 5,
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hint: Text("Description"),
                    // border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: AppColors.greyColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: AppColors.greenColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: AppColors.redColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.greenColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(3),
                ),
              ),
              onPressed: () async {
                //Saving Edited Title and Description
                notesModel.title = titleController.text.toString();
                notesModel.description = descriptionController.text.toString();
                await notesModel.save();

                // Clearing the title and Description

                titleController.clear();
                descriptionController.clear();
                Navigator.pop(context);
              },
              child: Text(
                "Done",
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDialogue() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Bigtext(title: "Add Notes"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  cursorColor: AppColors.greenColor,
                  controller: titleController,
                  decoration: InputDecoration(
                    hint: Text("Title"),
                    // border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: AppColors.greyColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: AppColors.greenColor),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  cursorColor: AppColors.greenColor,
                  maxLines: 5,
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hint: Text("Description"),
                    // border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: AppColors.greyColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: AppColors.greenColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: AppColors.redColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.greenColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(3),
                ),
              ),
              onPressed: () {
                final data = NotesModel(
                  title: titleController.text,
                  description: descriptionController.text,
                );

                final box = Boxes.getData;
                box.add(data);

                data.save();

                titleController.clear();
                descriptionController.clear();

                Navigator.pop(context);
              },
              child: Text(
                "Add",
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
