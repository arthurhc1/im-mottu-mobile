class PokemonDetail {
  final String name;
  final int height;
  final int weight;
  final String imageUrl;

  PokemonDetail({
    required this.name,
    required this.height,
    required this.weight,
    required this.imageUrl,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    return PokemonDetail(
      name: json['name'],
      height: json['height'],
      weight: json['weight'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'] ??
          json['sprites']['front_default'],
    );
  }
}