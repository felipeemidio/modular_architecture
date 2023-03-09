class Pokemon {
  final int id;
  final String name;
  final String spriteUrl;
  final String artworkUrl;
  final List<String> types;
  bool favorite;

  Pokemon({
    required this.id,
    required this.name,
    required this.spriteUrl,
    required this.artworkUrl,
    required this.types,
    this.favorite = false,
  });

  factory Pokemon.fromApi(Map map) {
    return Pokemon(
        id: map['id'],
        name: map['name'],
        spriteUrl: map['sprites']['front_default'],
        artworkUrl: map['sprites']['other']['official-artwork']['front_default'],
        types: (map['types'] as List).map((e) => e['type']['name'] as String).toList(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pokemon && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
