class Pokemon {
  final String name;
  final String apiUrl;

  Pokemon({required this.name, required this.apiUrl});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      apiUrl: json['url'],
    );
  }

  String get id {
    final parts = apiUrl.split('/');
    return parts[parts.length - 2];
  }

  String get imageUrl {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
  }
}
