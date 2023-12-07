import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:local_storage/controller/note_controller.dart';
import 'package:local_storage/model/note_model.dart';
import 'package:local_storage/view/add_screen.dart';
import 'package:local_storage/view/edit_screen.dart';
import 'package:local_storage/widget/colors_custom.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<NoteModel>>? list;
  late NoteController _controller;
  Future refresh() async {
    _controller = NoteController();
    setState(() {
      list = _controller.getData();
    });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBar,
        centerTitle: false,
        title: const Text(
          'Dating note',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddScreen(),
                  ));
            },
            icon: const Icon(
              Icons.add,
              size: 30,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<NoteModel>>(
        future: list,
        builder: (context, AsyncSnapshot<List<NoteModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Icon(
                Icons.info,
                color: Colors.red,
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var item = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditScreen(),
                              ),
                            );
                          },
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: 'Edit',
                        ),
                        SlidableAction(
                          onPressed: (context) {},
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Remove',
                        ),
                      ],
                    ),
                    child: SizedBox(
                      height: 80,
                      child: Card(
                        color: const Color.fromARGB(255, 235, 235, 235),
                        child: ListTile(
                          title: Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.description),
                              Text(item.date),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
