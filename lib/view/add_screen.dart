import 'dart:math';

import 'package:flutter/material.dart';
import 'package:local_storage/controller/note_controller.dart';
import 'package:local_storage/model/note_model.dart';
import 'package:local_storage/widget/colors_custom.dart';

import '../widget/input_field.dart';
import 'home_screen.dart';

class AddScreen extends StatelessWidget {
  AddScreen({super.key});
  final noteTitle = TextEditingController();
  final noteDescription = TextEditingController();
  final date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBar,
        title: const Text('Add note'),
        actions: [
          IconButton(
            onPressed: () async {
              await NoteController()
                  .insertData(
                    NoteModel(
                      id: Random().nextInt(10000),
                      title: noteTitle.text,
                      description: noteDescription.text,
                      date: "${date.year}-${date.month}-${date.day}",
                    ),
                  )
                  .whenComplete(() => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                      (route) => false));
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFieldCustom(
              controller: noteTitle,
              hintText: 'Note title',
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldCustom(
              controller: noteDescription,
              hintText: 'Note description',
              maxLines: 10,
            )
          ],
        ),
      ),
    );
  }
}
