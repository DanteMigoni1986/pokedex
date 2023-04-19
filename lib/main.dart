import 'package:flutter/material.dart';
import 'package:pokedex/pages/pokemon_description.dart';
import 'package:pokedex/pages/pokemon_showroom.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex',
      initialRoute: 'gallery',
      routes: {
        'gallery': (BuildContext context) => PokemonGalleryPage(),
        'pokemon_description': (BuildContext context) =>
            const PokemonDescriptionPage(),
      },
    );
  }
}
