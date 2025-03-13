class Pokemon {
  final String name;
  final int id;
  final String imageUrl;
  final List<String> types;
  final double weight;
  final double height;
  final Map<String, int> stats;

  Pokemon({
    required this.name,
    required this.id,
    required this.imageUrl,
    required this.types,
    required this.weight,
    required this.height,
    required this.stats,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      id: json['id'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
      types: (json['types'] as List)
          .map((type) => type['type']['name'].toString())
          .toList(),
      weight: json['weight'] / 10.0, // Convert to kg
      height: json['height'] / 10.0, // Convert to meters
      stats: {
        'HP': json['stats'][0]['base_stat'],
        'ATK': json['stats'][1]['base_stat'],
        'DEF': json['stats'][2]['base_stat'],
        'SATK': json['stats'][3]['base_stat'],
        'SDEF': json['stats'][4]['base_stat'],
        'SPD': json['stats'][5]['base_stat'],
      },
    );
  }
}
