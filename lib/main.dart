import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_arch/modules/main_module.dart';
import 'package:modular_arch/modules/main_widget.dart';
import 'package:modular_arch/services/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.initialize();
  runApp(ModularApp(module: MainModule(), child: MainWidget()));
}

