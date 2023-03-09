import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_arch/models/pokemon.dart';
import 'package:modular_arch/modules/pokemons/pages/pokemons_list_page.dart';
import 'package:modular_arch/modules/pokemons/pokemons_module.dart';
import 'package:modular_arch/modules/shared/shared_module.dart';
import 'package:modular_arch/respositories/pokemon_repository.dart';
import 'package:modular_arch/services/local_storage_service.dart';
import 'package:modular_test/modular_test.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

class MockLocalStorageService extends Mock implements LocalStorageService {}

main() {
  final mockPokemonRepository = MockPokemonRepository();
  final mockLocalStorageService = MockLocalStorageService();

  final mockPokemons = [
    Pokemon(
      id: 1,
      name: 'bulbasaur',
      spriteUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
      artworkUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
      types: ['grass', 'poison'],
    ),
    Pokemon(
      id: 4,
      name: 'charmander',
      spriteUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
      artworkUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png',
      types: ['fire'],
    ),
    Pokemon(
      id: 7,
      name: 'squirtle',
      spriteUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png',
      artworkUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png',
      types: ['water'],
    ),
  ];
  final mockFavorites = [
    7
  ];

  setUp((){

    initModules([SharedModule(), PokemonsModule()], replaceBinds: [
      Bind.instance<LocalStorageService>(mockLocalStorageService, export: true),
      Bind.instance<PokemonRepository>(mockPokemonRepository),
    ]);
  });

  testWidgets('list rendering...', (tester) async {
    when(() => mockPokemonRepository.getAll(page: any(named: 'page'), size: any(named: 'size'))).thenAnswer((invocation) async => mockPokemons);
    when(() => mockLocalStorageService.get(any())).thenAnswer((invocation) async => jsonEncode(mockFavorites));

    await tester.pumpWidget(const MaterialApp(
      home: PokemonsListPage(),
    ));

    final finder = find.text(mockPokemons[0].name);

    expect(finder, findsOneWidget);
  });

}