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
  final TextEditingController _searchController = TextEditingController();
  late Future<List<Pokemon>> _pokeList;
  List<Pokemon> _allPokemons = [];
  List<Pokemon> _filteredPokemons = [];
  bool _showFilter = false;

  @override
  void initState() {
    super.initState();
    _pokeList = _controller.fetchPokemons().then((list) {
      _allPokemons = list;
      _filteredPokemons = list;
      return list;
    });
  }

  void _filterPokemons(String query) {
    setState(() {
      _filteredPokemons = _allPokemons.where((pokemon) {
        return pokemon.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PokeAPI - Mottu'),
        actions: [
          IconButton(
            icon: Icon(_showFilter ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _showFilter = !_showFilter;
                if (!_showFilter) {
                  _searchController.clear();
                  _filteredPokemons = _allPokemons;
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Visibility(
            visible: _showFilter,
            maintainAnimation: true,
            maintainState: true,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterPokemons,
                    decoration: InputDecoration(
                      hintText: 'Buscar Pokémon...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Pokemon>>(
              future: _pokeList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: _filteredPokemons.length,
                    itemBuilder: (context, index) {
                      final pokemon = _filteredPokemons[index];
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
