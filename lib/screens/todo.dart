import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> taskList = ['Eat', 'Sleep', 'Repeat'];
  TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: taskController,
              decoration: InputDecoration(
                hintText: 'Add a task',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    // Add the task to the taskList
                    setState(() {
                      taskList.add(taskController.text);
                      taskController.clear();
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                var item = taskList[index];
                return Card(
                  elevation: 10,
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                    leading: CircleAvatar(
                      radius: 30,
                      child: Text((index + 1).toString()),
                    ),
                    title: Text(
                      item,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        var alert = AlertDialog(
                          title: Text("Confirm delete"),
                          content: Text("Are you sure you want to delete?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("No", style: TextStyle(color: Colors.red)),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  taskList.removeAt(index);
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text("Yes", style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        );
                        showDialog(
                          context: context,
                          builder: (context) => alert,
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}