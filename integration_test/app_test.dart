import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ditonton/main.dart' as app;
import 'package:movie/presentation/pages/home_movie_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('integration test', () {
    testWidgets('Show Movie Home Page on app start', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      expect(find.byType(HomeMoviePage), findsOneWidget);
    });
  });
}
