import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeNotifierController =
    StateNotifierProvider.autoDispose<HomeNotifierController, int>(
        (ref) => HomeNotifierController());

class HomeNotifierController extends StateNotifier<int> {
  HomeNotifierController() : super(0);
  void changeIndex(int index) {
    state = index;
  }
}