class Berry {
  final int id;
  final String name;
  final String effect;
  final String spriteUrl;
  bool favorite;

  Berry({
    required this.id,
    required this.name,
    required this.effect,
    required this.spriteUrl,
    this.favorite = false,
  });

  factory Berry.fromApi(Map map) {
    return Berry(
      id: map['id'],
      name: (map['name'] as String).replaceAll('-berry', ''),
      effect: map['effect_entries'][0]['short_effect'],
      spriteUrl: map['sprites']['default'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Berry && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
