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
    // only target vegan recipes by specifying health parameter setting it to 'vegan'
    final response = await http.get(Uri.parse(
        '$_baseUrl?type=public&q=$query&app_id=$_appId&app_key=$_appKey&health=vegan&tag=vegan'));

    // checking if response status code ok
    if (response.statusCode == 200) {
      // decoding the response
      final data = jsonDecode(response.body);
      // fill instance of recipe model with fetched data
      final recipes = List<Recipe>.from(
          // all the relevant data is inside the hits list under the recipe map in the response json object
          data['hits'].map((hit) => Recipe.fromJson(hit['recipe'])));
      return recipes;
    }
    // handle fetch error
    else {
      throw Exception('Failed to load recipes');
    }
  }

  // getting breakfast recipes
  Future<List<Recipe>> getBreakfastRecipes({required String query}) async {
    // only target vegan recipes by specifying health parameter setting it to 'vegan'
    final response = await http.get(Uri.parse(
        '$_baseUrl?type=public&q=$query&app_id=$_appId&app_key=$_appKey&health=vegan&mealType=Breakfast&tag=vegan'));

    // checking if response status code ok
    if (response.statusCode == 200) {
      // decoding the response
      final data = jsonDecode(response.body);
      // fill instance of recipe model with fetched data
      final breakfastRecipes = List<Recipe>.from(
          // all the relevant data is inside the hits list under the recipe map in the response json object
          data['hits'].map((hit) => Recipe.fromJson(hit['recipe'])));
      return breakfastRecipes;
    }
    // handle fetch error
    else {
      throw Exception('Failed to load breakfast recipes');
    }
  }

  // getting lunch recipes
  Future<List<Recipe>> getLunchRecipes({required String query}) async {
    // only target vegan recipes by specifying health parameter setting it to 'vegan'
    final response = await http.get(Uri.parse(
        '$_baseUrl?type=public&q=$query&app_id=$_appId&app_key=$_appKey&health=vegan&mealType=Lunch&dishType=Main%20course&dishType=Salad&tag=vegan'));

    // checking if response status code ok
    if (response.statusCode == 200) {
      // decoding the response
      final data = jsonDecode(response.body);
      // fill instance of recipe model with fetched data
      final lunchRecipes = List<Recipe>.from(
          // all the relevant data is inside the hits list under the recipe map in the response json object
          data['hits'].map((hit) => Recipe.fromJson(hit['recipe'])));
      return lunchRecipes;
    }
    // handle fetch error
    else {
      throw Exception('Failed to load lunch recipes');
    }
  }

  // getting lunch recipes
  Future<List<Recipe>> getDinnerRecipes({required String query}) async {
    // only target vegan recipes by specifying health parameter setting it to 'vegan'
    final response = await http.get(Uri.parse(
        '$_baseUrl?type=public&q=$query&app_id=$_appId&app_key=$_appKey&health=vegan&mealType=Dinner&dishType=Main%20course&dishType=Souo&tag=vegan'));

    // checking if response status code ok
    if (response.statusCode == 200) {
      // decoding the response
      final data = jsonDecode(response.body);
      // fill instance of recipe model with fetched data
      final dinnerRecipes = List<Recipe>.from(
          // all the relevant data is inside the hits list under the recipe map in the response json object
          data['hits'].map((hit) => Recipe.fromJson(hit['recipe'])));
      return dinnerRecipes;
    }
    // handle fetch error
    else {
      throw Exception('Failed to load dinner recipes');
    }
  }
}
