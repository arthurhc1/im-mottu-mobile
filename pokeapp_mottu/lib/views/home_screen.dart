import 'package:flutter/material.dart';
import 'package:pokeapp_mottu/models/pokemon.dart';
import 'package:pokeapp_mottu/controllers/pokemon_controller.dart';
import 'package:pokeapp_mottu/views/detail_screen.dart';
import 'widgets/poke_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PokemonController _controller = PokemonController();
  late Future<List<Pokemon>> _pokeList;

  @override
  void initState() {
    super.initState();
    _pokeList = _controller.fetchPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PokeAPI - Mottu')),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Pokemon>>(
              future: _pokeList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final pokemons = snapshot.data!;
                  return ListView.builder(
                    itemCount: pokemons.length,
                    itemBuilder: (context, index) {
                      final pokemon = pokemons[index];
                      return PokeCard(
                        pokemon: pokemon,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailScreen(pokemonName: pokemon.name),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('Nenhum dado encontrado.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
