// custom recipe widget - this will contain the layout for the recipe card

import 'package:flutter/material.dart';
// import cached network image package to display images from a URL (can cache and load images from the network, so reduced number of network requests and able to store images in a local cache for increased speed in retrieving data and better performance)
import 'package:cached_network_image/cached_network_image.dart';

// define class for recipe card storing the initial data
class RecipeCard extends StatelessWidget {
  // setting the variables
  final String title;
  final String calories;
  final String cookTime;
  // this will hold the image url
  final String thumbnailUrl;

  const RecipeCard({
    super.key,
    required this.title,
    required this.calories,
    required this.cookTime,
    required this.thumbnailUrl,
  });

  // build method with layout
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      // set the width to the width of the device using MediaQuery
      width: MediaQuery.of(context).size.width,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
        // create a box shadow for thumbnail image
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            offset: const Offset(
              0.0,
              10.0,
            ),
            blurRadius: 10.0,
            spreadRadius: -6.0,
          ),
        ],
        // thumbnail image
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.35),
            BlendMode.multiply,
          ),
          image: NetworkImage(thumbnailUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // align recipe title to center of card
          Align(
            alignment: Alignment.center,
            // use Padding to center title
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              // recipe title
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                // handle text overflow with ellipsis
                overflow: TextOverflow.ellipsis,
                // restrict text to 2 lines
                maxLines: 2,
                // align text to center
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // align cook time and calories to bottom left
          Align(
            alignment: Alignment.bottomLeft,
            // horizontally align cook time and calories
            child: Row(
              // separate cook time and calories with space between
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // calories container
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(10),
                  // box decoration for rounded edges
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // calories
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 18,
                      ),
                      const SizedBox(width: 7),
                      Text(
                        calories,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                // cook time container
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    // round edges of cook time container
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // cook time
                  child: Row(
                    children: [
                      // cook time icon
                      const Icon(
                        Icons.schedule,
                        color: Colors.yellow,
                        size: 18,
                      ),
                      // sized box to separate icon and text
                      const SizedBox(width: 7),
                      // cook time text
                      Text(
                        cookTime,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
