import 'package:flutter/material.dart';
import '../../../core/models/pokemon.dart';
import '../../../core/repository/pokedex_repository.dart';

class PokedexProvider extends ChangeNotifier {
  final PokedexRepository repository;

  List<Pokemon> _pokemonList = [];
  List<Pokemon> get pokemonList => _pokemonList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _sortType = 'number'; // Default sorting
  String get sortType => _sortType; // ✅ Add this getter to fix the error

  int _offset = 0;
  final int _limit = 20;

  PokedexProvider(this.repository) {
    fetchPokemon();
  }

  Future<void> fetchPokemon() async {
    _isLoading = true;
    notifyListeners();

    List<Pokemon> newPokemons =
        await repository.getPokemonList(_offset, _limit);
    _pokemonList.addAll(newPokemons);
    _offset += _limit;

    _isLoading = false;
    notifyListeners();
  }

  void sortPokemon(String type) {
    _sortType = type; // ✅ Fix: Update `_sortType` correctly
    if (type == 'name') {
      _pokemonList.sort((a, b) => a.name.compareTo(b.name));
    } else {
      _pokemonList.sort((a, b) => a.id.compareTo(b.id));
    }
    notifyListeners();
  }

  void reset() {
    _offset = 0;
    _pokemonList.clear();
    fetchPokemon();
  }
}
