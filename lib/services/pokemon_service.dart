import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokemonService {
  static const String baseUrl = 'https://pokeapi.co/api/v2';

  // Obtener un Pokémon específico por nombre
  Future<Pokemon> getPokemon(String name) async {
    final url = Uri.parse('$baseUrl/pokemon/$name');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return Pokemon.fromJson(data);
    } else {
      throw Exception('Error: ${res.statusCode}');
    }
  }

  // Obtener lista de Pokémon paginada
  Future<List<PokemonListItem>> getPokemons({
    int limit = 20,
    int offset = 0,
  }) async {
    final url = Uri.parse('$baseUrl/pokemon?limit=$limit&offset=$offset');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      final results = data['results'] as List<dynamic>;
      return results
          .map((item) => PokemonListItem.fromJson(item))
          .toList();
    } else {
      throw Exception('Error: ${res.statusCode}');
    }
  }
}

