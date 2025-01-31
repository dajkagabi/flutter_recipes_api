import 'dart:convert';
import 'package:flutter_recipes_api/models/recipe/recipe.dart';
import 'package:http/http.dart' as http;

// Az ApiService osztály, amely a receptek lekéréséért felelős
class ApiService {
  final String baseUrl =
      'https://www.themealdb.com/api/json/v1/1/search.php?s=';
// A fetchRecipes metódus, amely lekéri a recepteket az API-ból
  Future<List<Recipe>> fetchRecipes() async {
    final response = await http.get(Uri.parse(baseUrl));
    // Ellenőrizzük, hogy a válasz státuszkódja 200-e (sikeres kérés)
    if (response.statusCode == 200) {
      // A válasz JSON formátumú adatainak dekódolása
      Map<String, dynamic> json = jsonDecode(response.body);
      // A 'meals' kulcs alatt található adatok listájának kinyerése
      List<dynamic> body = json['meals'];
      // A JSON adatok átalakítása Recipe objektumok listájává
      List<Recipe> recipes =
          body.map((dynamic item) => Recipe.fromJson(item)).toList();
      // A receptek listájának visszaadása
      return recipes;
    } else {
      // Ha a kérés nem sikerült, kivételt dobunk
      throw Exception('Failed to load recipes');
    }
  }
}
