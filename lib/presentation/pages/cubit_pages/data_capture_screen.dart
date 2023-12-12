import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_tecnico_target/presentation/route/route_manager.dart';

import '../../../core/injection/dependency_injection.dart';
import '../../ViewModels/user_viewmodel.dart.dart';
import '../../blocs/auth_cubit.dart';
import '../../blocs/data_capture_cubit.dart';
import '../../blocs/data_capture_state.dart';

class DataCaptureScreenCubit extends StatelessWidget {
  const DataCaptureScreenCubit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DataCaptureCubit>(),
      child: const _DataCaptureScreenContent(),
    );
  }
}

class _DataCaptureScreenContent extends StatelessWidget {
  const _DataCaptureScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Olá, ${getIt<UserViewModel>().loggedInUser!.username}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              getIt<AuthCubit>().logout();
              RouteManager.navigateTo(RouteName.logginCubit);
            },
          ),
        ],
      ),
      body: const DataCaptureScreenBody(),
    );
  }
}

class DataCaptureScreenBody extends StatefulWidget {
  const DataCaptureScreenBody({Key? key}) : super(key: key);

  @override
  State<DataCaptureScreenBody> createState() => _DataCaptureScreenBodyState();
}

class _DataCaptureScreenBodyState extends State<DataCaptureScreenBody> {
  final _dataController = TextEditingController();
  final _dataFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<DataCaptureCubit>().loadData();
    _dataFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataCaptureCubit, DataCaptureState>(
      builder: (context, state) {
        if (state is DataCaptureLoadedState) {
          return _buildContent(state.capturedData);
        } else if (state is DataCaptureErrorState) {
          return _buildError(state.errorMessage);
        } else {
          return _buildLoading();
        }
      },
    );
  }

  Widget _buildContent(List<String> capturedData) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      focusNode: _dataFocusNode,
                      controller: _dataController,
                      decoration:
                          const InputDecoration(labelText: 'Digite seu texto'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite um texto válido.';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        if (_formKey.currentState!.validate()) {
                          context.read<DataCaptureCubit>().saveData(value);
                          _dataController.clear();
                        }
                        _dataFocusNode.requestFocus();
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
          _buildDataList(capturedData),
        ],
      ),
    );
  }

  Widget _buildDataList(List<String> capturedData) {
    return Expanded(
      child: ListView.builder(
        itemCount: capturedData.length,
        itemBuilder: (context, index) {
          final data = capturedData[index];
          return Card(
            child: ListTile(
              title: Text(data),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _editData(context, data);
                      _dataFocusNode.requestFocus();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _dataFocusNode.requestFocus();
                      _confirmDelete(
                          context, data, context.read<DataCaptureCubit>());
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
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
}

Future<void> _editData(BuildContext context, String data) async {
  await RouteManager.navigateTo(RouteName.editedataScreen, arguments: data)
      .then((value) {
    if (value != null) {
      context.read<DataCaptureCubit>().editData(data, value);
    }
  });
}

Future<void> _confirmDelete(BuildContext context, String data,
    DataCaptureCubit dataCaptureCubit) async {
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
              dataCaptureCubit.deleteData(data);
            },
            child: const Text("Confirmar"),
          ),
        ],
      );
    },
  );
}
