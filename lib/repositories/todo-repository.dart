import 'package:dio/dio.dart';
import 'package:helloword/models/todo.dart';

/// Repositório das Tarefas
class TodoRepository {
  Dio dio = Dio();

  /// Retorna uma lista de tarefas
  Future<List<Todo>> getAll() async {
    Response response =
        await dio.get("http://curso.treeinova.com.br/todo-api/todo");

    var list = response.data.map((f) => Todo.fromJson(f)).toList();
    return List<Todo>.from(list);
  }

  /// Salva uma tarefa
  /// Se [todo.id] é  nulo ou 0 irá criar uma nova tarefa, se não irá alterar utilizando o [todo.id]
  Future<bool> saveChanges(Todo todo) async {
    // Salva a tarefa
    Response response;
    if (todo.id == 0 || todo.id == null) {
      response = await dio.post("http://curso.treeinova.com.br/todo-api/todo",
          data: todo);
    } else {
      response = await dio.put(
          "http://curso.treeinova.com.br/todo-api/todo/${todo.id}",
          data: todo);
    }

    return response.statusCode == 200;
  }

  /// Altera o status da tarefa por [id]
  /// Quando esse metodo é chamado, ele altera o status da tarefa para o oposto
  Future<bool> markComplete(int id) async {
    Response response = await dio
        .put("http://curso.treeinova.com.br/todo-api/todo/$id/concluido");

    return response.statusCode == 200;
  }

  /// Deleta a taefa por [id]
  Future<bool> delete(int id) async {
    Response response =
        await dio.delete("http://curso.treeinova.com.br/todo-api/todo/$id");

    return response.statusCode == 200;
  }
}
