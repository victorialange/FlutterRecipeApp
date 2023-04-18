import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/services/recipe_api.dart';
import 'package:recipe_app/views/widgets/recipe_card.dart';

class BreakfastList extends StatefulWidget {
  const BreakfastList({super.key});

  @override
  _BreakfastListState createState() => _BreakfastListState();
}

class _BreakfastListState extends State<BreakfastList> {
  late Future<List<Recipe>> _breakfastRecipes;

  // method for breakfast recipes
  Future<List<Recipe>> _getBreakfastRecipes() async {
    // create new RecipeAPI instance
    RecipeApi recipeApi = RecipeApi();
    // call fetch method defined in recipeAPi class
    List<Recipe> breakfastRecipes = await recipeApi.getBreakfastRecipes();
    // return recipe instance populated with data
    return breakfastRecipes;
  }

  @override
  void initState() {
    super.initState();

    _breakfastRecipes = _getBreakfastRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 275,
      // LayoutBuilder widget to get the constraints of the parent widget and passing those constraints to ListView, so that it knows how much horizontal space available
      // wrap recipe card with fixed width of cardWidth (depending on width of the screen)
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return FutureBuilder(
            future: _breakfastRecipes,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                // use snapshot data as List<Recipe> widget stored in recipes variable
                List<Recipe> recipes = snapshot.data as List<Recipe>;
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
              return const Center(child: LinearProgressIndicator());
            },
          );
        },
      ),
    );
  }
}
