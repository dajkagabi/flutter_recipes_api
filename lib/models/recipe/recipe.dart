/// Ez az osztály tartalmazza a recept leírásához szükséges mezőket, beleértve
/// az egyedi azonosítóját, címét, leírását és a kép URL-jét.
class Recipe {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  /// Új Recipe példány létrehozása.
  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  /// Új Recipe példány létrehozása egy JSON objektumból.
  /// A JSON objektumnak a következő kulcsokat kell tartalmaznia:
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'].toString(),
      title: json['name'],
      description: json['description'] ?? '',
      imageUrl: json['thumbnail_url'],
    );
  }
}
