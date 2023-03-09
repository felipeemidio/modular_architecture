import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  _onChangeTab(int index) {
    setState(() {
      currentIndex = index;
    });

    switch(index) {
      case 0:
        Modular.to.navigate('/home/pokemons/');
        break;
      case 1:
        Modular.to.navigate('/home/berries/');
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: _onChangeTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Pokemons'),
          BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: 'Berries'),
        ],
      ),
      body: const RouterOutlet(),
    );
  }
}
