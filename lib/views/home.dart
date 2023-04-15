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
                        return const Center(child: CircularProgressIndicator());
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
