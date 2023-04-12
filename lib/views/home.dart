// this will be the home screen UI where all the other custom widgets with the relevant data gets displayed
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import recipe model
import 'package:recipe_app/models/recipe.dart';
// import recipe api client
import 'package:recipe_app/services/recipe_api.dart';
// import recipe card widget
import 'package:recipe_app/views/widgets/recipe_card.dart';
// import recipe search bar widget
import 'package:recipe_app/views/widgets/recipe_search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // initialize future list variables _recipes (instance of recipe model)
  late Future<List<Recipe>> _recipes;

  // define _searchRecipes method that returns a future (recipes list) taking in an optional string argument, where the searchRecipes method gets called on a recipeApi instance with either a string argument or an empty string is the input is null (like this data will appear before the user searches for anything)
  Future<List<Recipe>> _searchRecipes({String? query}) async {
    // create new RecipeAPI instance
    RecipeApi recipeApi = RecipeApi();
    // call fetch method defined in recipeAPi class
    List<Recipe> recipes = await recipeApi.searchRecipes(query: query ?? "");
    // return recipe instance populated with data
    return recipes;
  }

  @override
  // initialize the state
  void initState() {
    super.initState();
    // set the initial state of the _recipes list to the data retrieved from fetch method with an empty string argument
    _recipes = _searchRecipes(query: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipe App"),
      ),
      body: Column(
        children: [
          // space between app bar and search bar
          const SizedBox(height: 16),
          // using recipe search bar widget, onSearch gets assigned a anonymous function that takes in the user input (string argument) and updates the state of the _recipes list, calling the fetch method defined in the API class, with the user input as the string argument (initial state called fetch method with empty string)
          RecipeSearchBar(onSearch: (String query) {
            setState(() {
              _recipes = _searchRecipes(query: query);
            });
          }),
          // space between search bar and fetch results
          const SizedBox(height: 16),
          // fetch results in expanded widget to take up all available space of device
          // have one list of results take up a limited amount of height for more rows
          SizedBox(
            height: 250,
            // LayoutBuilder widget to get the constraints of the parent widget and passing those constraints to ListView, so that it knows how much horizontal space available
            // wrap recipe card with fixed width of cardWidth (depending on width of the screen)
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return FutureBuilder(
                  future: _recipes,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      // use snapshot data as List<Recipe> widget stored in recipes variable
                      List<Recipe> recipes = snapshot.data as List<Recipe>;
                      // define cardWidth based on constraints
                      double cardWidth = constraints.maxWidth / 1.75;
                      // double cardWidth =
                      //     MediaQuery.of(context).size.width * 0.7;

                      // if there is more space available, increase card width
                      if (constraints.maxWidth >= 600) {
                        cardWidth = constraints.maxWidth / 4;
                      }
                      // return results in scrollable list view
                      return ListView.builder(
                        // display results in horizontal scrollable list
                        scrollDirection: Axis.horizontal,
                        itemCount: recipes.length,
                        itemBuilder: (context, index) {
                          // set size restrictions
                          return SizedBox(
                            // height: 50,
                            width: cardWidth,
                            // padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: RecipeCard(recipe: recipes[index]),
                          );
                        },
                      );
                    }
                    // if there is an error display the specific error message
                    else if (snapshot.hasError) {
                      return Center(child: Text("${snapshot.error}"));
                    }
                    // if data hasn't been retreived yet (connectionState is pending/waiting, display progress indicator)
                    return const Center(child: CircularProgressIndicator());
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
