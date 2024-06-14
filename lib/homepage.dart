import 'package:flutter/material.dart';

import 'add_new_task.dart';
import 'list.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TO DO LIST'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => const AddNewTask(
                  isEditMode: false,
                  id: '',
                ),
              );
            },
          ),
        ],
      ),
      body: List(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => const AddNewTask(
              isEditMode: false,
              id: '',
            ),
          );
        },
        tooltip: 'Add a new item!',
        child: const Icon(Icons.add),
      ),
    );
  }
}
