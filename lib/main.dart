import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: new TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  void _addTodo(String task) {
    setState(() {
      _todoItems.add(task);
    });
  }

  void _removeTodo(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  void _promptRemoveTodo(int index) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return new AlertDialog(
              title: new Text('Mark ${_todoItems[index]} as done?'),
              actions: <Widget>[
                new TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: new Text('CANCEL')),
                new TextButton(
                  child: new Text('YES'),
                  onPressed: () {
                    _removeTodo(index);
                    Navigator.of(ctx).pop();
                  },
                )
              ]);
        });
  }

  Widget _buildTodoList() {
    return ListView.builder(itemBuilder: (ctx, index) {
      if (index < _todoItems.length) {
        return _buildTodoItem(_todoItems[index], index);
      }
      return null;
    });
  }

  Widget _buildTodoItem(String todo, int index) {
    return new ListTile(
      title: new Text(todo),
      onTap: () => _promptRemoveTodo(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text('Todo List')),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
          onPressed: _pushAddTodoScreen,
          tooltip: 'Add Task',
          child: new Icon(Icons.add)),
    );
  }

  void _pushAddTodoScreen() {
    // Push this page onto the stack
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
          appBar: new AppBar(title: new Text('Add a new task')),
          body: new TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addTodo(val);
              Navigator.pop(context); // Close the add todo screen
            },
            decoration: new InputDecoration(
                hintText: 'Enter something to do...',
                contentPadding: const EdgeInsets.all(16.0)),
          ));
    }));
  }
}
