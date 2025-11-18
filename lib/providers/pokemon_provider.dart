import 'package:flutter/foundation.dart';
import '../models/pokemon.dart';
import '../services/pokemon_service.dart';

class PokemonProvider with ChangeNotifier {
  final PokemonService _service = PokemonService();

  Pokemon? _pokemon;
  List<PokemonListItem> _pokemonList = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  Pokemon? get pokemon => _pokemon;
  List<PokemonListItem> get pokemonList => _pokemonList;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Obtener un Pokémon específico
  Future<void> getPokemon(String name) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _pokemon = await _service.getPokemon(name.toLowerCase());
      _error = null;
    } catch (e) {
      _error = e.toString();
      _pokemon = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Obtener lista de Pokémon
  Future<void> getPokemons({int limit = 20, int offset = 0}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _pokemonList = await _service.getPokemons(limit: limit, offset: offset);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _pokemonList = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Limpiar estado
  void clear() {
    _pokemon = null;
    _pokemonList = [];
    _error = null;
    notifyListeners();
  }
}

