import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testprovider/dark_mode/theme_provider.dart';
import 'package:testprovider/l10n/l10n.dart';
import 'package:testprovider/name/text_provider.dart';
import 'package:testprovider/sample.dart';
import 'package:testprovider/utils.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => TextProvider())
      ],
      child: Consumer<ThemeProvider>(builder: (context, theme, _) {
        return MaterialApp(
          supportedLocales: l10n.all,
          locale: Provider.of<TextProvider>(context).locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Consumer<TextProvider>(builder: (context, tp, _) {
          return Text(tp.title);
        }),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.language,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              AppLocalizations.of(context)!.hello("Fakhry"),
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
            Text(
              AppLocalizations.of(context)!.stateprovider,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Flexible(
              child: Container(
                color: Theme.of(context).cardColor,
              ),
            ),
            Image.network(
              "https://preview.redd.it/02fhrcho5rl91.jpg?auto=webp&s=37008c0c5f6d240f78d9044c5873184891944e4b",
            ),
            TextFormField(),
            Flexible(
              child: Container(
                width: 100,
                color: Colors.yellow,
              ),
            ),
            Flexible(
              child: Container(
                width: 100,
                color: Colors.blue,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SampleScreen()),
                );
              },
              child: const Text("Next Screen"),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleDarkMode();
              },
              child: Text(
                // Change button text based on current theme status
                'Toggle ${themeProvider.status} Mode',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Toggle between English and Arabic locales
                Provider.of<TextProvider>(context, listen: false)
                    .toggleLocale();
              },
              child: Text(
                // Change button text based on current locale
                Provider.of<TextProvider>(context).locale.languageCode == 'en'
                    ? 'Switch to Arabic'
                    : 'Switch to English',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
