import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pokeapp_mottu/models/pokemon.dart';

class PokemonController {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2'));

  CacheOptions? _cacheOptions;

  Future<void> _initCache() async {
    final dir = await getApplicationDocumentsDirectory();
    _cacheOptions = CacheOptions(
      store: HiveCacheStore(dir.path),
      policy: CachePolicy.refresh,
      hitCacheOnErrorExcept: [401, 403],
      maxStale: const Duration(days: 1),
    );
  }

  Future<List<Pokemon>> fetchPokemons({int limit = 100, int offset = 0}) async {
    try {

      if (_cacheOptions == null) {
        await _initCache();
      }

      final response = await _dio.get('/pokemon',
        queryParameters: {'limit': limit, 'offset': offset},
          options: Options(
          extra: _cacheOptions!.toExtra(),
        ),
      );

      final results = response.data['results'] as List;
      return results.map((json) => Pokemon.fromJson(json)).toList();

    } catch (e) {
      throw Exception('Erro ao buscar os pokémons: $e');
    }
  }

}