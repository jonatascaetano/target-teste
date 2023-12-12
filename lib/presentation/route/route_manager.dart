import 'package:flutter/material.dart';
import 'package:teste_tecnico_target/presentation/pages/cubit_pages/data_capture_screen.dart';
import 'package:teste_tecnico_target/presentation/pages/cubit_pages/login_screen.dart';
import 'package:teste_tecnico_target/presentation/pages/cubit_pages/registration_screen.dart';
import 'package:teste_tecnico_target/presentation/pages/edite_data_screen.dart';
import 'package:teste_tecnico_target/presentation/pages/mobx_pages/data_capture_screen_mobx.dart';
import 'package:teste_tecnico_target/presentation/pages/mobx_pages/login_screen_mobx.dart';
import 'package:teste_tecnico_target/presentation/pages/mobx_pages/registration_screen_mobx.dart';

enum RouteName {
  logginMobx,
  registerMobx,
  dataCaptureScreenMobx,
  logginCubit,
  registerCubit,
  dataCaptureScreenCubit,
  editedataScreen,
}

class RouteManager {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<dynamic> navigateTo(RouteName route,
      {Object? arguments}) async {
    String routeName = getRouteName(route);
    return await navigatorKey.currentState
        ?.pushNamed(routeName, arguments: arguments);
  }

  static void replaceWith(RouteName route, {Object? arguments}) {
    String routeName = getRouteName(route);
    navigatorKey.currentState
        ?.pushReplacementNamed(routeName, arguments: arguments);
  }

  static void navigateToAndRemoveUntil(RouteName route, {Object? arguments}) {
    String routeName = getRouteName(route);
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
        routeName, (route) => false,
        arguments: arguments);
  }

  static void goBack() {
    navigatorKey.currentState?.pop();
  }

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/loggin_mobx':
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case '/register_mobx':
        return MaterialPageRoute(
            builder: (context) => const RegistrationScreen());
      case '/data_capture_screen_mobx':
        return MaterialPageRoute(
            builder: (context) => const DataCaptureScreen());
      case '/loggin_cubit':
        return MaterialPageRoute(
            builder: (context) => const LoginScreenCubit());
      case '/register_cubit':
        return MaterialPageRoute(
            builder: (context) => const RegistrationScreenCubit());
      case '/data_capture_screen_cubit':
        return MaterialPageRoute(
            builder: (context) => const DataCaptureScreenCubit());
      case '/edite_data_screen':
        return MaterialPageRoute(
            builder: (context) => EditDataScreen(
                  initialData: settings.arguments.toString(),
                ));
    }
    return null;
  }

  static String getRouteName(RouteName route) {
    switch (route) {
      case RouteName.logginMobx:
        return '/loggin_mobx';
      case RouteName.registerMobx:
        return '/register_mobx';
      case RouteName.dataCaptureScreenMobx:
        return '/data_capture_screen_mobx';
      case RouteName.logginCubit:
        return '/loggin_cubit';
      case RouteName.registerCubit:
        return '/register_cubit';
      case RouteName.dataCaptureScreenCubit:
        return '/data_capture_screen_cubit';
      case RouteName.editedataScreen:
        return '/edite_data_screen';
    }
  }
}
