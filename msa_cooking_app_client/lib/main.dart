import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:msa_cooking_app_client/features/test/screens/ingredient_list_screen.dart';

void main() {
  runApp(
    const ProviderScope(
        child: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
    int currentStateIndex = 0;

    void onItemTapped(int index) {
      setState(() {
        currentStateIndex = index;
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        title: const Text('Dummy text here'),
      ),
      body: Center(
        child: IndexedStack(
          index: currentStateIndex,
          children: const [
            Placeholder(), // To be home screen
            IngredientsListScreen(), // Fridge
            Placeholder(), //  Meals
            Placeholder() // Profile
          ],
        ),
      ),
      bottomNavigationBar:  BottomNavigationBar(
        currentIndex: currentStateIndex,
        onTap: onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_rounded),
            label: 'Fridge'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Meals'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile'
          )
        ],
      ),
    );
  }
}

