import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/controllers/data_state_controller.dart';
import 'dart:convert';

import 'package:pokedex/models/pokemon_model.dart';

class PokemonApiProvider {
  final _url = 'pokeapi.co/api/v2/pokemon/';

  Future<List<Pokemon>> fetchPokemons(int init, int last) async {
    final List<Pokemon> pokemons = [];

    for (int i = init; i < last; i++) {
      final response = await Dio().get("https://$_url$i",
          queryParameters: {'id': i},
          options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));

      final pokemonInfo = Pokemon.fromJson(response.data);
      pokemons.add(pokemonInfo);
    }

    return pokemons;
  }
}
