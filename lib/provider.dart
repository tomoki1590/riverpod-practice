import 'package:flutter_riverpod/flutter_riverpod.dart';

final tittleProvider = Provider<String>((ref) {
  return 'Provider FistStep1';
});

final text1Provider =
    Provider<String>((ref) => 'You have pushed the button this many times:');
//=> これも{return }これも同じ結果になる
final countProvider = StateProvider<int>((ref) => 0);
