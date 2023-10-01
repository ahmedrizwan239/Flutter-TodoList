import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<TaskItem> taskList = [
    TaskItem(title: 'Eat', isCompleted: false),
    TaskItem(title: 'Sleep', isCompleted: false),
    TaskItem(title: 'Repeat', isCompleted: false),
  ];

  TextEditingController taskController = TextEditingController();
  int editIndex = -1;

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
                hintText: editIndex == -1 ? 'Add a task' : 'Edit task',
                suffixIcon: IconButton(
                  icon: Icon(editIndex == -1 ? Icons.add : Icons.check),
                  onPressed: () {
                    // Add the task to the taskList
                    setState(() {
                      if(taskController.text.isNotEmpty)
                      {
                        if (editIndex == -1) {
                          taskList.add(TaskItem(title: taskController.text, isCompleted: false));
                        } 
                        else {
                          taskList[editIndex].title = taskController.text;
                          editIndex = -1;
                        }
                        taskController.clear();
                      }
                      else
                      {
                        // Display a styled Snackbar when the task text is empty
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please enter a task!"),
                            backgroundColor: Colors.red, 
                            elevation: 6, 
                            behavior: SnackBarBehavior.floating, 
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      }
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
                var task = taskList[index];
                return Card(
                  elevation: 10,
                  shadowColor: Colors.purple[400],
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                    leading: CircleAvatar(
                      radius: 30,
                      child: Text((index + 1).toString()),
                    ),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: task.isCompleted,
                          activeColor: Colors.purple,
                          onChanged: (newValue) {
                            setState(() {
                              task.isCompleted = !task.isCompleted;
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.edit), color: Colors.purple,
                          onPressed: () {
                            setState(() {
                              editIndex = index;
                              taskController.text = task.title;
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete), color: Colors.purple,
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
                      ],
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

class TaskItem {
  String title;
  bool isCompleted;

  TaskItem({required this.title, required this.isCompleted});
}