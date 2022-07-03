import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_youtube_api_test/providers/general_provider.dart';

class MainVM {
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  int get pageIdx => _ref.watch(bottomNavPageProvider);
  set pageIdx(int idx) =>
      _ref.watch(bottomNavPageProvider.notifier).update((state) => idx);
}
