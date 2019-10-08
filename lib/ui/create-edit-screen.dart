import 'package:flutter/material.dart';
import 'package:helloword/models/todo.dart';

class CreateEditPage extends StatefulWidget {
  @override
  _CreateEditPageState createState() => _CreateEditPageState();
}

class _CreateEditPageState extends State<CreateEditPage> {
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  Todo _todo = Todo();

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
        onPressed: () {
          if (this._form.currentState.validate()) {
            this._form.currentState.save();
            print(_todo);
            Navigator.pop(context, _todo);
          }
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
