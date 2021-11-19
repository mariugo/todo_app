import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NovaTarefa extends StatefulWidget {
  const NovaTarefa({Key? key, required this.adicionarTarefa}) : super(key: key);
  final Function adicionarTarefa;

  @override
  _NovaTarefaState createState() => _NovaTarefaState();
}

class _NovaTarefaState extends State<NovaTarefa> {
  final _tituloController = TextEditingController();
  DateTime? _dataTarefa;

  void _mostrarCalendario() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime(2050))
        .then((dataEscolhida) {
      if (dataEscolhida == null) {
        return;
      }
      setState(() {
        _dataTarefa = dataEscolhida;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Título'),
              controller: _tituloController,
              onSubmitted: (_) => _enviarTarefa(),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _dataTarefa == null
                          ? 'Nenhuma data escolhida'
                          : 'Data escolhida: ' +
                              DateFormat('dd-MM-yyyy').format(_dataTarefa!),
                    ),
                  ),
                  TextButton(
                    onPressed: _mostrarCalendario,
                    child: Text(
                      'Escolher Data',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              child: const Text(
                'Adicionar Tarefa',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: _enviarTarefa,
            ),
          ],
        ),
      ),
    );
  }

  void _enviarTarefa() {
    final tituloDigitado = _tituloController.text;

    if (tituloDigitado.isEmpty || _dataTarefa == null) {
      return;
    }
    widget.adicionarTarefa(
      tituloDigitado,
      _dataTarefa,
    );
    Navigator.of(context).pop();
  }
}
