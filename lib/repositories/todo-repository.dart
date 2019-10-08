import 'package:dio/dio.dart';
import 'package:helloword/models/todo.dart';

class TodoRepository {
  Future<List<Todo>> getAll() async {
    // Retorna uma lista de tarefas
    var dio = Dio();
    Response response =
        await dio.get("http://curso.treeinova.com.br/todo-api/todo");

    var list = response.data.map((f) => Todo.fromJson(f)).toList();
    return List<Todo>.from(list);
  }

  Future<bool> saveChanges(Todo todo) {
    // Salva a tarefa
  }
}
