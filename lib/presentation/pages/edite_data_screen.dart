import 'package:flutter/material.dart';

class EditDataScreen extends StatelessWidget {
  final String initialData;

  const EditDataScreen({Key? key, required this.initialData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataController = TextEditingController(text: initialData);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Dados'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: dataController,
              decoration: const InputDecoration(labelText: 'Editar seu texto'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, dataController.text);
              },
              child: const Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
