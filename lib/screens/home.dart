import 'package:flutter/material.dart';

import '/db/db_provider.dart';
import '/model/tarefa.dart';
import '/widgets/lista_tarefa_widget.dart';
import '/widgets/nova_tarefa_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final tituloController = TextEditingController();
  final List<Tarefa> _tarefasdoUsuario = [];

  void _adicionarNovaTarefa(String tarefa, DateTime dataEscolhida) {
    String id = DateTime.now().toIso8601String();
    final novaTarefa = Tarefa(id: id, tarefa: tarefa, data: dataEscolhida);
    DBProvider.inserir(
      'tarefas',
      {
        'id': id,
        'tarefa': tarefa,
        'data': dataEscolhida.toIso8601String(),
      },
    );
    setState(() {
      _tarefasdoUsuario.add(novaTarefa);
    });
  }

  void _deletarTarefa(String id) {
    setState(() {
      _tarefasdoUsuario.removeWhere((value) => value.id == id);
    });
    DBProvider.deletar(id);
  }

  void _iniciarModal(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        builder: (_) {
          return AnimatedPadding(
            padding: (MediaQuery.of(context).viewInsets),
            duration: const Duration(milliseconds: 100),
            curve: Curves.decelerate,
            child: NovaTarefa(adicionarTarefa: _adicionarNovaTarefa),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final myAppBar = AppBar(
      title: const Text('Lista de Tarefas'),
    );
    return SafeArea(
      child: Scaffold(
        appBar: myAppBar,
        body: SingleChildScrollView(
          child: SizedBox(
            height: (MediaQuery.of(context).size.height -
                    myAppBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.9,
            child: ListaTarefaWidget(
              deletarTarefas: _deletarTarefa,
              listaTarefas: _tarefasdoUsuario,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => _iniciarModal(context),
        ),
      ),
    );
  }
}
