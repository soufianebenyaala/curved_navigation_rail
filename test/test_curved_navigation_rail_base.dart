import 'package:curved_navigation_rail/curved_navigation_rail.dart';
import 'package:flutter/material.dart';

class CurvedNavigationRailBaseTest extends StatefulWidget {
  const CurvedNavigationRailBaseTest({super.key});

  @override
  State<CurvedNavigationRailBaseTest> createState() =>
      _CurvedNavigationRailBaseTestState();
}

class _CurvedNavigationRailBaseTestState
    extends State<CurvedNavigationRailBaseTest> {
  int selectedIndex = 0;
  List<IconData> icons = [
    Icons.home,
    Icons.folder,
    Icons.monitor,
  ];
  List<Widget> screens = [
    const PageOne(),
    const PageTwo(),
    const PageThree(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        CurvedNavigationRail(
          minWidth: 120,
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          destinations: icons
              .map(
                (e) => NavigationCurvedRailDestination(
                  icon: Icon(e),
                  label: Text('page ${icons.indexWhere(
                    (element) => element == e,
                  )}'),
                ),
              )
              .toList(),
        ),
        Expanded(
          child: screens[selectedIndex],
        ),
      ],
    ));
  }
}

List<NavigationCurvedRailDestination> _destinations() {
  return const <NavigationCurvedRailDestination>[
    NavigationCurvedRailDestination(
      icon: Icon(Icons.favorite_border),
      selectedIcon: Icon(Icons.favorite),
      label: Text('Abc'),
    ),
    NavigationCurvedRailDestination(
      icon: Icon(Icons.bookmark_border),
      selectedIcon: Icon(Icons.bookmark),
      label: Text('Def'),
    ),
    NavigationCurvedRailDestination(
      icon: Icon(Icons.star_border),
      selectedIcon: Icon(Icons.star),
      label: Text('Ghi'),
    ),
    NavigationCurvedRailDestination(
      icon: Icon(Icons.hotel),
      selectedIcon: Icon(Icons.home),
      label: Text('Jkl'),
    ),
  ];
}

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Page One'),
      ),
    );
  }
}

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Page Two'),
      ),
    );
  }
}

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Page Three'),
      ),
    );
  }
}

class PageSecondLevel extends StatelessWidget {
  const PageSecondLevel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Page Second Level'),
      ),
    );
  }
}
