import 'package:flutter_test/flutter_test.dart';
import 'package:shop_app/layout/layout_screen.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/modules/Screens/splash_screen/splash_screen.dart';

class CacheNetwork {
  static String? _token;

  static String? get token => _token;

  static set token(String? value) => _token = value;
}

void mockCacheNetwork({String? token}) {
  CacheNetwork.token = token;
}

void main() {
  testWidgets('MyApp shows SplashScreen when Token is null', (WidgetTester tester) async {
    // Mock CacheNetwork to return null for Token
    mockCacheNetwork();

    await tester.pumpWidget(MyApp());

    expect(find.byType(SplashScreen), findsOneWidget);
  });

  testWidgets('MyApp shows LayoutScreen when Token is present', (WidgetTester tester) async {
    // Mock CacheNetwork to return Token
    mockCacheNetwork(token: 'some_token');

    await tester.pumpWidget(const MyApp());

    expect(find.byType(LayoutScreen), findsOneWidget);
  });
}