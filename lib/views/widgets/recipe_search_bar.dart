// this will be the search bar shown in the home screen
import 'package:flutter/material.dart';

class RecipeSearchBar extends StatelessWidget {
  final void Function(String query) onSearch;

  const RecipeSearchBar({required this.onSearch, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 2.5, left: 7),
      // text field for user inpute
      child: TextField(
        decoration: InputDecoration(
          // placeholder text to tell user what to do
          hintText: "Search recipes...",
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            // search icon
            icon: const Icon(Icons.search),
            onPressed: () {
              FocusScope.of(context).unfocus();
              onSearch.call("");
            },
          ),
        ),
        // upon submit, i.e. user presses submit button from keyboard, onSubmitted gets assigned to onSearch method initialized in the recipe search bar class that takes a string argument (query) from user input, gets assigned anonymous function in home screen widget where recipes state gets updated and fetch method gets called with user input from search bar)
        onSubmitted: onSearch,
      ),
    );
  }
}
