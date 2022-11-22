import 'package:beamer/beamer.dart';
import 'package:krtouristic/utils/injection/injection.dart' as get_it;
import 'package:krtouristic/views/common/tabs_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await get_it.configureDependencies();
  runApp(EtsApp());
}

class EtsApp extends StatelessWidget {
  EtsApp({Key? key}) : super(key: key);

  final routerDelegate = BeamerDelegate(
    initialPath: '/',
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '*': (context, state, data) => const TabsPage(),
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
      backButtonDispatcher: BeamerBackButtonDispatcher(
        delegate: routerDelegate,
      ),
      theme: ThemeData(
        listTileTheme: const ListTileThemeData(
            // iconColor: Colors.black,
            ),
        appBarTheme: const AppBarTheme(
          // This will be applied to the "back" icon
          iconTheme: IconThemeData(
            color: Color.fromRGBO(255, 213, 0, 1.0),
          ),
          // This will be applied to the action icon buttons that locates on the right side
          actionsIconTheme: IconThemeData(
            color: Color.fromRGBO(255, 213, 0, 1.0),
          ),
          centerTitle: false,
        ),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromRGBO(1, 25, 51, 1.0),
          onPrimary: Colors.white,
          secondary: Color.fromRGBO(255, 255, 255, 1.0),
          onSecondary: Color.fromRGBO(39, 203, 0, 1.0),
          background: Color.fromRGBO(255, 255, 255, 1.0),
          onBackground: Color.fromRGBO(255, 0, 0, 1.0),
          surface: Color.fromRGBO(255, 255, 255, 1.0),
          onSurface: Color.fromRGBO(255, 0, 0, 1.0),
          error: Colors.grey,
          onError: Colors.black,
        ),
        textTheme: GoogleFonts.kuraleTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}
