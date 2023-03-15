import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_arch/models/berry.dart';
import 'package:modular_arch/respositories/berry_repository.dart';
import 'package:modular_arch/services/local_storage_service.dart';

class BerriesListPage extends StatefulWidget {
  const BerriesListPage({Key? key}) : super(key: key);

  @override
  State<BerriesListPage> createState() => _BerriesListPageState();
}

class _BerriesListPageState extends State<BerriesListPage> {
  final berryRepository = Modular.get<BerryRepository>();
  final localStorageService = Modular.get<LocalStorageService>();

  List<Berry> berries = [];
  List<int> favorites = [];
  int page = 0;
  int size = 20;
  bool isLoading = false;
  bool hasMorePages = true;
  bool isFavouritesOnly = false;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    _loadNextPage();
  }

  _loadNextPage() async {
    if (isLoading) {
      return;
    }
    isLoading = true;
    final fetchedPokemons =
        await berryRepository.getAll(page: page, size: size);
    if (fetchedPokemons.length < size) {
      hasMorePages = false;
    }
    page += 1;
    berries.addAll(fetchedPokemons);
    setState(() {
      isLoading = false;
    });
  }

  _loadFavorites() async {
    final rawFavorites = await localStorageService.get('berries');
    final list = jsonDecode(rawFavorites ?? '[]') as List;
    favorites = list.cast<int>();
    setState(() {});
  }

  _onFavorite(Berry berry) {
    if (favorites.contains(berry.id)) {
      favorites.remove(berry.id);
    } else {
      favorites.add(berry.id);
    }
    localStorageService.save('berries', jsonEncode(favorites));
    setState(() {});
  }

  void _showFavourites() async {
    isFavouritesOnly = !isFavouritesOnly;
    if (isFavouritesOnly) {
      berries.removeWhere(
        (berry) => !favorites.contains(berry.id),
      );
      hasMorePages = false;
    } else {
      berries.clear();
      page = 0;
      _loadNextPage();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Berries List'),
          actions: [
            IconButton(
              icon: isFavouritesOnly
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.orange,
                    )
                  : const Icon(
                      Icons.favorite,
                      color: Colors.grey,
                    ),
              tooltip: 'Filter berries',
              onPressed: _showFavourites,
            ),
          ],
        ),
        body: SafeArea(
          child: Builder(builder: (context) {
            if (isLoading && berries.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: berries.length + (hasMorePages ? 1 : 0),
              itemBuilder: (_, index) {
                if (!isFavouritesOnly && index >= berries.length) {
                  _loadNextPage();
                  return const SizedBox(
                    height: 50,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final currentBerry = berries[index];
                currentBerry.favorite = favorites.contains(currentBerry.id);
                return ListTile(
                  onTap: () => Modular.to.pushNamed('/home/berries/detail',
                      arguments: currentBerry, forRoot: true),
                  leading: Image.network(currentBerry.spriteUrl),
                  title: Text(currentBerry.name),
                  trailing: IconButton(
                    icon: currentBerry.favorite
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.orange,
                          )
                        : const Icon(
                            Icons.favorite_border,
                            color: Colors.grey,
                          ),
                    onPressed: () => _onFavorite(currentBerry),
                  ),
                );
              },
            );
          }),
        ));
  }
}
