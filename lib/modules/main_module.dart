import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_arch/modules/berries/berries_module.dart';
import 'package:modular_arch/modules/initial/initial_module.dart';
import 'package:modular_arch/modules/initial/pages/home_page.dart';
import 'package:modular_arch/modules/pokemons/pokemons_module.dart';
import 'package:modular_arch/modules/shared/shared_module.dart';

class MainModule extends Module {
  @override
  List<Module> get imports => [
    SharedModule()
  ];

  @override
  List<ModularRoute> get routes => [
    ModuleRoute('/', module: InitialModule()),
    ChildRoute('/home', child: (_, __) => const HomePage(), children: [
      ModuleRoute('/pokemons', module: PokemonsModule()),
      ModuleRoute('/berries', module: BerriesModule()),
    ]),
  ];
}