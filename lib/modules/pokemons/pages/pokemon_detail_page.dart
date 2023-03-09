import 'package:flutter/material.dart';
import 'package:modular_arch/models/pokemon.dart';

class PokemonDetailPage extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonDetailPage({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokemon')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Image.network(pokemon.artworkUrl, scale: 0.5, width: 200, height: 200,),
                ),
                Text('${pokemon.name.toUpperCase()} (#${pokemon.id})', style: Theme.of(context).textTheme.headline4,),
                const SizedBox(height: 16),
                Text('Types', style: Theme.of(context).textTheme.headline6, ),
                Row(
                  children: pokemon.types.map((e) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Chip(label: Text(e)),
                  )).toList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
