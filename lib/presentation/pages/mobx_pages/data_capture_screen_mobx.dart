import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:teste_tecnico_target/injection/dependency_injection.dart';
import 'package:teste_tecnico_target/presentation/ViewModels/user_viewmodel.dart.dart';
import 'package:teste_tecnico_target/presentation/blocs/auth_cubit.dart';
import 'package:teste_tecnico_target/presentation/blocs/data_capture_state.dart';
import 'package:teste_tecnico_target/presentation/stores/data_capture_store.dart';
import 'package:teste_tecnico_target/route/route_manager.dart';

class DataCaptureScreen extends StatelessWidget {
  const DataCaptureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _DataCaptureScreenContent();
  }
}

class _DataCaptureScreenContent extends StatelessWidget {
  const _DataCaptureScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataCaptureStore = getIt<DataCaptureStore>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Olá, ${getIt<UserViewModel>().loggedInUser!.username}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              getIt<AuthCubit>().logout();
              RouteManager.navigateToAndRemoveUntil(RouteName.logginMobx);
            },
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          return _buildContent(context, dataCaptureStore.state);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, DataCaptureState state) {
    switch (state.runtimeType) {
      case DataCaptureLoadedState:
        final loadedState = state as DataCaptureLoadedState;
        return _buildLoadedContent(context, loadedState.capturedData);
      case DataCaptureErrorState:
        final errorState = state as DataCaptureErrorState;
        return _buildError(errorState.errorMessage);
      default:
        return _buildLoading();
    }
  }

  Widget _buildLoadedContent(BuildContext context, List<String> capturedData) {
    final dataCaptureStore = getIt<DataCaptureStore>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: dataCaptureStore.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      focusNode: dataCaptureStore.dataFocusNode,
                      controller: dataCaptureStore.dataController,
                      decoration:
                          const InputDecoration(labelText: 'Digite seu texto'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite um texto válido.';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        if (dataCaptureStore.formKey.currentState!.validate()) {
                          dataCaptureStore.saveData(value);
                        }
                        dataCaptureStore.dataFocusNode.requestFocus();
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Informações Salvas',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          _buildDataList(context, dataCaptureStore),
        ],
      ),
    );
  }

  Widget _buildDataList(
    BuildContext context,
    DataCaptureStore dataCaptureStore,
  ) {
    return Observer(
      builder: (_) {
        return Expanded(
          child: ListView.builder(
            itemCount: dataCaptureStore.capturedData.length,
            itemBuilder: (context, index) {
              final data = dataCaptureStore.capturedData[index];
              return Card(
                child: ListTile(
                  title: Text(data),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _editData(context, data, dataCaptureStore);
                          dataCaptureStore.dataFocusNode.requestFocus();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          dataCaptureStore.dataFocusNode.requestFocus();
                          _confirmDelete(context, data, dataCaptureStore);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildError(String errorMessage) {
    return Center(
      child: Text(
        errorMessage,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Future<void> _editData(
    BuildContext context,
    String data,
    DataCaptureStore dataCaptureStore,
  ) async {
    await RouteManager.navigateTo(RouteName.editedataScreen, arguments: data)
        .then((value) {
      if (value != null) {
        dataCaptureStore.editData(data, value);
      }
    });
  }

  Future<void> _confirmDelete(
    BuildContext context,
    String data,
    DataCaptureStore dataCaptureStore,
  ) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmar Exclusão"),
          content: const Text("Tem certeza de que deseja excluir este item?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                dataCaptureStore.deleteData(data);
              },
              child: const Text("Confirmar"),
            ),
          ],
        );
      },
    );
  }
}
