import 'dart:convert';

import 'package:flutter_recipes_api/models/recipe/recipe.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl =
      'https://www.themealdb.com/api/json/v1/1/search.php?s=';

  Future<List<Recipe>> fetchRecipes() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json['meals'];
      List<Recipe> recipes =
          body.map((dynamic item) => Recipe.fromJson(item)).toList();
      return recipes;
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
