import 'package:flutter/material.dart';
import 'package:local_storage/widget/colors_custom.dart';

import '../widget/input_field.dart';

class AddScreen extends StatelessWidget {
  AddScreen({super.key});
  var noteTitle = TextEditingController();
  var noteDescription = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBar,
        title: const Text('Add note'),
        actions: [
          IconButton(
            onPressed: () {},
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
