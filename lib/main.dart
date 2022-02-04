import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:hydrated_bloc_set_example/cubit/number_collector_cubit.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(const MyApp()),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => NumberCollectorCubit(),
        child: BlocBuilder<NumberCollectorCubit, NumberCollectorState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Flutter Demo Home Page'),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'You have pushed the button this many times:',
                    ),
                    Text(
                      state.numbers.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => context.read<NumberCollectorCubit>().addRandomNumber(),
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
            );
          },
        ),
      ),
    );
  }
}
