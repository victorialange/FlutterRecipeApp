// this will be the screen with more info about a recipe when the user taps on a recipe card from the initial home screen (MaterialPageRoute, navigate/redirect to this widget)
import 'package:flutter/material.dart';
// import recipe model to display in UI
import 'package:recipe_app/models/recipe.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailsScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.label),
      ),
      // displaying details in vertical scroll
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              recipe.image,
              // adding in error image in case image fails to load
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              // displaying recipe title user tapped on
              child: Text(
                recipe.label,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Ingredients:",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            // displaying ingredients as a list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recipe.ingredients.length,
              itemBuilder: (context, index) {
                final ingredient = recipe.ingredients[index];
                return ListTile(
                  title: Text(ingredient),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Instructions:",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                recipe.url,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
