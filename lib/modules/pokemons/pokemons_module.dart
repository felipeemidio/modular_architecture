import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_arch/modules/pokemons/pages/pokemon_detail_page.dart';
import 'package:modular_arch/modules/pokemons/pages/pokemons_list_page.dart';
import 'package:modular_arch/respositories/pokemon_repository.dart';

class PokemonsModule extends Module {
  @override
  List<Module> get imports => const [];

  @override
  List<Bind> get binds => [
    Bind<PokemonRepository>((i) => PokemonRepository(i())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (_, __) => const PokemonsListPage(), transition: TransitionType.fadeIn),
    ChildRoute('/detail', child: (_, args) => PokemonDetailPage(pokemon: args.data), transition: TransitionType.downToUp),
  ];
}