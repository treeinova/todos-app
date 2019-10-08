class Todo {
  int id;
  String titulo;
  String descricao;
  bool concluido;

  Todo({
    this.id,
    this.titulo,
    this.descricao,
    this.concluido,
  });

  Todo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    descricao = json['descricao'];
    concluido = json['concluido'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ?? 0;
    data['titulo'] = this.titulo;
    data['descricao'] = this.descricao;
    data['concluido'] = this.concluido ?? false;
    return data;
  }
}
