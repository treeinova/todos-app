import 'package:flutter/material.dart';
import 'package:helloword/models/todo.dart';
import 'package:helloword/repositories/todo-repository.dart';
import 'package:toast/toast.dart';

/// Screen de criação de tarefa
class CreateEditPage extends StatefulWidget {
  /// Objeto da tarefa imultavél
  final Todo todo;

  const CreateEditPage({Key key, this.todo}) : super(key: key);
  @override
  _CreateEditPageState createState() => _CreateEditPageState();
}

class _CreateEditPageState extends State<CreateEditPage> {
  /// Chave global do formulário
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  /// Objeto da tarefa multavél
  Todo _todo = Todo();

  /// Repositório da tarefa
  TodoRepository _todoRepository = TodoRepository();

  @override
  void initState() {
    if (widget.todo != null) {
      _todo = Todo(
        id: widget.todo.id ?? 0,
        titulo: widget.todo.titulo,
        descricao: widget.todo.descricao,
        concluido: widget.todo.concluido,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Tarefas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _todo.titulo ?? '',
                decoration: InputDecoration(
                    icon: Icon(Icons.edit),
                    labelText: 'Titulo',
                    hintText: 'Qual é a tarefa?'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Titulo é obrigatório.';
                  }
                  return null;
                },
                onSaved: (value) {
                  this._todo.titulo = value;
                },
              ),
              TextFormField(
                initialValue: _todo.descricao ?? '',
                decoration: InputDecoration(
                    icon: Icon(Icons.format_align_left),
                    labelText: 'Descrição',
                    hintText: 'Qual é a descrição?'),
                maxLines: 3,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Descrição é obrigatório.';
                  }
                  return null;
                },
                onSaved: (value) {
                  this._todo.descricao = value;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async {
          if (this._form.currentState.validate()) {
            this._form.currentState.save();

            var sucess = await _todoRepository.saveChanges(_todo);

            if (sucess) {
              Toast.show('Tarefa salva com sucesso!', context);
              Navigator.pop(context);
            } else {
              Toast.show('Problemas ao salvar tarefa!', context);
            }
          }
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
