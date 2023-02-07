import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Stream<int?> numbersStream;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numbersStream = getNumbers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<int?>(
        stream: numbersStream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text('Stream is null');
            case ConnectionState.waiting:
              return const Text('wait');
            case ConnectionState.active:
              if(snapshot.hasData) {
                int number = snapshot.data!;
                return Text('$number');
              } else {
                return const Text('No data!');
              }
            case ConnectionState.done:
              if(snapshot.hasData) {
                int number = snapshot.data!;
                return Text('$number');
              } else {
                return const Text('No data!');
              }
            default:
              return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: (){
          setState(() {
            numbersStream = getNumbers();
          });
        },
      ),
    );
  }

  Stream<int?> getNumbers() async* {
    await Future.delayed(const Duration(seconds: 4));
    yield 1;
    await Future.delayed(const Duration(seconds: 1));
    yield 2;
    await Future.delayed(const Duration(seconds: 1));
    yield 3;
  }
}


