// recipe model that will hold the data from API
class Recipe {
  // initialize variables
  final String label;
  final String image;
  final String source;
  final String url;
  final List<String> ingredients;

  Recipe({
    required this.label,
    required this.image,
    required this.source,
    required this.url,
    required this.ingredients,
  });

  // define factory recipe from json function to instantiate recipe variables from json file retrieved from API
  factory Recipe.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    for (var ingredient in json['ingredients']) {
      ingredients.add(ingredient['text']);
    }
    // return recipe instance with values from json
    return Recipe(
      label: json['label'],
      image: json['image'],
      source: json['source'],
      url: json['url'],
      ingredients: ingredients,
    );
  }
}
