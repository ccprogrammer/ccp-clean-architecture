import 'package:ccp_clean_architecture/core/extensions/context_ext.dart';
import 'package:ccp_clean_architecture/src/explore/views/explore_screen.dart';
import 'package:ccp_clean_architecture/src/favorites/views/favorites_screen.dart';
import 'package:ccp_clean_architecture/src/home/views/home_screen.dart';
import 'package:ccp_clean_architecture/src/profile/views/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainMenuScreen extends StatefulWidget {
  final Widget child;
  final String location;
  const MainMenuScreen(
      {super.key, required this.child, required this.location});
  @override
  State<StatefulWidget> createState() {
    return _MainMenuScreenState();
  }
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  int activeIndex = 0;

  List<String> locations = [
    HomeScreen.route,
    ExploreScreen.route,
    FavoritesScreen.route,
    ProfileScreen.route,
  ];

  int _getSelectedIndex() {
    switch (widget.location) {
      case HomeScreen.route:
        return 0;
      case ExploreScreen.route:
        return 1;
      case FavoritesScreen.route:
        return 2;
      case ProfileScreen.route:
        return 3;
      default:
        return 0;
    }
  }

  void _navigator(
    int index,
  ) {
    if (activeIndex != index) {
      context.go(locations[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: widget.child),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _getSelectedIndex(),
        indicatorColor: context.theme.primaryColor.withOpacity(0.2),
        onDestinationSelected: (int index) {
          _navigator(index);
          activeIndex = index;
        },
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_max_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_rounded),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
