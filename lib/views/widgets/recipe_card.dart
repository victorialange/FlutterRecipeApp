// custom recipe widget - this will contain the layout for the recipe card used in the home screen
import 'package:flutter/material.dart';
// import recipe model to display data
import 'package:recipe_app/models/recipe.dart';
// import cached network image package to display images from a URL (can cache and load images from the network, so reduced number of network requests and able to store images in a local cache for increased speed in retrieving data and better performance)
import 'package:cached_network_image/cached_network_image.dart';
// import recipe details screen widget to use it as redirect in gesture detector
import 'package:recipe_app/views/recipe_details_screen.dart';

class RecipeCard extends StatelessWidget {
  // access data from recipe model
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
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
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                // recipe source
                child: Text(
                  recipe.label,
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 2,
                  // in case of overflow account for it with ellipsis(3 dots)
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // space between recipe title and source
              // const SizedBox(height: 8),
              // have source and heart icon appear on same line
              Row(
                // spread source and icon apart
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // recipe source
                  Text(
                    "by ${recipe.source}",
                    style: Theme.of(context).textTheme.bodySmall,
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
