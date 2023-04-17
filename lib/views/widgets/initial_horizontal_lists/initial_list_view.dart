import 'package:flutter/material.dart';
import 'package:recipe_app/views/widgets/initial_horizontal_lists/meal_type_lists/breakfast_list_view.dart';
import 'package:recipe_app/views/widgets/initial_horizontal_lists/meal_type_lists/lunch_list_view.dart';
import 'package:recipe_app/views/widgets/initial_horizontal_lists/meal_type_lists/dinner_list_view.dart';
import 'package:recipe_app/views/widgets/initial_horizontal_lists/meal_type_lists/dessert_list_view.dart';
import 'package:recipe_app/views/widgets/initial_horizontal_lists/random_recipes_list.dart';

class InitialListView extends StatelessWidget {
  const InitialListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
        const RandomRecipeList(),
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
        const BreakfastList(),
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
        const LunchList(),
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
        const DinnerList(),
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
        const DessertList(),
      ],
    );
  }
}
