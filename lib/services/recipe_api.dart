// import dart:convert in order to convert data retrieved into usable format
import 'dart:convert';
// http package to make http requests
import 'package:http/http.dart' as http;
// import recipe model to fill it with data fetched from API
import 'package:recipe_app/models/recipe.dart';
// import credentials
import 'package:recipe_app/utilities/keys.dart';

class RecipeApi {
  // initialize static variables needed for API call
  static const String _baseUrl = 'https://api.edamam.com/api/recipes/v2';
  static const String _appKey = appKey;
  static const String _appId = appId;

  // fetching data
  Future<List<Recipe>> searchRecipes({required String query}) async {
    List<Recipe> recipes = [];
    String url =
        '$_baseUrl?type=public&q=$query&app_id=$_appId&app_key=$_appKey&health=vegan&random=true&tag=vegan';
    // while loop to keep calling APi + next href endpoint until at least 40 recipes show up
    while (recipes.length < 40) {
      // only target vegan recipes by specifying health parameter setting it to 'vegan'
      final response = await http.get(Uri.parse(url));

      // checking if response status code ok
      if (response.statusCode == 200) {
        // decoding the response
        final data = jsonDecode(response.body);
        final results = data['hits'];

        for (var result in results) {
          final recipe = Recipe.fromJson(result['recipe']);
          recipes.add(recipe);
        }
        // fill instance of recipe model with fetched data
        // final recipes = List<Recipe>.from(
        //     // all the relevant data is inside the hits list under the recipe map in the response json object
        //     data['hits'].map((hit) => Recipe.fromJson(hit['recipe'])));
        if (data['_links'] != null && data['_links']['next'] != null) {
          url = data['_links']['next']['href'];
        } else {
          break;
        }
      }
      // handle fetch error
      else {
        throw Exception('Failed to load recipes');
      }
    }
    return recipes;
  }

  // initializing empty breakfast recipes list to keep pupulating with initial page & next page outside of function to compare with dessert recipes and ensure no duplicates
  List<Recipe> breakfastRecipes = [];
  // getting breakfast recipes
  Future<List<Recipe>> getBreakfastRecipes({required String query}) async {
    String url =
        '$_baseUrl?type=public&q=$query&app_id=$_appId&app_key=$_appKey&health=vegan&mealType=Breakfast&random=true&tag=vegan';

    while (breakfastRecipes.length < 40) {
      // only target vegan recipes by specifying health parameter setting it to 'vegan'
      final response = await http.get(Uri.parse(url));
      // checking if response status code ok
      if (response.statusCode == 200) {
        // decoding the response
        final data = jsonDecode(response.body);
        // fill instance of recipe model with fetched data
        // final breakfastRecipes = List<Recipe>.from(
        //     // all the relevant data is inside the hits list under the recipe map in the response json object
        //     data['hits'].map((hit) => Recipe.fromJson(hit['recipe'])));
        final results = data['hits'];

        for (var result in results) {
          final breakfastRecipe = Recipe.fromJson(result['recipe']);
          breakfastRecipes.add(breakfastRecipe);
        }

        // changing url to next href endpoint if there is one available to get results from next page
        if (data['_links'] != null && data['_links']['next'] != null) {
          url = data['_links']['next']['href'];
        } else {
          break;
        }
      }
      // handle fetch error
      else {
        throw Exception('Failed to load breakfast recipes');
      }
    }
    return breakfastRecipes;
  }

  // defining lunchRecipes list outside of API call function to check in dinner recipes API call whether recipes are already present in that result
  List<Recipe> lunchRecipes = [];
  // getting lunch recipes
  Future<List<Recipe>> getLunchRecipes({required String query}) async {
    // initializing empty breakfast recipes list to keep pupulating with initial page & next page
    String url =
        '$_baseUrl?type=public&q=$query&app_id=$_appId&app_key=$_appKey&health=vegan&mealType=Lunch&dishType=Main%20course&dishType=Salad&random=true&tag=vegan';

    while (lunchRecipes.length < 40) {
      // only target vegan recipes by specifying health parameter setting it to 'vegan'
      final response = await http.get(Uri.parse(url));

      // checking if response status code ok
      if (response.statusCode == 200) {
        // decoding the response
        final data = jsonDecode(response.body);
        // fill instance of recipe model with fetched data
        // final lunchRecipes = List<Recipe>.from(
        //     // all the relevant data is inside the hits list under the recipe map in the response json object
        //     data['hits'].map((hit) => Recipe.fromJson(hit['recipe'])));

        final results = data['hits'];

        for (var result in results) {
          final lunchRecipe = Recipe.fromJson(result['recipe']);
          if (!result['recipe']['label'].contains('dinner')) {
            lunchRecipes.add(lunchRecipe);
          }
        }

        // changing url to next href endpoint if there is one available to get results from next page
        if (data['_links'] != null && data['_links']['next'] != null) {
          url = data['_links']['next']['href'];
        } else {
          break;
        }
      }
      // handle fetch error
      else {
        throw Exception('Failed to load lunch recipes');
      }
    }
    return lunchRecipes;
  }

  // getting dinner recipes
  Future<List<Recipe>> getDinnerRecipes({required String query}) async {
    List<Recipe> dinnerRecipes = [];
    String url =
        '$_baseUrl?type=public&q=$query&app_id=$_appId&app_key=$_appKey&health=vegan&mealType=Dinner&dishType=Main%20course&dishType=Soup&random=true&tag=vegan';
    // only target vegan recipes by specifying health parameter setting it to 'vegan'
    final response = await http.get(Uri.parse(url));

    // checking if response status code ok
    if (response.statusCode == 200) {
      // decoding the response
      final data = jsonDecode(response.body);
      // fill instance of recipe model with fetched data
      // final dinnerRecipes = List<Recipe>.from(
      //     // all the relevant data is inside the hits list under the recipe map in the response json object
      //     data['hits'].map((hit) => Recipe.fromJson(hit['recipe'])));
      final results = data['hits'];

      for (var result in results) {
        final dinnerRecipe = Recipe.fromJson(result['recipe']);
        if (!lunchRecipes.contains(dinnerRecipe)) {
          dinnerRecipes.add(dinnerRecipe);
        }
      }
      return dinnerRecipes;
    }
    // handle fetch error
    else {
      throw Exception('Failed to load dinner recipes');
    }
  }

  // getting dessert recipes
  Future<List<Recipe>> getDessertRecipes({required String query}) async {
    List<Recipe> dessertRecipes = [];
    String url =
        '$_baseUrl?type=public&q=$query&app_id=$_appId&app_key=$_appKey&health=vegan&dishType=Desserts&dishType=Sweets&random=true&tag=vegan';
    // only target vegan recipes by specifying health parameter setting it to 'vegan'
    final response = await http.get(Uri.parse(url));

    // checking if response status code ok
    if (response.statusCode == 200) {
      // decoding the response
      final data = jsonDecode(response.body);
      // fill instance of recipe model with fetched data
      // final dinnerRecipes = List<Recipe>.from(
      //     // all the relevant data is inside the hits list under the recipe map in the response json object
      //     data['hits'].map((hit) => Recipe.fromJson(hit['recipe'])));
      final results = data['hits'];

      for (var result in results) {
        final dessertRecipe = Recipe.fromJson(result['recipe']);
        if (!breakfastRecipes.contains(dessertRecipe)) {
          dessertRecipes.add(dessertRecipe);
        }
      }
      return dessertRecipes;
    }
    // handle fetch error
    else {
      throw Exception('Failed to load dessert recipes');
    }
  }
}
