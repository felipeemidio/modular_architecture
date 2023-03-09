import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_arch/models/pokemon.dart';
import 'package:modular_arch/respositories/pokemon_repository.dart';
import 'package:modular_arch/services/local_storage_service.dart';

class PokemonsListPage extends StatefulWidget {

  const PokemonsListPage({Key? key}) : super(key: key);

  @override
  State<PokemonsListPage> createState() => _PokemonsListPageState();
}

class _PokemonsListPageState extends State<PokemonsListPage> {
  final pokemonRepository = Modular.get<PokemonRepository>();
  final localStorageService = Modular.get<LocalStorageService>();

  List<Pokemon> pokemons = [];
  List<int> favorites = [];
  int page = 0;
  int size = 20;
  bool isLoading = false;
  bool hasMorePages = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    _loadNextPage();
  }

  _loadNextPage() async {
    if(isLoading) {
      return;
    }
    isLoading = true;
    final fetchedPokemons = await pokemonRepository.getAll(page: page, size: size);
    if(fetchedPokemons.length < size) {
      hasMorePages = false;
    }
    page += 1;
    pokemons.addAll(fetchedPokemons);
    setState(() {
      isLoading = false;
    });
  }

  _loadFavorites() async {
    final rawFavorites = await localStorageService.get('pokemons');
    final list = jsonDecode(rawFavorites ?? '[]') as List;
    favorites = list.cast<int>();
    setState(() {});
  }

  _onFavorite(Pokemon pokemon) {
    if(favorites.contains(pokemon.id)) {
      favorites.remove(pokemon.id);
    } else {
      favorites.add(pokemon.id);
    }
    // localStorageService.save('pokemons', jsonEncode(favorites));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokemons List')),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            if(isLoading && pokemons.isEmpty) {
              return const Center(child: CircularProgressIndicator(),);
            }

            return ListView.builder(
              itemCount: pokemons.length + (hasMorePages ? 1 : 0),
              itemBuilder: (_, index) {
                if(index >= pokemons.length) {
                  _loadNextPage();
                  return const SizedBox(height: 50, child: Center(child: CircularProgressIndicator(),),);
                }

                final currentPokemon = pokemons[index];
                currentPokemon.favorite = favorites.contains(currentPokemon.id);

                return ListTile(
                  leading: Image.network(currentPokemon.spriteUrl),
                  title: Text(currentPokemon.name.toUpperCase()),
                  trailing: IconButton(
                    icon: currentPokemon.favorite ? const Icon(
                      Icons.favorite,
                      color: Colors.orange,
                    ) : const Icon(
                      Icons.favorite_border,
                      color: Colors.grey,
                    ),
                    onPressed: () => _onFavorite(currentPokemon),
                  ),
                  onTap: () => Modular.to.pushNamed('/home/pokemons/detail', arguments: currentPokemon, forRoot: true),
                );

              },
            );
          }
        ),
      )
    );
  }
}
