import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpods_coutup/data/count_data.dart';
import 'package:riverpods_coutup/provider.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
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
              ref.watch(countDataProvider).count.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Text("test"),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              FloatingActionButton(
                onPressed: () {
                  CountData countData = ref.read(countDataProvider.state).state;
                  ref.read(countDataProvider.state).state = countData.copyWith(
                    count: countData.count + 1,
                    countUp: countData.countUp + 1,
                  );
                },
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
              FloatingActionButton(
                onPressed: () {
                  CountData countData = ref.read(countDataProvider.state).state;
                  ref.read(countDataProvider.state).state = countData.copyWith(
                    count: countData.count - 1,
                    countDown: countData.countDown + 1,
                  );
                },
                tooltip: 'Increment',
                child: const Icon(CupertinoIcons.minus),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  ref
                      .watch(countDataProvider.select((value) => value.countUp))
                      .toString(),
                ),
                Row(
                  children: [
                    Text(
                      ref
                          .watch(countDataProvider
                              .select((value) => value.countDown))
                          .toString(),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(countDataProvider.state).state =
              CountData(count: 0, countUp: 0, countDown: 0);
        }, //watchからread に変更することで余計なボタンの読み込みをなくし、ボタン後の数だけを読み込んでいる
        tooltip: 'Increment',
        child: const Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
