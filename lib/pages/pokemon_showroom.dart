import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/controllers/data_state_controller.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/providers/pokemon_api_provider.dart';

class PokemonGalleryPage extends StatelessWidget {
  final dataStateCtrl = Get.put(DataStateController());

  PokemonGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokemon Gallery')),
      body: PokemonListView(dataStateCtrl: dataStateCtrl),
      floatingActionButton: FetchButton(),
    );
  }
}

class FetchButton extends StatelessWidget {
  final dataController = Get.find<DataStateController>();
  FetchButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: Colors.lightBlueAccent,
      onPressed: () async {
        dataController.clearPokemons();
        final pokemonProvider = PokemonApiProvider();
        final newPokemons = await pokemonProvider.fetchPokemons(
            dataController.lastPokemonId.value,
            dataController.lastPokemonId.value + 10);
        dataController
            .setLastPokemonId(dataController.lastPokemonId.value + 10);
        dataController.addPokemons(newPokemons);
      },
      child: const Icon(Icons.add_circle_rounded),
    );
  }
}

class PokemonListView extends StatelessWidget {
  const PokemonListView({
    super.key,
    required this.dataStateCtrl,
  });

  final DataStateController dataStateCtrl;

  @override
  Widget build(BuildContext context) {
    return GetX<DataStateController>(
      init: DataStateController(),
      builder: (controller) {
        return FutureBuilder<List<Pokemon>>(
          future: controller.pokemonList.value,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              final pokemons = snapshot.data;

              return ListView.builder(
                itemCount: pokemons!.length,
                itemBuilder: (context, i) =>
                    ListItem(pokemon: pokemons[i], context: context),
              );
            } else {
              // By default, show an empty container.
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    );
  }
}

class ListItem extends StatelessWidget {
  final dataController = Get.find<DataStateController>();
  ListItem({
    super.key,
    required this.pokemon,
    required this.context,
  });

  final Pokemon pokemon;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion) async {
        // TODO: erase pokemon
      },
      child: ListTile(
        title: Text(pokemon.name),
        subtitle: Text(
            "Height: ${pokemon.height} inches, Weight: ${pokemon.weight}, Base Experience: ${pokemon.baseExperience}, Ranking: ${pokemon.order}"),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.lightBlueAccent, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.lightBlueAccent,
          size: 15,
        ),
        onTap: () {
          dataController.setCurrentPokemon(pokemon);
          Navigator.pushNamed(context, 'pokemon_description');
        },
      ),
    );
  }
}
