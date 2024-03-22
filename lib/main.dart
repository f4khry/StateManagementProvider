import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testprovider/dark_mode/theme_provider.dart';
import 'package:testprovider/name/text_provider.dart';
import 'package:testprovider/sample.dart';
import 'package:testprovider/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => TextProvider())
      ],
      child: Consumer<ThemeProvider>(builder: (context, theme, _) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: theme.isDarkMode
              ? ThemeData.dark()
              : ThemeData(
                  cardColor: Colors.purple,
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Consumer<TextProvider>(builder: (context, tp, _) {
          return Text(tp.title);
        }),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Flexible(
                child:
                    Container(width: 100, color: Theme.of(context).cardColor)),
            Flexible(child: Container(width: 100, color: Colors.red)),
            Text("Text Test"),
            Image.network(
                "https://preview.redd.it/02fhrcho5rl91.jpg?auto=webp&s=37008c0c5f6d240f78d9044c5873184891944e4b"),
            TextFormField(),
            Flexible(child: Container(width: 100, color: Colors.blue)),
            ElevatedButton(
                onPressed: () {
                  go(context, SampleScreen());
                },
                child: const Text("Next Screen"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          theme.toggleDarkMode();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
