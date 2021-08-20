import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      observers: <ProviderObserver>[ProvidersObserver()],
      child: MyApp(),
    ),
  );
}

final StateProvider<int> counterProvider =
    StateProvider<int>((StateProviderRef ref) {
  return 0;
}, name: 'counter');

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Riverpod 1.0.0-dev.7 Issue'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${ref.watch(counterProvider).state}',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                debugPrint('Set to ZERO');
                ref.read(counterProvider).state = 0;
              },
              child: Text('Reset to ZERO'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(counterProvider).state++;
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

/// ProvidersObserver used in this demo to debugPrint changes.
class ProvidersObserver extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase<dynamic> provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    if (newValue is StateController && previousValue is StateController) {
      debugPrint('Provider is StateController: '
          '${provider.name ?? provider.runtimeType} \n'
          'new value: ${newValue.state}\n'
          'previous value: ${previousValue.state}');
    }
  }
}
