import 'package:flutter/material.dart';
import 'package:expense_tracker/pages/Home_page.dart';
import 'package:expense_tracker/pages/add_page.dart';
import 'package:expense_tracker/pages/settings_page.dart';
import 'package:expense_tracker/pages/transaction_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  // Toggle dark mode
  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
              appBarTheme: const AppBarTheme(backgroundColor: Colors.blueGrey),
              scaffoldBackgroundColor: Colors.blueGrey[900],
            )
          : ThemeData.light().copyWith(
              appBarTheme: const AppBarTheme(backgroundColor: Colors.blueGrey),
              scaffoldBackgroundColor: Colors.blueGrey[50],
            ),
      home: MyHomePage(
        title: 'Expense Tracker',
        onThemeChanged: _toggleDarkMode, // Pass theme change callback
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final ValueChanged<bool> onThemeChanged; // Callback for theme change

  const MyHomePage(
      {super.key, required this.title, required this.onThemeChanged});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const AddPage(),
    const TransactionPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[300],
        title: Text(widget.title),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blueGrey[200],
          currentIndex: _currentIndex,
          selectedItemColor: Theme.of(context).colorScheme.onPrimaryContainer,
          unselectedItemColor: Theme.of(context).colorScheme.onPrimaryContainer,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          elevation: 8,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
            BottomNavigationBarItem(
                icon: Icon(Icons.stacked_bar_chart_rounded),
                label: 'Transaction'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
    );
  }
}
