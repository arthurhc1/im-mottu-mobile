import 'package:pokeapp_mottu/models/pokemon_detail.dart';
import 'package:dio/dio.dart';

class PokemonDetailController{

  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2'));

  Future<PokemonDetail> fetchDetail({required String name}) async {
    try {

      final response = await _dio.get('/pokemon/$name');
      return PokemonDetail.fromJson(response.data);
    } catch (e) {
      throw Exception('Erro ao buscar os pokémons: $e');
    }
  }


}