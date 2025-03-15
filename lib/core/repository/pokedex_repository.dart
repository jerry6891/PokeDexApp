import '../api/poke_api_service.dart';
import '../models/pokemon.dart';

class PokedexRepository {
  final PokeApiService apiService;

  PokedexRepository(this.apiService);

  /// 🔹 Fetches Pokémon List and Details
  Future<List<Pokemon>> getPokemonList(int offset, int limit) async {
    final pokemonList = await apiService.fetchPokemonList(offset, limit);
    List<Pokemon> detailedList = [];

    for (var item in pokemonList) {
      final details = await apiService.fetchPokemonDetails(item['name']);
      detailedList.add(Pokemon.fromJson(details));
    }
    return detailedList;
  }
}
