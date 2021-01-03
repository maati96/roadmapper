import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:roadmap/composition_root.dart';
import 'package:roadmap/utilities/theme.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await pathProvider.getApplicationDocumentsDirectory();

  Hive.init(appDocumentDirectory.path);

  final settings = await Hive.openBox('settings');
  bool isLightTheme = settings.get('isLightTheme') ?? false;

  CompositionRoot.configure();
  runApp(ChangeNotifierProvider(
    create: (_) => ThemeProvider(isLightTheme: isLightTheme),
    child: AppStart(),
  ));
}
class AppStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MyApp(
      themeProvider: themeProvider,
    );
  }
}
class MyApp extends StatefulWidget {
    final ThemeProvider themeProvider;

  const MyApp({Key key, @required this.themeProvider}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Roadmapper',
      debugShowCheckedModeBanner: false,
      theme: widget.themeProvider.themeData(),
      home: CompositionRoot.composeAuthUi(),
    );
  }
}
