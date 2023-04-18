// this will be the screen with more info about a recipe when the user taps on a recipe card from the initial home screen (MaterialPageRoute, navigate/redirect to this widget)
import 'package:flutter/material.dart';
// import recipe model to display in UI
import 'package:recipe_app/models/recipe.dart';
// import custom progress indicator widget
import 'package:recipe_app/views/widgets/custom_progress_indicator.dart';
// import cached network image for increased performance and easier implementation of custom progress indicator for progressIndicator (vs loadingBuilder)
import 'package:cached_network_image/cached_network_image.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailsScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String cleanedLabel;
    // removing redundant recipe or recipes in title
    if (recipe.label.contains("recipes") ||
        recipe.label.contains("Recipes") ||
        recipe.label.contains("RECIPES")) {
      cleanedLabel =
          recipe.label.replaceAll(RegExp('recipes', caseSensitive: false), '');
      recipe.label.replaceAll(RegExp('Recipes', caseSensitive: false), '');
      recipe.label.replaceAll(RegExp('RECIPES', caseSensitive: false), '');
    } else if (recipe.label.contains("recipe") ||
        recipe.label.contains("Recipe") ||
        recipe.label.contains("RECIPE")) {
      cleanedLabel =
          recipe.label.replaceAll(RegExp('recipe', caseSensitive: false), '');
      recipe.label.replaceAll(RegExp('Recipe', caseSensitive: false), '');
      recipe.label.replaceAll(RegExp('RECIPE', caseSensitive: false), '');
    } else {
      cleanedLabel = recipe.label;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.label),
      ),
      // displaying details in vertical scroll
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CachedNetworkImage(
              imageUrl: recipe.image,
              fit: BoxFit.cover,
              // account for error loading image with icon as placeholder
              errorWidget: (context, url, error) => const Icon(Icons.error),
              // replace default progress indicator with custom one
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CustomProgressIndicator(
                value: downloadProgress.progress ?? 0.0,
                semanticsLabel: 'Loading recipe image',
                semanticsValue: '${downloadProgress.progress ?? 0}% loaded',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              // displaying recipe title user tapped on
              child: Text(
                cleanedLabel.toString(),
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
