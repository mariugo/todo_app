class Tarefa {
  String id;
  String tarefa;
  DateTime data;

  Tarefa({required this.id, required this.tarefa, required this.data});

  Map<String, dynamic> toMap() {
    return ({
      'id': id,
      'tarefa': tarefa,
      'data': data,
    });
  }
}
