import 'package:dio/dio.dart';

class PokeApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://pokeapi.co/api/v2/"));

  /// 🔹 Fetch List of Pokémon (Supports Pagination)
  Future<List<Map<String, dynamic>>> fetchPokemonList(
      int offset, int limit) async {
    try {
      final response = await _dio.get("pokemon", queryParameters: {
        "limit": limit,
        "offset": offset,
      });

      List<dynamic> results = response.data["results"];
      return results
          .map((item) => {"name": item["name"], "url": item["url"]})
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch Pokémon list");
    }
  }

  /// 🔹 Fetch Pokémon Details (Includes Moves, Description & Ability Effects)
  Future<Map<String, dynamic>> fetchPokemonDetails(String name) async {
    try {
      // Fetch Pokémon main data
      final response = await _dio.get("pokemon/$name/");
      final Map<String, dynamic> pokemonData = response.data;

      // Fetch Pokémon species (to get description)
      final speciesResponse =
          await _dio.get("pokemon-species/${pokemonData["id"]}/");
      String description = speciesResponse.data["flavor_text_entries"]
          .firstWhere((entry) => entry["language"]["name"] == "en",
              orElse: () =>
                  {"flavor_text": "No description available."})["flavor_text"]
          .replaceAll("\n", " ")
          .replaceAll("\f", " "); // ✅ Remove formatting issues

      // Fetch Ability details (Effect & Short Effect)
      String effect = "No effect available.";
      String shortEffect = "No short effect available.";

      if (pokemonData["abilities"] != null &&
          pokemonData["abilities"].isNotEmpty) {
        String abilityUrl = pokemonData["abilities"][0]["ability"]["url"];

        // Fetch ability details
        final abilityResponse = await _dio.get(abilityUrl);
        final Map<String, dynamic> abilityData = abilityResponse.data;

        // Extract English effect
        effect = abilityData["effect_entries"].firstWhere(
            (entry) => entry["language"]["name"] == "en",
            orElse: () => {"effect": "No effect available."})["effect"];

        shortEffect = abilityData["effect_entries"].firstWhere(
            (entry) => entry["language"]["name"] == "en",
            orElse: () =>
                {"short_effect": "No short effect available."})["short_effect"];
      }

      // Add description, effect & shortEffect to Pokémon data
      pokemonData["description"] = description;
      pokemonData["effect"] = effect;
      pokemonData["shortEffect"] = shortEffect;

      return pokemonData;
    } catch (e) {
      throw Exception("Failed to fetch Pokémon details: $e");
    }
  }
}
