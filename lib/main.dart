import 'package:flutter/material.dart';
import 'package:teste_tecnico_target/route/route_manager.dart';

import 'injection/dependency_injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Target teste',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: RouteManager.navigatorKey,
      initialRoute: RouteManager.getRouteName(RouteName.logginMobx),
      onGenerateRoute: RouteManager.generateRoute,
    );
  }
}
