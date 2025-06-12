class PokemonDetail {
  final String name;
  final int height;
  final int weight;
  final List<String> types;
  final List<String> abilities;
  final String imageUrl;

  PokemonDetail({
    required this.name,
    required this.height,
    required this.weight,
    required this.types,
    required this.abilities,
    required this.imageUrl,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    return PokemonDetail(
      name: json['name'],
      height: json['height'],
      weight: json['weight'],
      types: List<String>.from(json['types'].map((t) => t['type']['name'])),
      abilities: List<String>.from(json['abilities'].map((a) => a['ability']['name'])),
      imageUrl: json['sprites']['other']['official-artwork']['front_default'] ??
          json['sprites']['front_default'],
    );
  }
}