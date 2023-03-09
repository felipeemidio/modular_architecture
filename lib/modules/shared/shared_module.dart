import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_arch/services/local_storage_service.dart';

class SharedModule extends Module {
  @override
  List<Bind> get binds => [
    Bind<LocalStorageService>((i) => LocalStorageService(), export: true),
    Bind<Dio>((i) => Dio(), export: true),
  ];
}