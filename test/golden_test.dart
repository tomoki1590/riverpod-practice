import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:riverpods_coutup/main.dart';
import 'package:riverpods_coutup/view_model.dart';

void main() {
  testGoldens('normal', (tester) async {
    const iphone11 =
        Device(name: 'iphone11', size: Size(414, 736), devicePixelRatio: 3.0);
    List<Device> devices1 = [iphone11];

    VieModel viewModel = VieModel();

    await tester.pumpWidgetBuilder(ProviderScope(
        child: MyHomePage(
      viewModel,
    )));
    await multiScreenGolden(tester, 'MyAppMyHomePage_0init', devices: devices1);
  });
}
