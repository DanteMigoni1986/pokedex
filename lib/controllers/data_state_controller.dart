import 'package:get/get.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/providers/pokemon_api_provider.dart';

class DataStateController extends GetxController {
  var shownText = ''.obs;
  var lastPokemonId = 1.obs;
  var pokemonList = Future.value(<Pokemon>[]).obs;
  var pokemonBackupList = <Pokemon>[].obs;
  var currentPokemon = Pokemon(
          abilities: <Ability>[],
          baseExperience: 0,
          forms: <Species>[],
          gameIndices: <GameIndex>[],
          height: 2,
          heldItems: <dynamic>[],
          id: 0,
          isDefault: false,
          name: "",
          locationAreaEncounters: "",
          moves: <Move>[],
          order: 0,
          pastTypes: <dynamic>[],
          species: Species(name: "", url: ""),
          sprites: Sprites(
              backDefault: "", backShiny: "", frontDefault: "", frontShiny: ""),
          stats: <Stat>[],
          types: <Type>[],
          weight: 0)
      .obs;

  @override
  void onInit() {
    super.onInit();
    fetchPokemonList();
  }

  setCurrentPokemon(Pokemon pokemon) {
    currentPokemon.value = pokemon;
  }

  void fetchPokemonList() async {
    pokemonList.value = Future.value(<Pokemon>[]);
    pokemonList.value = callPokemons();
  }

  Future<List<Pokemon>> callPokemons() async {
    final pokemonProvider = PokemonApiProvider();
    final pokemons = await pokemonProvider.fetchPokemons(
        lastPokemonId.value, lastPokemonId.value + 10);
    lastPokemonId.value = lastPokemonId.value + 10;
    pokemonBackupList.value = pokemons;

    return pokemons;
  }

  clearPokemons() {
    pokemonList.value = Future.value(<Pokemon>[]);
  }

  addPokemons(List<Pokemon> newPokemons) {
    pokemonBackupList.addAll(newPokemons);
    pokemonList.value = Future.value(pokemonBackupList);
  }

  setLastPokemonId(int id) {
    lastPokemonId.value = id;
  }
}
