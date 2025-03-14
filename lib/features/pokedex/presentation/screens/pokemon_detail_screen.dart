import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/models/pokemon.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(pokemon.name.toUpperCase()), backgroundColor: Colors.red),
      body: Column(
        children: [
          CachedNetworkImage(
            imageUrl: pokemon.imageUrl,
            height: 200,
          ),
          Text(
            pokemon.name.toUpperCase(),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text("ID: #${pokemon.id}"),
          const SizedBox(height: 10),
          Text("Type: ${pokemon.types.join(', ')}"),
          const SizedBox(height: 10),
          Text("Weight: ${pokemon.weight} kg"),
          Text("Height: ${pokemon.height} m"),
          const SizedBox(height: 10),
          const Text("Base Stats",
              style: TextStyle(fontWeight: FontWeight.bold)),
          Column(
            children: pokemon.stats.entries
                .map((stat) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(stat.key),
                          LinearProgressIndicator(value: stat.value / 100),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
