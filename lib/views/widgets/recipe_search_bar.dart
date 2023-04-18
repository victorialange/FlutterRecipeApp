import 'package:flutter/material.dart';

class RecipeSearchBar extends StatefulWidget {
  final void Function(String query) onSearch;
  final void Function() onClose;
  final TextEditingController controller;

  const RecipeSearchBar({
    required this.onSearch,
    required this.onClose,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  _RecipeSearchBarState createState() => _RecipeSearchBarState();
}

class _RecipeSearchBarState extends State<RecipeSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 2.5, left: 7),
      // text field for user input
      child: TextField(
          autofocus: false,
          controller: widget.controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            // placeholder text to tell user what to do
            hintText: "Search recipes...",
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              borderSide: BorderSide(color: Colors.white),
            ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  // clear icon
                  icon: const Icon(
                    Icons.close,
                    semanticLabel:
                        "Press on this button to clear the search bar",
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    widget.controller.clear();
                  },
                ),
                IconButton(
                  // search icon
                  icon: const Icon(
                    Icons.search,
                    semanticLabel:
                        "Press on this button to submit your search for recipes",
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    widget.onSearch(widget.controller.text);
                    widget.controller.clear();
                  },
                ),
              ],
            ),
          ),
          onSubmitted: (query) {
            widget.onSearch.call(query);
            widget.controller.clear();
          }),
    );
  }
}
