import 'dart:convert';

import 'package:flutter_recipes_api/models/recipe/recipe.dart';
import 'package:http/http.dart' as http;

// Az ApiService osztály, amely a receptek lekéréséért felelős
class ApiService {
  // Az API alap URL-je
  final String baseUrl = 'https://tasty.p.rapidapi.com/recipes/list';

  // A fetchRecipes metódus, amely lekéri a recepteket az API-ból
  Future<List<Recipe>> fetchRecipes() async {
    // HTTP GET kérés küldése az API-hoz
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        // Az API kulcs
        'X-RapidAPI-Key': 'cae1d74ecbmshcc5b359e596a46ap1be93ajsn893653861b45',
        // Az API host
        'X-RapidAPI-Host': 'tasty.p.rapidapi.com',
      },
    );

    // Ellenőrizzük, hogy a válasz státuszkódja 200-e (sikeres kérés)
    if (response.statusCode == 200) {
      // A válasz JSON formátumú adatainak dekódolása
      Map<String, dynamic> json = jsonDecode(response.body);
      // A 'results' kulcs alatt található adatok listájának kinyerése
      List<dynamic> body = json['results'];
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
