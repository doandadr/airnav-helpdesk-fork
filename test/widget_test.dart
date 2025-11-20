import 'package:airnav_helpdesk/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MainApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MainApp());

    // Verify that the MainApp widget is present in the tree.
    // This ensures the app initializes without throwing an error immediately.
    expect(find.byType(MainApp), findsOneWidget);
  });
}
