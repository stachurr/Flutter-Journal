import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/list_screen.dart';
import 'screens/new_post_screen.dart';
import 'screens/details_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  static final routes = {
    ListScreen.routeName: (context) => ListScreen(),
    NewPost.routeName: (context) => NewPost(),
    DetailsScreen.routeName: (context) => DetailsScreen()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      routes: routes
    );
  }
}