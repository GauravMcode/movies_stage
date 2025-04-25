import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:movies_stage/config/widget_keys.dart';

import 'package:movies_stage/main.dart' as app;
import 'package:movies_stage/presentation/movie_details/view/movie_details.dart';
import 'package:movies_stage/presentation/movies_list/view/movie_card.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App Test', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    //grid of movies visible after showing loader
    debugPrint("<--[TEST]grid of movies visible after showing loader-->");

    final Finder gridView = find.byType(GridView);
    await tester.pumpAndSettle();
    expect(gridView, findsOne);

    print('[TEST] grid of movies test complete ✅');

    //scroll down and up the movies grid
    debugPrint("<--scroll down and up the movies grid-->");
    await tester.pumpAndSettle();
    final Finder grid = find.byType(GridView);
    await tester.pumpAndSettle();
  expect(grid, findsOneWidget);

  print('[TEST] Scrolling down...');
  await tester.fling(grid, const Offset(0, -300), 1000); // scroll down
  await tester.pumpAndSettle();

      print('[TEST] Scrolling up...');
  await tester.fling(grid, const Offset(0, 300), 1000); // scroll up
  await tester.pumpAndSettle();

      print('[TEST] Scroll test complete ✅');

    //tap the card to view details, add to Fav and back on list view
    debugPrint(
        "<---tap the card to view details, add to Fav and back on list view-->");
    await tester.pumpAndSettle();
    final Finder firstCard2 = find.byKey(AppWidgetKeys.firstCardKey);

    await tester.tap(firstCard2);
    await tester.pumpAndSettle();

    final Finder detailsView = find.byType(MovieDetails);

    expect(detailsView, findsOneWidget);

    final Finder favIcon = find.byKey(AppWidgetKeys.favIconKey);
    final Finder selectedFavIcon = find.byIcon(Icons.favorite);
    await tester.tap(favIcon);
    await tester.pumpAndSettle();

    expect(selectedFavIcon, findsOneWidget);

    final Finder backIcon = find.byIcon(Icons.arrow_back_ios);

    await tester.tap(backIcon);

    
    await tester.pumpAndSettle();

      print('[TEST] Movie details and Fav test complete ✅');


    //tap on switch to toggle and view fav movies
    debugPrint("<--tap on switch to toggle and view fav movies-->");
    await tester.pumpAndSettle();
    final Finder toggler = find.byType(Switch);

    await tester.tap(toggler);

    await tester.pumpAndSettle();

    final Finder firstCard3 = find.byKey(AppWidgetKeys.firstCardKey);

    expect(firstCard3, findsOneWidget);
    await tester.pumpAndSettle();

    final Finder gridView2 = find.byType(GridView);
    expect(gridView2, findsOne);
    await tester.tap(toggler);
    await tester.pumpAndSettle();

      print('[TEST] toggle and view Fav test complete ✅');


    //tap on search icon and search movies and back
    debugPrint("<--tap on search icon and search movies and back-->");
    await tester.pumpAndSettle();
    final Finder fab = find.byType(FloatingActionButton);

    await tester.tap(fab);

    await tester.pumpAndSettle();

    final Finder searchField = find.byType(TextField);

    await tester.enterText(searchField, 'sam');

    await tester.pumpAndSettle();

    final Finder firstFavIcon =
        find.byIcon(Icons.favorite_border_outlined).first;
    
    await tester.pumpAndSettle();
    await tester.tap(firstFavIcon);
    await tester.pumpAndSettle();

    final Finder backIcon2 = find.byIcon(Icons.arrow_back);

    await tester.tap(backIcon2);
    await tester.pumpAndSettle();

    final Finder gridView3 = find.byType(GridView);
    expect(gridView3, findsOne);
    await tester.pumpAndSettle();
      print('[TEST] type and search test complete ✅');

  });

  // testWidgets('scroll down and up the movies grid',
  //     (WidgetTester tester) async {
  //   //setup

  // });
  // testWidgets('tap the card to view details, add to Fav and back on list view ',
  //     (WidgetTester tester) async {
  //   //setup

  // });

  // testWidgets('tap on switch to toggle and view fav movies',
  //     (WidgetTester tester) async {

  // });

  // testWidgets('tap on search icon and search movies and back',
  //     (WidgetTester tester) async {

  // });
}
