import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/api/poke_api_service.dart';
import 'core/repository/pokedex_repository.dart';
import 'features/pokedex/provider/pokedex_provider.dart';
import 'features/pokedex/presentation/screens/pokedex_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PokedexProvider(
            PokedexRepository(
              PokeApiService(),
            ),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokemon Deck',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'GoogleFonts.poppins',
      ),
      home: PokedexScreen(),
    );
  }
}
