// custom recipe widget - this will contain the layout for the recipe card used in the home screen

import 'package:flutter/material.dart';
// import recipe model to display data
import 'package:recipe_app/models/recipe.dart';
// import cached network image package to display images from a URL (can cache and load images from the network, so reduced number of network requests and able to store images in a local cache for increased speed in retrieving data and better performance)
import 'package:cached_network_image/cached_network_image.dart';
// import recipe details screen widget to use it as redirect in gesture detector
import 'package:recipe_app/views/recipe_details_screen.dart';
// import google fonts - todo: add to home screen as theme font potentially (noto sans)
import 'package:google_fonts/google_fonts.dart';

class RecipeCard extends StatelessWidget {
  // access data from recipe model
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    // List<String> stringsToRemove = ['recipe', 'recipes'];
    final String cleanedLabel;
    // String cleanedLabel = removeStrings(recipe.label, stringsToRemove);
    if (recipe.label.contains("recipes") ||
        recipe.label.contains("Recipes") ||
        recipe.label.contains("RECIPES")) {
      cleanedLabel = recipe.label
          .replaceAll(RegExp('recipes', caseSensitive: false), '')
          .trim();
      recipe.label
          .replaceAll(RegExp('Recipes', caseSensitive: false), '')
          .trim();
      recipe.label
          .replaceAll(RegExp('RECIPES', caseSensitive: false), '')
          .trim();
    } else if (recipe.label.contains("recipe") ||
        recipe.label.contains("Recipe") ||
        recipe.label.contains("RECIPE")) {
      cleanedLabel = recipe.label
          .replaceAll(RegExp('recipe', caseSensitive: false), '')
          .trim();
      recipe.label
          .replaceAll(RegExp('Recipe', caseSensitive: false), '')
          .trim();
      recipe.label
          .replaceAll(RegExp('RECIPE', caseSensitive: false), '')
          .trim();
    } else {
      cleanedLabel = recipe.label;
    }

    // wrap card inside gesture detector to redirect user to recipe details screen upon card tap
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          // redirect to recipeDetailsScreen widget
          MaterialPageRoute(
            builder: (_) => RecipeDetailsScreen(recipe: recipe),
          ),
        );
      },
      // recipe card
      child: Card(
        // add rounded borders to card
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: const Color(0xff91C490).withOpacity(0.2),
            // width: 5,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        borderOnForeground: true,
        shadowColor: const Color(0xff91C490).withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              // image inside rectangle
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  imageUrl: recipe.image,
                  width: double.infinity,
                  height: 175,
                  fit: BoxFit.cover,
                  // account for error loading image with icon as placeholder
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              // space between image and text
              const SizedBox(height: 8),
              // wrap label inside Expanded widget to still show full text in case of longer labels without overflow (expanded will use all the available space)
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    cleanedLabel.toString(),
                    // cleanedLabel,
                    style: GoogleFonts.notoSansDisplay(fontSize: 16.0),
                    textDirection: TextDirection.ltr,
                    maxLines: 2,
                    // in case of overflow account for it with ellipsis(3 dots)
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // recipe source
              ),

              // space between recipe title and source
              // const SizedBox(height: 8),
              // have source and heart icon appear on same line
              Row(
                // spread source and icon apart
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // wrapping text inside expanded widget to account for longer source string and avoid overflow
                  Expanded(
                    // recipe source
                    child: Text(
                      "by ${recipe.source}",
                      style: Theme.of(context).textTheme.bodySmall,
                      // overflow: TextOverflow.ellipsis,
                      // maxLines: 2,
                      softWrap: false,
                    ),
                  ),
                  // favourite heart icon
                  const Icon(Icons.favorite_border, size: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
