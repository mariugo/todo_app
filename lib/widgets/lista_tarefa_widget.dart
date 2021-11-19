import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/db/db_provider.dart';
import '/model/tarefa.dart';

class ListaTarefaWidget extends StatelessWidget {
  ListaTarefaWidget({
    Key? key,
    required this.listaTarefas,
    required this.deletarTarefas,
  }) : super(key: key);

  List<Tarefa> listaTarefas;
  final Function deletarTarefas;

  Future<void> fetchAndSetTarefas() async {
    final dataList = await DBProvider.getData('tarefas');
    listaTarefas = dataList
        .map(
          (item) => Tarefa(
            id: item['id'],
            tarefa: item['tarefa'],
            data: DateTime.parse(item['data']),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    fetchAndSetTarefas();
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
          margin: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 5,
          ),
          elevation: 5,
          child: ListTile(
            leading: const CircleAvatar(
              radius: 30,
              child: Padding(
                padding: EdgeInsets.all(6.0),
                child: FittedBox(
                  child: Icon(
                    Icons.task,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            title: Text(
              listaTarefas[index].tarefa,
            ),
            subtitle: Text(
              DateFormat('dd-MM-yyyy').format(listaTarefas[index].data),
            ),
            trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () => deletarTarefas(listaTarefas[index].id)),
          ),
        );
      },
      itemCount: listaTarefas.length,
    );
  }
}
