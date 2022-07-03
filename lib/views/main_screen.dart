import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_youtube_api_test/view_models/main_view_model.dart';
import 'package:flutter_youtube_api_test/views/cart_screen.dart';
import 'package:flutter_youtube_api_test/views/home_screen.dart';
import 'package:flutter_youtube_api_test/views/search_screen.dart';
import 'package:flutter_youtube_api_test/views/settings_screen.dart';
import 'package:flutter_youtube_api_test/views/shopping_screen.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  final MainVM _vm = MainVM();
  final _pages = [
    HomeScreen(),
    SearchScreen(),
    ShoppingScreen(),
    CartScreen(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();

    _vm.setRef(ref);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (idx) {
          _vm.pageIdx = idx;
        },
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.white,
        currentIndex: _vm.pageIdx,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 30),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag, size: 30),
            label: 'Shopping',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, size: 30),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 30),
            label: 'Settings',
          ),
        ],
      ),
      body: _pages[_vm.pageIdx],
    );
  }
}
