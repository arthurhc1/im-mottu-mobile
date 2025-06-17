import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pokeapp_mottu/models/pokemon_detail.dart';

class PokemonDetailController {
  Dio? _dio;
  CacheOptions? _cacheOptions;
  bool _initialized = false;

  Future<void> _init() async {
    if (_initialized) return;

    final dir = await getApplicationDocumentsDirectory();

    _cacheOptions = CacheOptions(
      store: HiveCacheStore(dir.path),
      policy: CachePolicy.refresh,
      hitCacheOnErrorExcept: [401, 403],
      maxStale: const Duration(days: 1),
      priority: CachePriority.normal,
    );

    _dio = Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2'));
    _dio!.interceptors.add(DioCacheInterceptor(options: _cacheOptions!));

    _initialized = true;
  }

  Future<PokemonDetail> fetchDetail({required String name}) async {
    await _init();

    final response = await _dio!.get(
      '/pokemon/$name',
      options: Options(
        extra: _cacheOptions!.toExtra(),
      ),
    );

    return PokemonDetail.fromJson(response.data);
  }
}
