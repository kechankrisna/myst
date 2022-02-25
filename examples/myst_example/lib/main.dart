import 'package:myst_example/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ApplicationService.ensureSharedPreferences();

  final authenticationController = AuthenticationController();

  ///

  runApp(MyApp(authenticationController: authenticationController));
}

class MyApp extends StatelessWidget {
  final AuthenticationController authenticationController;
  const MyApp({Key? key, required this.authenticationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationController>.value(
          value: authenticationController,
        ),
        Provider<MyRouter>(
          lazy: false,
          create: (BuildContext createContext) =>
              MyRouter(authenticationController),
        ),
      ],
      child: Builder(builder: (context) {
        final router = Provider.of<MyRouter>(context, listen: false).router;
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title:
              'myst example ${context.read<AuthenticationController>().isLoggedIn}',
          theme: ThemeData(primarySwatch: Colors.blue),
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
        );
      }),
    );
  }
}
