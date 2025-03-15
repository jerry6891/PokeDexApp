import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/models/pokemon.dart';
import '../screens/pokemon_detail_screen.dart';

class PokemonCard extends StatelessWidget {
  final List<Pokemon> pokemonList; // ✅ Pass full list
  final int index; // ✅ Pass current index

  const PokemonCard({
    super.key,
    required this.pokemonList,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final pokemon = pokemonList[index];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PokemonDetailScreen(
              pokemonList: pokemonList, // ✅ Pass the full list
              currentIndex: index, // ✅ Pass the current Pokémon index
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // ✅ Ensure everything is centered
          children: [
            SizedBox(
              height: 80, // ✅ Ensures consistent height
              width: 80, // ✅ Ensures consistent width
              child: CachedNetworkImage(
                imageUrl: pokemon.imageUrl,
                placeholder: (context, url) => const Center(
                  child: SizedBox(
                    height: 30, // ✅ Keep spinner small and centered
                    width: 30,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, size: 30),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "#${pokemon.id.toString().padLeft(3, '0')}",
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Text(
              pokemon.name.toUpperCase(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
