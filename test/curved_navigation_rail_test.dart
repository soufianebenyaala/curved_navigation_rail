import 'package:curved_navigation_rail/curved_navigation_rail.dart';
import 'package:curved_navigation_rail/src/curved_rail_destination.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_curved_navigation_rail_base.dart';

void main() {
  testWidgets('Custom selected and unselected textStyles are honored',
      (WidgetTester tester) async {
    const TextStyle selectedTextStyle =
        TextStyle(fontWeight: FontWeight.w300, fontSize: 17.0);
    const TextStyle unselectedTextStyle =
        TextStyle(fontWeight: FontWeight.w800, fontSize: 11.0);
    await _pumpDedaultTextWidget(
      tester,
      CurvedNavigationRail(
        minWidth: 120,
        selectedIndex: 0,
        destinations: _destinations(),
        selectedLabelTextStyle: selectedTextStyle,
        unselectedLabelTextStyle: unselectedTextStyle,
      ),
    );
    final TextStyle actualSelectedTextStyle =
        tester.renderObject<RenderParagraph>(find.text('Abc')).text.style!;
    final TextStyle actualUnselectedTextStyle =
        tester.renderObject<RenderParagraph>(find.text('Def')).text.style!;
    expect(
        actualSelectedTextStyle.fontSize, equals(selectedTextStyle.fontSize));
    expect(actualSelectedTextStyle.fontWeight,
        equals(selectedTextStyle.fontWeight));
    expect(actualUnselectedTextStyle.fontSize,
        equals(actualUnselectedTextStyle.fontSize));
    expect(actualUnselectedTextStyle.fontWeight,
        equals(actualUnselectedTextStyle.fontWeight));
  });
}

Future<void> _pumpDedaultTextWidget(
    WidgetTester tester, CurvedNavigationRail curvednavigationRail) async {
  return await tester.pumpWidget(
    MaterialApp(
      title: 'CurvedNavigationRail test app',
      home: Scaffold(
        body: Row(
          children: <Widget>[
            curvednavigationRail,
            const Expanded(
              child: Text('body'),
            ),
          ],
        ),
      ),
    ),
  );
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
