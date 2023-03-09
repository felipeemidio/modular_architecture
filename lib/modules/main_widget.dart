import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MainWidget extends StatelessWidget {
  MainWidget({super.key}) {
    Modular.setInitialRoute('/splash');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
