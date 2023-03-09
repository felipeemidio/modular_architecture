import 'package:flutter/material.dart';
import 'package:modular_arch/models/berry.dart';
import 'package:modular_arch/models/pokemon.dart';

class BerryDetailPage extends StatelessWidget {
  final Berry berry;
  const BerryDetailPage({Key? key, required this.berry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Berry')),
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
                  child: Image.network(berry.spriteUrl, scale: 0.5, width: 200, height: 200,),
                ),
                Text('${berry.name.toUpperCase()} (#${berry.id})', style: Theme.of(context).textTheme.headline4,),
                const SizedBox(height: 16),
                Text(berry.effect, style: Theme.of(context).textTheme.headline6),
              ],
            ),
          ),
        ),
      ),
    );
  }
}