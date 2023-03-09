import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_arch/modules/initial/pages/splash_page.dart';

class InitialModule extends Module {
  @override
  List<Module> get imports => const [];

  @override
  List<Bind> get binds => const [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/splash', child: (_, __) => const SplashPage()),
  ];
}