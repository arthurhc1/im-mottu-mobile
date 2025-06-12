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
  late Future<PokemonDetail> _pokeDetail;

  @override
  void initState() {
    _pokeDetail = _pokemonDetailController.fetchDetail(name: widget.pokemonName);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.pokemonName)),
      body: FutureBuilder<PokemonDetail>(
        future: _pokeDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final p = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(p.imageUrl, height: 350),
                      const SizedBox(height: 16),
                      Text('Nome: ${p.name.toUpperCase()}',
                          style: const TextStyle(fontSize: 20)),
                      const SizedBox(height: 8),
                      Text('Altura: ${p.height / 10} m'),
                      Text('Peso: ${p.weight / 10} kg'),
                      const SizedBox(height: 16),
                      const Text(
                        'Tipos:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Wrap(
                        spacing: 8,
                        alignment: WrapAlignment.center,
                        children: p.types.map((type) {
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
                        children: p.abilities.map((ability) {
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
            );
          } else {
            return const Center(child: Text('Nenhum dado encontrado.'));
          }
        },
      ),
    );
  }
}
