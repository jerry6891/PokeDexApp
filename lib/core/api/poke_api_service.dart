import 'package:dio/dio.dart';

class PokeApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2/'));

  Future<List<Map<String, dynamic>>> fetchPokemonList(
      int offset, int limit) async {
    final response = await _dio.get('pokemon', queryParameters: {
      'offset': offset,
      'limit': limit,
    });

    return (response.data['results'] as List)
        .map((pokemon) => {'name': pokemon['name'], 'url': pokemon['url']})
        .toList();
  }

  Future<Map<String, dynamic>> fetchPokemonDetails(String name) async {
    final response = await _dio.get('pokemon/$name');
    return response.data;
  }
}
