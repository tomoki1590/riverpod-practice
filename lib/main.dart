import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpods_coutup/provider.dart';
import 'package:riverpods_coutup/view_model.dart';

void main() {
  runApp(ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(VieModel()),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  VieModel vieModel;
  MyHomePage(this.vieModel, {Key? key}) : super(key: key);

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  late VieModel _vieModel;

  @override
  void initState() {
    super.initState();
    _vieModel = widget.vieModel;
    _vieModel.setRef(ref);
  }

  @override
  Widget build(BuildContext context) {
    //widgetRefを通してRiver pod内のproviderとアクセスできる

    return Scaffold(
      appBar: AppBar(
        title: Text(ref.watch(tittleProvider)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              ref.watch(text1Provider),
            ),
            Text(
              _vieModel.count,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text("test"),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              FloatingActionButton(
                onPressed: _vieModel.onIncrease,
                child: Icon(Icons.add),
              ),
              FloatingActionButton(
                onPressed: _vieModel.onDecrease,
                tooltip: 'Increment',
                child: const Icon(CupertinoIcons.minus),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(_vieModel.countUp),
                Row(
                  children: [Text(_vieModel.countDown)],
                )
              ],
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _vieModel.onReset();
          // ref.read(countDataProvider.state).state =
          //     CountData(count: 0, countUp: 0, countDown: 0);
        }, //watchからread に変更することで余計なボタンの読み込みをなくし、ボタン後の数だけを読み込んでいる
        tooltip: 'Increment',
        child: const Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
