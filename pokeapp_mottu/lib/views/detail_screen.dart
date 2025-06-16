import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokeapp_mottu/models/pokemon_detail.dart';
import 'package:pokeapp_mottu/controllers/pokemon_detail_controller.dart';

class DetailScreen extends StatefulWidget {
  final String pokemonName;
  const DetailScreen({super.key, required this.pokemonName});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  final _pokemonDetailController = PokemonDetailController();
  bool _loading = true;
  PokemonDetail? _pokeDetail;
  String? _error;

  @override
  void initState() {
    _loadDetail();
    super.initState();
  }

  Future<void> _loadDetail() async {
    print('Iniciando loadDetail...');
    try {
      final detail = await _pokemonDetailController.fetchDetail(name: widget.pokemonName);
      print('Pokémon detail carregado com sucesso');

      setState(() {
        _pokeDetail = detail;
        _loading = false;
      });
    } catch (e) {
      print('Erro ao carregar detalhe: $e');
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.pokemonName)),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(child: Text('Erro: $_error'))
          : _pokeDetail == null
          ? const Center(child: Text('Nenhum dado encontrado.'))
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: _pokeDetail!.imageUrl,
                  height: 350,
                  fit: BoxFit.cover,
                  cacheKey: _pokeDetail!.imageUrl,
                  errorWidget: (context, url, error) => const Icon(
                    Icons.broken_image,
                    size: 350,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                Text('Nome: ${_pokeDetail!.name.toUpperCase()}',
                    style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 8),
                Text('Altura: ${_pokeDetail!.height / 10} m'),
                Text('Peso: ${_pokeDetail!.weight / 10} kg'),
                const SizedBox(height: 16),
                const Text(
                  'Tipos:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Wrap(
                  spacing: 8,
                  alignment: WrapAlignment.center,
                  children: _pokeDetail!.types.map((type) {
                    return Chip(
                      label: Text(type),
                      backgroundColor: Colors.lightBlueAccent,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Habilidades:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  alignment: WrapAlignment.center,
                  children: _pokeDetail!.abilities.map((ability) {
                    return Chip(
                      label: Text(ability, style: const TextStyle(color: Colors.white)),
                      backgroundColor: Colors.deepPurple,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
