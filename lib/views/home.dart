// this will be the home screen (gets imported into MyApp)
import 'package:flutter/material.dart';
// import custom recipe card widget to use it for the body of this home page
import 'package:recipe_app/views/widgets/recipe_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          // center text and icon
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu),
            // add space between icon and text by adding sized box widget
            SizedBox(width: 10),
            Text("Tasty Recipes"),
          ],
        ),
      ),
      body: RecipeCard(
          // placeholder info for now
          title: "Random Recipe",
          calories: "500 calories",
          cookTime: "20 minutes",
          // vegan smores image placeholder for now
          thumbnailUrl:
              "https://edamam-product-images.s3.amazonaws.com/web-img/2fe/2fec4f772f454e5aead7221d6fc4224e.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEGsaCXVzLWVhc3QtMSJHMEUCIQDftbT0IqhnevorJWg808OYvLPr%2BuLohRZBoVqaCCH6ngIgS06NOf6DbelVgTKWhQIFvK%2FZcPA6KwUhTFWdeDHOspsquQUIVBAAGgwxODcwMTcxNTA5ODYiDN3mp3hKrwgVxyuxDSqWBVg0VxH7PMGddKLSB%2FQs1vISDPnXf%2BNp1K%2Fma0ZXLU7vuqorRnXmw82JUXSk3%2FFvqKejYhFEnHpyi1n%2BHOnXvawvsKNflMNu%2Bz4n756N%2FYbbnsUpUsSq5Ac8EAbaA53PTxaELkJD6kbGSNSxjWapblhzCqgNEv%2BYBqovGFlKz56iSysWYHq22x9PUmj2jr%2BwOG9lUj7kkpWSSHnMbG52dU5QlAajbcmX%2BIYQLMXtvN6XhjlrD3QhCtStwpR4Dt1gu%2BBgNL49qiWH16b0isdxey%2BuqWZsKB8x20wtaz1inm0iWOAX4WfIWW%2BKo6V1S4Bu7I0bXuSI%2FXRHHjAZsbHO9N7gFcgThbDttyf8lOKu3uWxnkf7HoA%2F2hMVrj4mdx5qZDZuh5yS9HtP%2BSnJ61UC5RV1k3xVHtNw2wfpWJUlitb177WU923SLDLbrD9dHTBLIaDEHs7%2F%2FQk%2FJC%2BZwVgRQvijmLWx1DET6jGa8FqvhvDvIJ9md%2FCr65sAIkXf%2BphFPyQwY1L%2Fby3K4KfmRez4DK07%2Bp7A2deGzQg09KDvjSEWXuTih1Rr5Qv4l%2FDn1PMxrZU3Qd%2FxZud28F%2FoWn%2B4zXyhmaYSi%2FEedpcBDmv0sEToFwMPCb9uW6GbYl7k8xUSSNF9%2FZcNe0hLHEAEeTAb9Ski%2FbLcCDkCe5GKIJKQ2GvWDwyJFVs9TpbaP%2FWepCTyNhOFNrWyyZMspm1jpdd6IiZjVlrR7NJdCoNi73lrn3snDnu4hsgPBadsyuPrM%2B%2F8lbu5g53%2F7K0xtGiMiFlLLct2i6by5okCIwmJk3wYagYTvKQBXtdrWF1x9Goy4VQtRoSJtANpmUi1jjp50eGoz1BTiPILQXKfmWf09tHrljYve4PEelEvMOajw6EGOrEBnv45BCfC91vv5HI%2FcgAWsC4ajWYOoE5BVgGXRJvqjX40WAlwLnmx38xNtwQ6UxgDokRTi8mbFN4zoRyigoPVZN9HxTBA05qx%2FAyoD1WViGB%2FMliKr8VSAiq5FtinGxuI611hm1s1AVJj4WBjERHkoYqpL5KH9hzdnRoRVxysMi9gf99SfhZNUCX5QI%2FEyntEFO0tYnTD%2BRkH0NdO8A4FqOUugC9i3otAiSeK%2B4Bd%2BXjs&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230408T040257Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFEQVCEZOY%2F20230408%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=62d567ebcce619c27b21c6da138b1c6d47296206a70772007a4e06237bd06fe2"),
    );
  }
}
