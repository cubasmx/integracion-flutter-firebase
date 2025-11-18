class Pokemon {
  final String name;
  final List<Ability> abilities;
  final int id;
  final String imageUrl;
  final int height;
  final int weight;

  Pokemon({
    required this.name,
    required this.abilities,
    required this.id,
    required this.imageUrl,
    required this.height,
    required this.weight,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'] ?? '',
      id: json['id'] ?? 0,
      imageUrl: json['sprites']?['front_default'] ?? '',
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      abilities: (json['abilities'] as List<dynamic>?)
              ?.map((ability) => Ability.fromJson(ability))
              .toList() ??
          [],
    );
  }
}

class Ability {
  final String name;
  final bool isHidden;

  Ability({
    required this.name,
    required this.isHidden,
  });

  factory Ability.fromJson(Map<String, dynamic> json) {
    return Ability(
      name: json['ability']?['name'] ?? '',
      isHidden: json['is_hidden'] ?? false,
    );
  }
}

class PokemonListItem {
  final String name;
  final String url;

  PokemonListItem({
    required this.name,
    required this.url,
  });

  factory PokemonListItem.fromJson(Map<String, dynamic> json) {
    return PokemonListItem(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
    );
  }
}

