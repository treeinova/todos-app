import 'package:dio/dio.dart';
import 'package:helloword/models/todo.dart';

class TodoRepository {
  Dio dio = Dio();
  Future<List<Todo>> getAll() async {
    // Retorna uma lista de tarefas
    Response response =
        await dio.get("http://curso.treeinova.com.br/todo-api/todo");

    var list = response.data.map((f) => Todo.fromJson(f)).toList();
    return List<Todo>.from(list);
  }

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

  Future<bool> markComplete(int id) async {
    Response response = await dio
        .put("http://curso.treeinova.com.br/todo-api/todo/$id/concluido");

    return response.statusCode == 200;
  }

  Future<bool> delete(int id) async {
    Response response =
        await dio.delete("http://curso.treeinova.com.br/todo-api/todo/$id");

    return response.statusCode == 200;
  }
}
