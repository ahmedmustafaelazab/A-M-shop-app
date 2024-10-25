import 'package:flutter_test/flutter_test.dart';
import 'package:shop_app/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/layout/layout_cubit/layout_states.dart';

void main() {
  group('LayoutCubit', () {
    late LayoutCubit layoutCubit;

    setUp(() {
      layoutCubit = LayoutCubit();
    });

    test('initial state is LayoutInitialState', () {
      expect(layoutCubit.state, isA<LayoutInitialState>());
    });

    test('changeBottomNavIndex changes state', () {
      layoutCubit.changeBottomNavIndex(currentIndex: 1);
      expect(layoutCubit.bottomNavIndex, 1);
      expect(layoutCubit.state, isA<ChangeBottomNavigationIndexState>());
    });

  });
}
