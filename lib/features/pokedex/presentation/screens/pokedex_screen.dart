import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/pokedex_provider.dart';
import '../widgets/pokemon_card.dart';

class PokedexScreen extends StatefulWidget {
  const PokedexScreen({super.key});

  @override
  PokedexScreenState createState() => PokedexScreenState();
}

class PokedexScreenState extends State<PokedexScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      Provider.of<PokedexProvider>(context, listen: false).fetchPokemon();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PokedexProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pokédex",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort, color: Colors.white),
            onPressed: () => _showSortDialog(provider),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search Pokémon",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) {
                // provider.sortPokemon(value);
                provider.searchPokemon(value);
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: provider.isLoading && provider.pokemonList.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      controller: _scrollController,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: provider.pokemonList.length,
                      itemBuilder: (context, index) {
                        return PokemonCard(
                          pokemonList: provider.pokemonList,
                          index: index,
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSortDialog(PokedexProvider provider) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Sort by"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("Number"),
                leading: Radio(
                  value: "number",
                  groupValue: provider.sortType,
                  onChanged: (value) {
                    provider.sortPokemon("number");
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: const Text("Name"),
                leading: Radio(
                  value: "name",
                  groupValue: provider.sortType,
                  onChanged: (value) {
                    provider.sortPokemon("name");
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
