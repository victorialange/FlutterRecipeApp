// this will be the home screen UI where all the other custom widgets with the relevant data gets displayed
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import recipe model
import 'package:recipe_app/models/recipe.dart';
// import recipe api client
import 'package:recipe_app/services/recipe_api.dart';
import 'package:recipe_app/views/widgets/initial_horizontal_lists/initial_list_view.dart';
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
  // late Future<List<Recipe>> _searchedRecipes;
  bool _isLoading = false;
  late List<Recipe> _searchedRecipes = [];
  String _query = "";

  Future<void> _getRecipes(String query) async {
    final recipeApi = RecipeApi();
    _isLoading = true;
    final searchedRecipes = await recipeApi.searchRecipes(query);
    setState(() {
      _searchedRecipes = searchedRecipes;
      _isLoading = false;
    });
  }

  // @override
  // // initialize the state
  // void initState() {
  //   super.initState();
  //   // set the initial state of the _recipes list to the data retrieved from fetch method with an empty string argument
  //   _searchedRecipes = _searchRecipes("");
  // }

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
                _query = query;
                _getRecipes(query);
              }),
              // space between search bar and fetch results
              const SizedBox(height: 16),
              if (_query.isEmpty)
                // presenting the fetched data in vertical scroll view with multiple horizontally aligned lists of data initially before user searches for recipes
                const SingleChildScrollView(
                  child: InitialListView(),
                )
              // when user searches for recipe return vertical scrollable list of results matching user input
              else
                _isLoading
                    ? const LinearProgressIndicator()
                    : _searchedRecipes.isEmpty && _query.isNotEmpty
                        ? Column(children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 7.5, right: 2.5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Sorry, no recipes found for '$_query' :(",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 141, 18, 9)),
                                    ),
                                  ),
                                  Expanded(
                                    child: Visibility(
                                      visible: _query.isNotEmpty && !_isLoading,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton.icon(
                                            onPressed: _clearSearch,
                                            label: const Text(
                                              "Clear Search",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff0B9A61),
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 210, 223, 211)),
                                            ),
                                            icon: const Icon(
                                              Icons.clear,
                                              color: Color(0xff0B9A61),
                                              semanticLabel:
                                                  "Close search and return to home screen",
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Image.network(
                                'https://media2.giphy.com/media/Yoi7H75JB38dHERFVB/giphy.gif'),
                          ])
                        : Padding(
                            padding:
                                const EdgeInsets.only(left: 7.5, right: 2.5),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Text(
                                    "Your results for '$_query'",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  )),
                                  Expanded(
                                    child: Visibility(
                                      visible: _query.isNotEmpty && !_isLoading,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton.icon(
                                            onPressed: _clearSearch,
                                            label: const Text(
                                              "Clear Search",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff0B9A61),
                                                  backgroundColor:
                                                      Color(0xffE3EEE4)),
                                            ),
                                            icon: const Icon(
                                              Icons.clear,
                                              color: Color(0xff0B9A61),
                                              semanticLabel:
                                                  "Close search and return to home screen",
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
              const SizedBox(
                height: 8.0,
              ),
              SingleChildScrollView(
                child: ListView.builder(
                  semanticChildCount: _searchedRecipes.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _searchedRecipes.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 270,
                      child: RecipeCard(
                        recipe: _searchedRecipes[index],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
