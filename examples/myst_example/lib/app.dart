import 'package:myst_example/core.dart';

class MyApp extends StatelessWidget {
  final AuthenticationController authenticationController;
  const MyApp({
    Key? key,
    required this.authenticationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ///
        ChangeNotifierProvider<ApplicationController>(
          create: (_) => ApplicationController(),
        ),

        ///
        ChangeNotifierProvider<AuthenticationController>(
          create: (_) => authenticationController,
        ),

        ///
        Provider<MyRouter>(
          lazy: false,
          create: (_) => MyRouter(authenticationController),
        ),
      ],
      child: Builder(builder: (context) {
        final router = Provider.of<MyRouter>(context, listen: false).router;
        final themeMode = context
            .select<ApplicationController, ThemeMode>((e) => e.themeMode);
        final generatedTitle = context
            .select<ApplicationController, String>((e) => e.generatedTitle);

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          restorationScopeId: restorationScopeId,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          onGenerateTitle: (_) => generatedTitle,
          theme: lightTheme,
          darkTheme: darkTheme,
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
          themeMode: themeMode,
        );
      }),
    );
  }
}
