import 'package:flutter/material.dart';
import 'package:flutter_recipes_api/models/apiservice/api_sercvice.dart';
import 'package:flutter_recipes_api/models/recipe/recipe.dart';

// A HomeScreen egy állapotú widget, amely a recepteket jeleníti meg
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// A HomeScreen állapotának osztálya
class _HomeScreenState extends State<HomeScreen> {
  // Egy jövőbeli lista, amely a recepteket tartalmazza
  late Future<List<Recipe>> futureRecipes;

  @override
  void initState() {
    super.initState();
    // A receptek lekérése az ApiService segítségével
    futureRecipes = ApiService().fetchRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'), // Az AppBar címe
      ),
      body: FutureBuilder<List<Recipe>>(
        future: futureRecipes, // A jövőbeli receptek
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Ha a jövőbeli adatok még töltődnek, egy kör progress indikátort jelenít meg
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Ha hiba történt az adatok lekérése közben, a hibát jeleníti meg
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Ha nincs adat vagy az adat üres, egy üzenetet jelenít meg
            return const Center(child: Text('No recipes found'));
          } else {
            // Ha van adat, egy listát jelenít meg a receptekkel
            return ListView.builder(
              itemCount: snapshot.data!.length, // A receptek száma
              itemBuilder: (context, index) {
                Recipe recipe = snapshot.data![index]; // Az aktuális recept
                return ListTile(
                  title: Text(recipe.title), // A recept címe
                  subtitle: Text(recipe.description), // A recept leírása
                  leading: Image.network(recipe.imageUrl), // A recept képe
                );
              },
            );
          }
        },
      ),
    );
  }
}
