// Recipe model that will hold data from API (Edamam)
class Recipe {
  // initialize variables
  final String label;
  final String images;
  final double calories;
  final String totalTime;

  const Recipe({
    required this.label,
    required this.images,
    required this.calories,
    required this.totalTime,
  });

  // define factory recipe from json function to instantiate recipe variables from json file retrieved from API
  factory Recipe.fromJson(dynamic json) {
    // return Recipe instance with parameters
    return Recipe(
        // set name as string
        label: json['label'] as String,
        // set img as string
        images: json['images']['THUMBNAIL']['url'] as String,
        calories: json['calories'] as double,
        totalTime: json['totalTime'] as String);
  }

  // define recipes from snapshot function to take a list of data that will be converted to a list of recipes
  static List<Recipe> recipesFromShapshot(List snapshot) {
    return snapshot.map((data) {
      // return factory recipe.fromJson
      return Recipe.fromJson(data);
    })
        // this will convert it back to a list
        .toList();
  }
}
