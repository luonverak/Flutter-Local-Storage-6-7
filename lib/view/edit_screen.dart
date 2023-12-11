import 'package:flutter/material.dart';
import 'package:local_storage/controller/note_controller.dart';
import 'package:local_storage/model/note_model.dart';

import '../widget/colors_custom.dart';
import '../widget/input_field.dart';
import 'home_screen.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key, required this.model});
  final NoteModel model;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final date = DateTime.now();
  var noteTitle = TextEditingController();
  var noteDescription = TextEditingController();
  @override
  void initState() {
    noteTitle.text = widget.model.title;
    noteDescription.text = widget.model.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBar,
        title: const Text('Edit note'),
        actions: [
          IconButton(
            onPressed: () async {
              await NoteController()
                  .updateData(
                    NoteModel(
                      id: widget.model.id,
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
