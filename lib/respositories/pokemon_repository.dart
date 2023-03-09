import 'package:dio/dio.dart';
import 'package:modular_arch/models/pokemon.dart';

class PokemonRepository {
  final Dio dio;
  const PokemonRepository(this.dio);

  Future<List<Pokemon>> getAll({int page = 0, int size = 20}) async {
    final response = await dio.get(
      'https://pokeapi.co/api/v2/pokemon',
      queryParameters: {
        'offset': page * size,
        'limit': size,
      },
    );
    final rawPokemonsList = response.data['results'] as List;
    final List<Pokemon> pokemons = [];
    for(int i =0; i < rawPokemonsList.length; ++i) {
      final pokemonDetailUrl = rawPokemonsList[i]['url'] as String;

      final response = await dio.get(pokemonDetailUrl);
      pokemons.add(Pokemon.fromApi(response.data));
    }
    return pokemons;
  }

  get({required String pokemon}) async {
    await dio.get(
      'https://pokeapi.co/api/v2/pokemon/$pokemon',
    );
  }
}