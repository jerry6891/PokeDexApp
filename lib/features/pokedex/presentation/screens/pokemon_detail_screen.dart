import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/models/pokemon.dart';

class PokemonDetailScreen extends StatefulWidget {
  final List<Pokemon> pokemonList;
  final int currentIndex;

  const PokemonDetailScreen({
    super.key,
    required this.pokemonList,
    required this.currentIndex,
  });

  @override
  PokemonDetailScreenState createState() => PokemonDetailScreenState();
}

class PokemonDetailScreenState extends State<PokemonDetailScreen> {
  late int currentIndex;
  bool isHoveringTop = false;
  bool isHoveringLeft = false;
  bool isHoveringRight = false;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
  }

  void navigateToPokemon(int newIndex) {
    if (newIndex >= 0 && newIndex < widget.pokemonList.length) {
      setState(() {
        currentIndex = newIndex;
      });
    }
  }

  // 🔹 Define colors for each Pokémon type
  final Map<String, Color> typeColors = {
    "Fire": Colors.orange,
    "Water": Colors.blue,
    "Grass": Colors.green,
    "Electric": Colors.yellow.shade700,
    "Psychic": Colors.pink,
    "Ice": Colors.lightBlue.shade200,
    "Dragon": Colors.purple.shade700,
    "Dark": Colors.brown,
    "Fairy": Colors.pinkAccent,
    "Fighting": Colors.red.shade900,
    "Flying": Colors.blueGrey.shade400,
    "Ghost": Colors.deepPurple,
    "Ground": Colors.brown.shade400,
    "Poison": Colors.purple,
    "Rock": Colors.grey.shade700,
    "Steel": Colors.blueGrey,
    "Bug": Colors.lightGreen.shade600,
    "Normal": Colors.grey.shade500,
  };

  @override
  Widget build(BuildContext context) {
    final pokemon = widget.pokemonList[currentIndex];

    // 🔹 Ensure we get the primary type correctly
    String primaryType = pokemon.types.isNotEmpty
        ? pokemon.types.first[0].toUpperCase() +
            pokemon.types.first.substring(1).toLowerCase()
        : "Normal"; // Default to Normal if no type exists

    // 🔹 Get background color based on type
    Color bgColor = typeColors[primaryType] ?? Colors.grey;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor, // 🔹 Dynamic color
        iconTheme: const IconThemeData(color: Colors.white),
        leading: MouseRegion(
          onEnter: (_) => setState(() => isHoveringTop = true),
          onExit: (_) => setState(() => isHoveringTop = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200), // ✅ Smooth transition
            width: 36, // ✅ Same size as navigation arrows
            height: 36, // ✅ Consistent height
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isHoveringTop
                  ? Colors.black54
                  : Colors.transparent, // ✅ Fully transparent until hovered
            ),
            margin: const EdgeInsets.only(left: 15), // ✅ Adjust spacing
            child: Transform.translate(
              offset: const Offset(2, 0), // ✅ Fine-tuned alignment
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios,
                    color: Colors.white, size: 18), // ✅ Smaller icon
                padding: EdgeInsets.zero, // ✅ Remove extra padding
                constraints:
                    const BoxConstraints(), // ✅ Ensures the button fits inside the smaller circle
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ),

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              pokemon.name.toUpperCase(), // 🔹 Pokémon Name
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "#${pokemon.id.toString().padLeft(3, '0')}", // 🔹 Pokémon ID formatted (#001, #025, etc.)
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    // 🔹 Background Color
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: bgColor, // 🔹 Apply background color
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
                    // 🔹 Semi-Transparent Pokéball Image (Behind Everything)
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.1, // ✅ Set transparency level
                        child: Align(
                          alignment: Alignment.center, // ✅ Center Pokéball
                          child: Image.asset(
                            'assets/images/pokeball.png',
                            width: 350, // ✅ Adjust size to fit nicely
                            height: 350,
                            fit: BoxFit.contain, // ✅ Prevents stretching
                          ),
                        ),
                      ),
                    ),
                    // 🔹 Pokémon Image (Above Background & Pokéball)
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: pokemon.imageUrl,
                        height: 200,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3, // ✅ Keep bottom section intact
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                spreadRadius: 1,
                                offset: const Offset(0, 2),
                              )
                            ],
                          ),
                          child: Text(
                            pokemon.types.join(', '),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: bgColor, // 🔹 Match text color with type
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          "About",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: bgColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Icon(Icons.scale, size: 24),
                              Text("${pokemon.weight} kg"),
                              const Text("Weight"),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(Icons.height, size: 24),
                              Text("${pokemon.height} m"),
                              const Text("Height"),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(Icons.power, size: 24),
                              Text("${pokemon.moves.take(1)}"),
                              const Text("Main Power"),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Pokémon Description
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Center(
                                child: Text(
                                  pokemon.effect.isNotEmpty
                                      ? pokemon.effect
                                      : (pokemon.shortEffect.isNotEmpty
                                          ? pokemon.shortEffect
                                          : "No effect available."),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black87),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Base Stats
                      const Text(
                        "Base Stats",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
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
                                    value: stat.value / 100,
                                    minHeight: 8,
                                    backgroundColor: Colors.grey.shade300,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        bgColor), // 🔹 Match bar color
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(stat.value.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // 🔹 Left Arrow (Previous Pokémon)
          if (currentIndex > 0)
            Positioned(
              left: 10,
              top: MediaQuery.of(context).size.height * 0.3,
              child: MouseRegion(
                onEnter: (_) => setState(() => isHoveringLeft = true),
                onExit: (_) => setState(() => isHoveringLeft = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isHoveringLeft ? Colors.black54 : Colors.transparent,
                  ),
                  child: Transform.translate(
                    offset: const Offset(2, 0),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios,
                          color: Colors.white, size: 20),
                      onPressed: () => navigateToPokemon(currentIndex - 1),
                    ),
                  ),
                ),
              ),
            ),

          // 🔹 Right Arrow (Next Pokémon)
          if (currentIndex < widget.pokemonList.length - 1)
            Positioned(
              right: 10,
              top: MediaQuery.of(context).size.height * 0.3,
              child: MouseRegion(
                onEnter: (_) => setState(() => isHoveringRight = true),
                onExit: (_) => setState(() => isHoveringRight = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        isHoveringRight ? Colors.black54 : Colors.transparent,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios,
                        color: Colors.white, size: 20),
                    onPressed: () => navigateToPokemon(currentIndex + 1),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
