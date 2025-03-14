import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/models/pokemon.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailScreen({Key? key, required this.pokemon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pokemon.name.toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CachedNetworkImage(
                imageUrl: pokemon.imageUrl,
                height: 200,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Type: ${pokemon.types.join(', ')}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text("Weight: ${pokemon.weight} kg"),
            Text("Height: ${pokemon.height} m"),
            const SizedBox(height: 20),
            const Text(
              "Base Stats",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Fix: Wrap LinearProgressIndicator inside a SizedBox or Expanded
            Column(
              children: pokemon.stats.entries.map((stat) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 50,
                          child: Text(stat.key,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold))),
                      const SizedBox(width: 10),
                      Expanded(
                        child: LinearProgressIndicator(
                          value:
                              stat.value / 100, // Normalize value (max is 100)
                          minHeight: 8,
                          backgroundColor: Colors.grey.shade300,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(stat.value.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
