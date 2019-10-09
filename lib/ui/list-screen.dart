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
  /// lista de tarefas
  List<Todo> list_todos = [];

  /// flag para desaparecer botão de adicionar uma nova tarefa
  bool showFab = true;

  TodoRepository repository;
  @override
  void initState() {
    repository = TodoRepository();
    this.loadTodos();
    super.initState();
  }

  /// Carrega as tarefas
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
      ),
      body: Center(
        child: list_todos.isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  Icon(
                    Icons.edit_attributes,
                    color: Colors.grey,
                    size: 60,
                  ),
                  Text(
                    'Nenhuma tarefa cadastrada',
                    style: TextStyle(fontSize: 25, color: Colors.grey),
                  ),
                ],
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  var todo = list_todos[index];
                  return ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: list_todos[index].concluido
                          ? Colors.black
                          : Colors.grey,
                    ),
                    title: Text(list_todos[index].titulo),
                    subtitle: Text(list_todos[index].descricao),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateEditPage(todo: todo)),
                      );

                      loadTodos();
                    },
                    onLongPress: () {
                      var bottomSheetController = showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                                height: 150,
                                child: ListView(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Opções'),
                                    ),
                                    ListTile(
                                      leading: Icon(
                                        Icons.check_circle,
                                        color: todo.concluido
                                            ? Colors.grey
                                            : Colors.black,
                                      ),
                                      title: Text(todo.concluido
                                          ? 'Marcar como não concluida'
                                          : 'Marcar como concluida'),
                                      onTap: () {
                                        _onMarkComplete(todo.id);
                                        Toast.show(
                                            'Tarefa ${todo.titulo} foi concluida!',
                                            context);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      title: Text('Excluir tarefa'),
                                      onTap: () {
                                        _onDeleteTask(todo.id);
                                        Toast.show(
                                            'Tarefa ${todo.titulo} foi excluida!',
                                            context);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ));

                      _showFoatingActionButton(false);
                      bottomSheetController.then((value) {
                        _showFoatingActionButton(true);
                      });
                    },
                  );
                },
                itemCount: list_todos.length,
              ),
      ),
      floatingActionButton: showFab
          ? FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () async {
                // quando o botão for clilcado.
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateEditPage()),
                );

                loadTodos();
              },
              child: Icon(Icons.add),
            )
          : Container(),
    );
  }

  /// Método que desaparece botão de adicionar uma nova tarefa
  void _showFoatingActionButton(bool value) {
    setState(() {
      showFab = value;
    });
  }

  /// Método que deleta uma tarefa
  Future _onDeleteTask(int id) async {
    await this.repository.delete(id);
    loadTodos();
  }

  /// Método que altera o status da tarefa
  Future _onMarkComplete(int id) async {
    await this.repository.markComplete(id);
    loadTodos();
  }
}
