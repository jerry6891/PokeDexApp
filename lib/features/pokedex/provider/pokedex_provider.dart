import 'package:flutter/material.dart';
import '../../../core/models/pokemon.dart';
import '../../../core/repository/pokedex_repository.dart';

class PokedexProvider extends ChangeNotifier {
  final PokedexRepository repository;

  List<Pokemon> _pokemonList = [];
  List<Pokemon> _filteredPokemonList = []; // ✅ List for filtered results
  List<Pokemon> get pokemonList =>
      _filteredPokemonList.isEmpty ? _pokemonList : _filteredPokemonList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _sortType = 'number'; // Default sorting
  String get sortType => _sortType;

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

    // ✅ Update filtered list (so new data appears in search results)
    _filteredPokemonList = _pokemonList;

    _isLoading = false;
    notifyListeners();
  }

  void searchPokemon(String query) {
    if (query.isEmpty) {
      _filteredPokemonList =
          _pokemonList; // ✅ Reset to full list when search is cleared
    } else {
      _filteredPokemonList = _pokemonList
          .where((pokemon) =>
              pokemon.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners(); // ✅ Update UI
  }

  void sortPokemon(String type) {
    _sortType = type;
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
    _filteredPokemonList.clear();
    fetchPokemon();
  }
}
