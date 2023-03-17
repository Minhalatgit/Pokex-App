import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokex/model/pokemon_model.dart';

class HomeRepository {
  Future<PokemonModel> getPokex() async {
    String url = "https://pokeapi.co/api/v2/pokemon/";

    print("Url: $url");

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return PokemonModel.fromJson(jsonDecode(response.body));
    } else {
      throw "Something went wrong ${response.statusCode}";
    }
  }
}
