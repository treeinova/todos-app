import 'package:flutter/material.dart';
import 'package:helloword/models/todo.dart';
import 'package:helloword/repositories/todo-repository.dart';
import 'package:helloword/ui/create-edit-screen.dart';
import 'package:toast/toast.dart';

class ListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListPageState();
  }
}

class ListPageState extends State<ListPage> {
  List<Todo> list_todos = [];
  TodoRepository repository;
  @override
  void initState() {
    repository = TodoRepository();
    this.loadTodos();
    super.initState();
  }

  void loadTodos() async {
    var list = await repository.getAll();
    setState(() {
      list_todos = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
        actions: <Widget>[Icon(Icons.today)],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(
              Icons.check_circle,
              color: list_todos[index].concluido ? Colors.black : Colors.grey,
            ),
            title: Text(list_todos[index].titulo),
            subtitle: Text(list_todos[index].descricao),
          );
        },
        itemCount: list_todos.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // quando o botão for clilcado.
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateEditPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}
