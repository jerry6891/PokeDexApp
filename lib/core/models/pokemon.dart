class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final double weight;
  final double height;
  final Map<String, int> stats;
  final List<String> moves; // ✅ Add Moves
  final String effect; // ✅ Change from description to effect
  final String shortEffect; // ✅ Short version of effect

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.weight,
    required this.height,
    required this.stats,
    required this.moves, // ✅ Initialize Moves
    required this.effect, // ✅ Initialize Effect
    required this.shortEffect, // ✅ Initialize Short Effect
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json["id"],
      name: json["name"],
      imageUrl: json["sprites"]["other"]["official-artwork"]["front_default"],
      types: (json["types"] as List)
          .map((t) => t["type"]["name"].toString())
          .toList(),
      weight: json["weight"] / 10, // Convert to kg
      height: json["height"] / 10, // Convert to meters
      stats: {
        "HP": json["stats"][0]["base_stat"],
        "ATK": json["stats"][1]["base_stat"],
        "DEF": json["stats"][2]["base_stat"],
        "SATK": json["stats"][3]["base_stat"],
        "SDEF": json["stats"][4]["base_stat"],
        "SPD": json["stats"][5]["base_stat"],
      },
      moves: (json["moves"] as List)
          .take(5)
          .map((m) => m["move"]["name"].toString())
          .toList(), // ✅ Fetch top 5 moves
      effect: json["effect"] ?? "No effect available.",
      shortEffect: json["shortEffect"] ?? "No short effect available.",
    );
  }
}
