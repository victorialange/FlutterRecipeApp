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

// todo: import google fonts (for example Roboto) to get rid of weird character issue with ingredients due to current default font not supporting all unicodes

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // initialize future list variables _recipes (instance of recipe model)
  late Future<List<Recipe>> _recipes;
  late Future<List<Recipe>> _breakfastRecipes;
  late Future<List<Recipe>> _lunchRecipes;
  late Future<List<Recipe>> _dinnerRecipes;
  late Future<List<Recipe>> _dessertRecipes;

  // define _searchRecipes method that returns a future (recipes list) taking in an optional string argument, where the searchRecipes method gets called on a recipeApi instance with either a string argument or an empty string is the input is null (like this data will appear before the user searches for anything)
  Future<List<Recipe>> _searchRecipes({String? query}) async {
    // create new RecipeAPI instance
    RecipeApi recipeApi = RecipeApi();
    // call fetch method defined in recipeAPi class
    List<Recipe> recipes = await recipeApi.searchRecipes(query: query ?? "");
    // return recipe instance populated with data
    return recipes;
  }

  // method for breakfast recipes
  Future<List<Recipe>> _getBreakfastRecipes({String? query}) async {
    // create new RecipeAPI instance
    RecipeApi recipeApi = RecipeApi();
    // call fetch method defined in recipeAPi class
    List<Recipe> breakfastRecipes =
        await recipeApi.getBreakfastRecipes(query: query ?? "");
    // return recipe instance populated with data
    return breakfastRecipes;
  }

  // method for lunch recipes
  Future<List<Recipe>> _getLunchRecipes({String? query}) async {
    // create new RecipeAPI instance
    RecipeApi recipeApi = RecipeApi();
    // call fetch method defined in recipeAPi class
    List<Recipe> lunchRecipes =
        await recipeApi.getLunchRecipes(query: query ?? "");
    // return recipe instance populated with data
    return lunchRecipes;
  }

  // method for dinner recipes
  Future<List<Recipe>> _getDinnerRecipes({String? query}) async {
    // create new RecipeAPI instance
    RecipeApi recipeApi = RecipeApi();
    // call fetch method defined in recipeAPi class
    List<Recipe> dinnerRecipes =
        await recipeApi.getDinnerRecipes(query: query ?? "");
    // return recipe instance populated with data
    return dinnerRecipes;
  }

  // method for dessert recipes
  Future<List<Recipe>> _getDessertRecipes({String? query}) async {
    // create new RecipeAPI instance
    RecipeApi recipeApi = RecipeApi();
    // call fetch method defined in recipeAPi class
    List<Recipe> dessertRecipes =
        await recipeApi.getDessertRecipes(query: query ?? "");
    // return recipe instance populated with data
    return dessertRecipes;
  }

  @override
  // initialize the state
  void initState() {
    super.initState();
    // set the initial state of the _recipes list to the data retrieved from fetch method with an empty string argument
    _recipes = _searchRecipes(query: "");
    // breakfast recipes
    _breakfastRecipes = _getBreakfastRecipes(query: "");
    // lunch recipes
    _lunchRecipes = _getLunchRecipes(query: "");
    // dinner recipes
    _dinnerRecipes = _getDinnerRecipes(query: "");
    // dessert recipes
    _dessertRecipes = _getDessertRecipes(query: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tastefully Green"),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xffF7F7F7),
          ),
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: [
              // wrap column with text content inside padding for better spacing
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  // align text content to the left
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      "Hello there",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "What are we gonna cook today?",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              // extra space between text and search bar
              const SizedBox(height: 16),
              // using recipe search bar widget, onSearch gets assigned a anonymous function that takes in the user input (string argument) and updates the state of the _recipes list, calling the fetch method defined in the API class, with the user input as the string argument (initial state called fetch method with empty string)
              RecipeSearchBar(onSearch: (String query) {
                setState(() {
                  _recipes = _searchRecipes(query: query);
                  _breakfastRecipes = _getBreakfastRecipes(query: query);
                  _lunchRecipes = _getLunchRecipes(query: query);
                  _dinnerRecipes = _getDinnerRecipes(query: query);
                });
              }),
              // space between search bar and fetch results
              const SizedBox(height: 16),
              // presenting the fetched data in vertical scroll view with multiple horizontally aligned lists of data
              SingleChildScrollView(
                // use column to display multiple rows of recipe data vertically (for now using same data for both rows, will be sorted by meal type based on different fetch methods with different parameters)
                // have one list of results take up a limited amount of height for more rows
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // children are the headings adding more context to fetched data, the data itself and boxes adding space between each child
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 7.5, right: 2.5),
                      // have heading be displayed next to see more option above header
                      child: Row(
                        // separate heading and see all option
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Text(
                            "All recipes",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            "See all",
                            style: TextStyle(
                                color: Color(0xff0B9A61),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    // sized box to contain horizontal scrollable recipe list with specified height
                    SizedBox(
                      height: 275,
                      // LayoutBuilder widget to get the constraints of the parent widget and passing those constraints to ListView, so that it knows how much horizontal space available
                      // wrap recipe card with fixed width of cardWidth (depending on width of the screen)
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return FutureBuilder(
                            future: _recipes,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                // use snapshot data as List<Recipe> widget stored in recipes variable
                                List<Recipe> recipes =
                                    snapshot.data as List<Recipe>;
                                // define cardWidth based on constraints
                                double cardWidth = constraints.maxWidth / 1.5;
                                // double cardWidth =
                                //     MediaQuery.of(context).size.width * 0.7;

                                // if there is more space available, increase card width
                                if (constraints.maxWidth >= 600) {
                                  cardWidth = constraints.maxWidth / 3;
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
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          );
                        },
                      ),
                    ),
                    // space between all recipes list and breakfast recipe heading
                    const SizedBox(height: 16),
                    // breakfast recipes heading
                    Padding(
                      padding: const EdgeInsets.only(left: 7.5, right: 2.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Text(
                            "Breakfast recipes",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            "See all",
                            style: TextStyle(
                                color: Color(0xff0B9A61),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    // breakfast recipes list
                    SizedBox(
                      height: 275,
                      // LayoutBuilder widget to get the constraints of the parent widget and passing those constraints to ListView, so that it knows how much horizontal space available
                      // wrap recipe card with fixed width of cardWidth (depending on width of the screen)
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return FutureBuilder(
                            future: _breakfastRecipes,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                // use snapshot data as List<Recipe> widget stored in recipes variable
                                List<Recipe> breakfastRecipes =
                                    snapshot.data as List<Recipe>;
                                // define cardWidth based on constraints
                                double cardWidth = constraints.maxWidth / 1.5;
                                // double cardWidth =
                                //     MediaQuery.of(context).size.width * 0.7;

                                // if there is more space available, increase card width
                                if (constraints.maxWidth >= 600) {
                                  cardWidth = constraints.maxWidth / 3;
                                }
                                // return results in scrollable list view
                                return ListView.builder(
                                  // display results in horizontal scrollable list
                                  scrollDirection: Axis.horizontal,
                                  itemCount: breakfastRecipes.length,
                                  itemBuilder: (context, index) {
                                    // set size restrictions
                                    return SizedBox(
                                      // height: 50,
                                      width: cardWidth,
                                      // padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: RecipeCard(
                                          recipe: breakfastRecipes[index]),
                                    );
                                  },
                                );
                              }
                              // if there is an error display the specific error message
                              else if (snapshot.hasError) {
                                return Center(child: Text("${snapshot.error}"));
                              }
                              // if data hasn't been retreived yet (connectionState is pending/waiting, display progress indicator)
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          );
                        },
                      ),
                    ),
                    // space between breakfast recipes list and lunch recipe heading
                    const SizedBox(height: 16),
                    // lunch recipes heading
                    Padding(
                      padding: const EdgeInsets.only(left: 7.5, right: 2.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Text(
                            "Lunch recipes",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            "See all",
                            style: TextStyle(
                                color: Color(0xff0B9A61),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    // lunch recipes list
                    SizedBox(
                      height: 275,
                      // LayoutBuilder widget to get the constraints of the parent widget and passing those constraints to ListView, so that it knows how much horizontal space available
                      // wrap recipe card with fixed width of cardWidth (depending on width of the screen)
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return FutureBuilder(
                            future: _lunchRecipes,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                // use snapshot data as List<Recipe> widget stored in recipes variable
                                List<Recipe> lunchRecipes =
                                    snapshot.data as List<Recipe>;
                                // define cardWidth based on constraints
                                double cardWidth = constraints.maxWidth / 1.5;
                                // double cardWidth =
                                //     MediaQuery.of(context).size.width * 0.7;

                                // if there is more space available, increase card width
                                if (constraints.maxWidth >= 600) {
                                  cardWidth = constraints.maxWidth / 3;
                                }
                                // return results in scrollable list view
                                return ListView.builder(
                                  // display results in horizontal scrollable list
                                  scrollDirection: Axis.horizontal,
                                  itemCount: lunchRecipes.length,
                                  itemBuilder: (context, index) {
                                    // set size restrictions
                                    return SizedBox(
                                      // height: 50,
                                      width: cardWidth,
                                      // padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: RecipeCard(
                                          recipe: lunchRecipes[index]),
                                    );
                                  },
                                );
                              }
                              // if there is an error display the specific error message
                              else if (snapshot.hasError) {
                                return Center(child: Text("${snapshot.error}"));
                              }
                              // if data hasn't been retreived yet (connectionState is pending/waiting, display progress indicator)
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          );
                        },
                      ),
                    ),
                    // space between lunch recipes list and dinner recipe heading
                    const SizedBox(height: 16),
                    // dinner recipes heading
                    Padding(
                      padding: const EdgeInsets.only(left: 7.5, right: 2.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Text(
                            "Dinner recipes",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            "See all",
                            style: TextStyle(
                                color: Color(0xff0B9A61),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    // dinner recipes list
                    SizedBox(
                      height: 275,
                      // LayoutBuilder widget to get the constraints of the parent widget and passing those constraints to ListView, so that it knows how much horizontal space available
                      // wrap recipe card with fixed width of cardWidth (depending on width of the screen)
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return FutureBuilder(
                            future: _dinnerRecipes,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                // use snapshot data as List<Recipe> widget stored in recipes variable
                                List<Recipe> dinnerRecipes =
                                    snapshot.data as List<Recipe>;
                                // define cardWidth based on constraints
                                double cardWidth = constraints.maxWidth / 1.5;
                                // double cardWidth =
                                //     MediaQuery.of(context).size.width * 0.7;

                                // if there is more space available, increase card width
                                if (constraints.maxWidth >= 600) {
                                  cardWidth = constraints.maxWidth / 3;
                                }
                                // return results in scrollable list view
                                return ListView.builder(
                                  // display results in horizontal scrollable list
                                  scrollDirection: Axis.horizontal,
                                  itemCount: dinnerRecipes.length,
                                  itemBuilder: (context, index) {
                                    // set size restrictions
                                    return SizedBox(
                                      // height: 50,
                                      width: cardWidth,
                                      // padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: RecipeCard(
                                          recipe: dinnerRecipes[index]),
                                    );
                                  },
                                );
                              }
                              // if there is an error display the specific error message
                              else if (snapshot.hasError) {
                                return Center(child: Text("${snapshot.error}"));
                              }
                              // if data hasn't been retreived yet (connectionState is pending/waiting, display progress indicator)
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          );
                        },
                      ),
                    ),
                    // space between dinner recipes list and dessert recipe heading
                    const SizedBox(height: 16),
                    // dessert recipes heading
                    Padding(
                      padding: const EdgeInsets.only(left: 7.5, right: 2.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Text(
                            "Dessert recipes",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            "See all",
                            style: TextStyle(
                                color: Color(0xff0B9A61),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    // dessert recipes list
                    SizedBox(
                      height: 275,
                      // LayoutBuilder widget to get the constraints of the parent widget and passing those constraints to ListView, so that it knows how much horizontal space available
                      // wrap recipe card with fixed width of cardWidth (depending on width of the screen)
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return FutureBuilder(
                            future: _dessertRecipes,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                // use snapshot data as List<Recipe> widget stored in recipes variable
                                List<Recipe> dessertRecipes =
                                    snapshot.data as List<Recipe>;
                                // define cardWidth based on constraints
                                double cardWidth = constraints.maxWidth / 1.5;
                                // double cardWidth =
                                //     MediaQuery.of(context).size.width * 0.7;

                                // if there is more space available, increase card width
                                if (constraints.maxWidth >= 600) {
                                  cardWidth = constraints.maxWidth / 3;
                                }
                                // return results in scrollable list view
                                return ListView.builder(
                                  // display results in horizontal scrollable list
                                  scrollDirection: Axis.horizontal,
                                  itemCount: dessertRecipes.length,
                                  itemBuilder: (context, index) {
                                    // set size restrictions
                                    return SizedBox(
                                      // height: 50,
                                      width: cardWidth,
                                      // padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: RecipeCard(
                                          recipe: dessertRecipes[index]),
                                    );
                                  },
                                );
                              }
                              // if there is an error display the specific error message
                              else if (snapshot.hasError) {
                                return Center(child: Text("${snapshot.error}"));
                              }
                              // if data hasn't been retreived yet (connectionState is pending/waiting, display progress indicator)
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
