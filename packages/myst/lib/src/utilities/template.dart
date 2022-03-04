const String mystYamlTemplate = """configs:
  rewrite: false
  model:
    rewrite: false
    included: [".*."]
  interface:
    rewrite: true
    included: [".*."]
  controller:
    rewrite: false
    included: [".*."]
  extension:
    rewrite: false
    included: [".*."]
  layout:
    rewrite: false
    included: [".*._core.dart"]
    template: "mvc"
  screen:
    rewrite: false
    included: [".*._core.dart"]
    template: "mvc"
  service:
    rewrite: false
    included: [".*."]
  utility:
    rewrite: false
    included: [".*."]
    excluded: [".*.(src)"]
  widget:
    rewrite: false
    included: [".*."]""";

/// `mainTemplate`
///
/// this will be used to create or override main.dart content
const String mainTemplate = """
import 'package:projectName/core.dart';

void main() async {
  // flutter binding
  WidgetsFlutterBinding.ensureInitialized();

  /// easy localization
  await EasyLocalization.ensureInitialized();

  /// shared preference
  await ApplicationService.ensureInitialized();

  final authenticationController = AuthenticationController();

  runApp(EasyLocalization(
      path: translationsPath,
      supportedLocales: supportedLocales,
      fallbackLocale: fallbackLocale,
      startLocale: startLocale,
      saveLocale: true,
      child: MyApp(authenticationController: authenticationController)));
}
""";

/// `appTemplate`

/// this will be use in order to create app.dart for export and import
const String appTemplate = """
import 'core.dart';

class MyApp extends StatelessWidget {
  
  final AuthenticationController authenticationController;

  const MyApp({
    Key? key,
    required this.authenticationController,
  }) : super(key: key);

  static const String title = "MyApp";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationController>(
          create: (_) => authenticationController,
        ),
        Provider<MyRouter>(
          lazy: false,
          create: (_) => MyRouter(authenticationController),
        ),
      ],
      child: Builder(builder: (context) {
        final router = Provider.of<MyRouter>(context, listen: false).router;
        
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: MyApp.title,
          theme: ThemeData(primarySwatch: Colors.blue),
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
        );
      }),
    );
  }
}
""";

/// `routerTemplate`

/// this will be use in order to create router.dart for export and import
const String routerTemplate = """
class MyRouter {
  
  late AuthenticationController authenticationController;

  MyRouter(this.authenticationController);

  late final router = GoRouter(
    refreshListenable: authenticationController,
    debugLogDiagnostics: true,
    urlPathStrategy: UrlPathStrategy.path,
    initialLocation: rootRoutePath,
    routes: [
      // TODO: HomeScreen.router,
      GoRoute(
        name: rootRouteName,
        path: rootRoutePath,
        pageBuilder: (_, state) => NoTransitionPage(
            key: state.pageKey,
            child: const HomeScreen(key: HomeScreen.pageKey)),
        routes: [
          /// nested routes
        ],

        /// redirect: redirect,
      ),

      // TODO: LoginScreen.router,
      GoRoute(
        name: loginRouteName,
        path: loginRoutePath,
        pageBuilder: (_, state) => NoTransitionPage(
            key: state.pageKey,
            child: const LoginScreen(key: LoginScreen.pageKey)),
        routes: [
          /// nested routes
        ],

        /// redirect: redirect,
      ),

      // TODO: ResetScreen.router,
      GoRoute(
        name: resetRouteName,
        path: resetRoutePath,
        pageBuilder: (_, state) => NoTransitionPage(
            key: state.pageKey,
            child: const ResetScreen(key: ResetScreen.pageKey)),
        routes: [
          /// nested routes
        ],

        /// redirect: redirect,
      ),

      // TODO: RegisterScreen.router,
      GoRoute(
        name: registerRouteName,
        path: registerRoutePath,
        pageBuilder: (_, state) => NoTransitionPage(
            key: state.pageKey,
            child: const RegisterScreen(key: RegisterScreen.pageKey)),
        routes: [
          /// nested routes
        ],

        /// redirect: redirect,
      ),

      // TODO: DashboardScreen.router,
      GoRoute(
        name: adminRouteName,
        path: adminRoutePath,
        pageBuilder: (_, state) => NoTransitionPage(
            key: state.pageKey,
            child: const Center(child: CircularProgressIndicator())),
        routes: [
          GoRoute(
            name: dashboardRouteName,
            path: dashboardRoutePath,
            pageBuilder: (_, state) => const NoTransitionPage(
                child: DashboardScreen(key: DashboardScreen.pageKey)),
            routes: [
              /// nested routes
            ],

            /// redirect: redirect,
          ),

          GoRoute(
            name: profileRouteName,
            path: profileRoutePath,
            pageBuilder: (_, state) => const NoTransitionPage(
                child: ProfileScreen(key: ProfileScreen.pageKey)),
            routes: [
              /// nested routes
            ],

            /// redirect: redirect,
          ),

        ],
        redirect: (state) {
          final dashboardLocation = state.namedLocation(dashboardRouteName);
          return dashboardLocation;
        },
      ),
    ],

    /// handle error
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),

    // TODO: handle redirect or middlewar
    redirect: (state) {
      /// if user is in login screen
      final loginLocation = state.namedLocation(loginRouteName);
      final loggingIn = state.subloc == loginLocation;

      /// if user is in register screen
      final registerAccountLocation = state.namedLocation(registerRouteName);
      final registeringAccount = state.subloc == registerAccountLocation;

      final isLoggedIn = authenticationController.isLoggedIn;
      final rootLocation = state.namedLocation(rootRouteName);

      /// if not logged-in nor in loggin page nor in register page then go to login
      if (!isLoggedIn && !loggingIn && !registeringAccount) {
        return loginLocation;
      }

      /// if login and but sticted in login or register page, then go to api dashboard
      if (isLoggedIn && (loggingIn || registeringAccount)) {
        return rootLocation;
      }

      return null;
    },
  );
}
""";

/// `authenticationConfigTemplate`
///
/// Authentication configuration or constants\n
const String authenticationConfigTemplate =
    """/// Authentication configuration or constants\n
/// `userNameKey`
///
/// ### Used to store the user name in cache eg: shared pref or hive
const String userNameKey = "name";

/// `userEmailKey`
///
/// ### Used to store the user email in cache eg: shared pref or hive
const String userEmailKey = "email";

/// `userTokenKey`
///
/// ### Used to store the user token in cache eg: shared pref or hive
const String userTokenKey = "token";

/// `userTokenTypeKey`
///
/// ### Used to store the user token in cache eg: shared pref or hive
const String userTokenTypeKey = "token_type";

""";

/// ### [applicationConfigTemplate]
///
/// Application configuration including themes or constants
const String applicationConfigTemplate =
    """/// Application configuration including themes or constants\n
import 'package:flutter/material.dart';
/// `lightTheme`
/// 
/// use this to customize your normal theme
final ThemeData lightTheme = ThemeData();

/// `darkTheme`
/// 
/// use this to customize your dark mode theme
final ThemeData darkTheme = ThemeData.dark();

/// `localeKey`
/// 
/// use this key into shared preference to save or get lang cache
const String localeKey = "lang";

/// `themeKey`
/// 
/// use this key into shared preference to save or get theme cache
const String themeKey = "theme";

/// `placeholder`
/// 
/// place holder represent the local asset image as place holder
const String placeholder = "assets/images/loading.png";

/// `fallbackLocale`
///
const fallbackLocale = Locale('en', 'US');

/// `startLocale`
///
///
const startLocale = Locale('en', 'US');

/// `supportedLocales`
///
///
const supportedLocales = [fallbackLocale, Locale('km', 'KH')];

/// `translationsPath`
///
///
const translationsPath = "assets/translations";

/// `restorationScopeId`
///
///
const restorationScopeId = "app";

/// `appTitle`
/// 
/// 
const appTitle = "projectName";

""";

/// ### `layoutConfigTemplate`
///
/// Layout screen configuration or constants
const String layoutConfigTemplate =
    """/// Layout screen configuration or constants\n
/// reference of the left drawer width
const double kDrawerLeftWidth = 300.0;

/// reference of the right drawer width
const double kDrawerRightWidth = 300.0;

/// reference of the mini drawer in the left side
const double kMiniLeftDrawerWidth = 65.0;

/// reference of the mini drawer in the left side
const double kMiniRightDrawerWidth = 65.0;
""";

/// `routerConfigTemplate`
///
/// Any router configuration or constants
const String routerConfigTemplate =
    """/// Any router configuration or constants\n
/// route config name and path

const String rootRouteName = "root";
const String rootRoutePath = "/";
const String loginRouteName = "login";
const String loginRoutePath = "/login";
const String registerRouteName = "register";
const String registerRoutePath = "/register";
const String resetRouteName = "reset";
const String resetRoutePath = "/reset";
const String adminRouteName = "admin";
const String adminRoutePath = "/admin";
const String dashboardRouteName = "dashboard";
const String dashboardRoutePath = "dashboard";
const String profileRouteName = "profile";
const String profileRoutePath = "profile";
""";

/// `configTemplate`
///
/// Export the configuration
const String configTemplate =
    """/// Export the configuration\n\n///library configs;\n

export 'application_config.dart';
export 'layout_config.dart';
export 'authentication_config.dart';
export 'router_config.dart';""";

/// ###`testTemplate`
///
/// default test template which can be load into file in test directory
const String testTemplate = """import 'package:test/test.dart';

void main() {
  setUp(() {

  });

}
""";

/// ### `integationTestTemplate`
///
/// default test template which can be load into file in integration_test directory
const String integationTestTemplate =
    """import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("failing test example", (WidgetTester tester) async {
    expect(2 + 2, equals(5));
  });
}
""";

/// ### `modelTemplate`
///
/// will be used when create a new model
/// and its test file
const String modelTemplate = """
/// ### `className`
/// 
/// `Description`:
/// 
/// `Example`:
// TODO: Implement model
class className{
  
}
""";

const String modelTestTemplate = """import 'package:test/test.dart';

void main() {
  group("className", () {
    late Map<String, dynamic> json;
    late className objectName;
    late Map<String, dynamic> data;

    setUp(() {
      // TODO: initialize json data for testing
      json = {};
      /// objectName = className.fromJson(json);
      /// data = objectName.toJson();
    });

    test(": fromJson(json)", () {
      expect(true, true);
    });

    test(": toJson()", () {
      expect(true, true);
    });

    test(": ==", () {
      expect(true, true);
    });
  });
}""";

/// ### `serviceTemplate`
///
/// will be used when create a new service
/// and its test file
const String serviceTemplate = """
/// ### `className`
/// 
/// `Description`:
/// 
/// `Example`:
// TODO: Implement service
class className{
  
}
""";

const String serviceTestTemplate = """import 'package:test/test.dart';

void main() {
  group("className", () {
    late className objectName;

    setUp(() {
      // TODO: initialize objectName to test the behavior
      objectName = className();
    });

    test(": ==", () {
      expect(true, true);
    });
  });
}""";

/// ### `utilityTemplate`
///
/// will be used when create a new utility
/// and its test file
const String utilityTemplate = """
/// ### `className`
/// 
/// `Description`:
/// 
/// `Example`:
// TODO: Implement service
class className{
  
}
""";

const String utilityTestTemplate = """import 'package:test/test.dart';

void main() {
  group("className", () {
    late className objectName;

    setUp(() {
      // TODO: initialize objectName to test the behavior
      objectName = className();
    });

    test(": ==", () {
      expect(true, true);
    });
  });
}""";

/// ### `interfaceTemplate`
///
/// will be used when create a new interface(mostly abstraction)
/// and its test file
const String interfaceTemplate = """
/// ### `className`
/// 
/// `Description`:
/// 
/// `Example`:
// TODO: Implement abstract class as interface
abstract class className{
  
}
""";

const String interfaceTestTemplate = """import 'package:test/test.dart';

/// TODO: implement and test its implementation 
/// class classNameImp implements className{

/// }

void main() {
  group("className", () {
    /// late classNameImp objectName;

    setUp(() {
      // TODO: initialize impl and assert every method
      /// objectName = classNameImp();
    });
    
    test(": ==", () {
      expect(true, true);
    });
  });
}""";

/// ### `controllerTemplate`
///
/// will be used when create a new controller
/// and its test file
const String controllerTemplate =
    """import 'package:projectName/core.dart';\nimport 'package:flutter/foundation.dart';\n
/// ### `className`
/// 
/// `Description`:
/// 
/// `Example`:
// TODO: Implement controller
class className extends ChangeNotifier with DiagnosticableTreeMixin implements ReassembleHandler{
  
  /// check if current controller is dispose
  bool isDisposed = false;

  bool get mounted => !isDisposed;

  className(){
    
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    /// list all the properties of your class here.
    /// See the documentation of debugFillProperties for more information.
    /// TODO: implement add
    properties.add(StringProperty('className', null));
  }

  @override
  void reassemble() {
    print('Did hot-reload className');
  }

  @override
  void notifyListeners() {
    if (!isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    /// TODO: dispose
    isDisposed = true;
    super.dispose();
  }
}
""";

const String controllerTestTemplate = """import 'package:test/test.dart';
/// gestures handler
import 'package:flutter/gestures.dart';


void main() {
  group("test controller className", () {
    TestWidgetsFlutterBinding.ensureInitialized();
    
    late Widget app;
    setUp(() {
      app = MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => className(),
          /// TODO: implement the child for test controller
          child: const Text("sample"),
        ),
      );
    });

    tearDown(() {
      ///
    });

    testWidgets("start a screen to pump widget and test", (tester) async {
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      /// TODO: implement find
      /// final titleFinder = find.text("sample");
      /// final incrementFinder = find.byKey(CounterScreen.incrementkey);
      /// await tester.pumpAndSettle();
      
      /// TODO: guester
      /// await tester.tap(incrementFinder);
      /// await tester.pumpAndSettle();
      
      /// TODO: expected
      /// expect(titleFinder, findsWidgets);
      /// expect(incrementFinder, findsOneWidget);

    });
  });
}
""";

/// ### `extensionTemplate`
///
/// will be used when create a new extension
/// and its test file
const String extensionTemplate = """
/// ### `className`
/// 
/// `Description`:
/// 
/// `Example`:
// TODO: Implement extension on object
extension className on String {
  
}
""";

const String extensionTestTemplate = """import 'package:test/test.dart';

void main() {
  group("className", () {
    late String objectName;

    setUp(() {
      // TODO: initialize an object and try extension method
      objectName = "String()";
    });
    
    test(": ==", () {
      expect(true, true);
    });
  });
}""";

/// ### `layoutStatelessTemplate`
///
/// will be used when create a new layout
/// and its test file
const String layoutStatelessTemplate =
    """import 'package:projectName/core.dart';\n

/// ### `className`
/// 
/// `Description`:
/// 
/// `Example`:
// TODO: Implement the className
class className extends StatelessWidget {
  final Widget? child;
  const className({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptivePlatformWidget(child: child ?? Container());
  }
}
""";

const String layoutStatelessNoChildTemplate =
    """import 'package:projectName/core.dart';\n

/// ### `className`
/// 
/// `Description`:
/// 
/// `Example`:
// TODO: Implement the className
class className extends StatelessWidget {
  const className({Key? key}) : super(key: key);

  static const Key widgetKey = ValueKey("className");

  @override
  Widget build(BuildContext context) {
    return AdaptivePlatformWidget(child: Container());
  }
}
""";

/// ### `layoutStatelessNotifierTemplate`
///
/// will be used when create a new layout
/// and its test file
const String layoutStatelessNotifierTemplate =
    """import 'package:projectName/core.dart';\nimport 'package:flutter/foundation.dart';\n
/// ### `className`
///
/// `Description`:
///
/// `Example`:
// TODO: Implement the className
class className extends StatelessWidget {
  final Widget? child;
  const className({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => classNameState(),
      child: AdaptivePlatformWidget(child: child ?? Container()),
    );
  }
}

class classNameState extends ChangeNotifier with DiagnosticableTreeMixin
    implements ReassembleHandler {

  bool isDisposed = false;

  bool get mounted => !isDisposed;

  classNameState(){
    
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    /// list all the properties of your class here.
    /// See the documentation of debugFillProperties for more information.
    /// TODO: implement add
    properties.add(StringProperty('className', null));
  }

  @override
  void reassemble() {
    /// TODO: reassemble
    print('Did hot-reload className');
  }

  @override
  void notifyListeners() {
    if (!isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    /// TODO: dispose
    isDisposed = true;
    super.dispose();
  }

}
""";

const String layoutStatelessNotifierNoChildTemplate =
    """import 'package:projectName/core.dart';\nimport 'package:flutter/foundation.dart';\n
/// ### `className`
///
/// `Description`:
///
/// `Example`:
// TODO: Implement the className
class className extends StatelessWidget {
  const className({Key? key}) : super(key: key);

  static const Key widgetKey = ValueKey("className");

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => classNameState(),
      child: AdaptivePlatformWidget(child: Container()),
    );
  }
}

class classNameState extends ChangeNotifier with DiagnosticableTreeMixin
    implements ReassembleHandler {
      bool isDisposed = false;

  bool get mounted => !isDisposed;

  classNameState(){
    
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    /// list all the properties of your class here.
    /// See the documentation of debugFillProperties for more information.
    /// TODO: implement add
    properties.add(StringProperty('className', null));
  }

  @override
  void reassemble() {
    /// TODO: reassemble
    print('Did hot-reload className');
  }

  @override
  void notifyListeners() {
    if (!isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    /// TODO: dispose
    isDisposed = true;
    super.dispose();
  }
}
""";

/// ### `layoutStatefullTemplate`
///
/// will be used when create a new layout
/// and its test file
const String layoutStatefulTemplate =
    """import 'package:projectName/core.dart';\n
/// ### `className`
/// 
/// `Description`:
/// 
/// `Example`:
// TODO: Implement the className
class className extends StatefulWidget {
  final Widget? child;
  const className({Key? key, this.child}) : super(key: key);

  @override
  State<className> createState() => _classNameState();
}

class _classNameState extends State<className> with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {
    return AdaptivePlatformWidget(child: widget.child ?? Container() );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
""";

const String layoutStatefulNoChildTemplate =
    """import 'package:projectName/core.dart';\n
/// ### `className`
/// 
/// `Description`:
/// 
/// `Example`:
// TODO: Implement the className
class className extends StatefulWidget {
  const className({Key? key}) : super(key: key);

  static const Key widgetKey = ValueKey("className");

  @override
  State<className> createState() => _classNameState();
}

class _classNameState extends State<className> with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {
    return AdaptivePlatformWidget(child: Container() );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
""";

const String screenStatefulNoChildTemplate =
    """import 'package:projectName/core.dart';\n
/// ### `className`
/// 
/// `Description`:
/// 
/// `Example`:
// TODO: Implement the className
class className extends StatefulWidget {
  const className({Key? key}) : super(key: key);

  static const Key widgetKey = ValueKey("className");

  @override
  State<className> createState() => _classNameState();
}

class _classNameState extends State<className> with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {
    return AdaptivePlatformWidget(child: Scaffold(body: Center(child:Text("ReportScreen"))));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
""";

const String screenStatelessNotifierNoChildTemplate =
    """import 'package:projectName/core.dart';\nimport 'package:flutter/foundation.dart';\n
/// ### `className`
///
/// `Description`:
///
/// `Example`:
// TODO: Implement the className
class className extends StatelessWidget {
  const className({Key? key}) : super(key: key);

  static const Key widgetKey = ValueKey("className");

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => classNameState(),
      child: AdaptivePlatformWidget(child: Scaffold(body: Center(child:Text("ReportScreen")))),
    );
  }
}

class classNameState extends ChangeNotifier with DiagnosticableTreeMixin
    implements ReassembleHandler {

  bool isDisposed = false;

  bool get mounted => !isDisposed;

  classNameState(){
    
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    /// list all the properties of your class here.
    /// See the documentation of debugFillProperties for more information.
    /// TODO: implement add
    properties.add(StringProperty('className', null));
  }

  @override
  void reassemble() {
    /// TODO: reassemble
    print('Did hot-reload className');
  }

  @override
  void notifyListeners() {
    if (!isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    /// TODO: dispose
    isDisposed = true;
    super.dispose();
  }

}
""";

const String layoutTestTemplate = """import 'package:test/test.dart';
/// gestures handler
import 'package:flutter/gestures.dart';


void main() {
  group("test controller className", () {
    TestWidgetsFlutterBinding.ensureInitialized();
    
    late Widget app;
    setUp(() {
      app = MaterialApp(
        home: className(
          child: const Text("sample"),
        ),
      );
    });

    tearDown(() {
      ///
    });

    testWidgets("start a screen to pump widget and test", (tester) async {
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      /// TODO: implement find
      /// final titleFinder = find.text("sample");
      /// final incrementFinder = find.byKey(CounterScreen.incrementkey);
      /// await tester.pumpAndSettle();
      
      /// TODO: guester
      /// await tester.tap(incrementFinder);
      /// await tester.pumpAndSettle();
      
      /// TODO: expected
      /// expect(titleFinder, findsWidgets);
      /// expect(incrementFinder, findsOneWidget);

    });
  });
}
""";

const String screenTestTemplate = """import 'package:test/test.dart';
/// gestures handler
import 'package:flutter/gestures.dart';


void main() {
  group("test controller className", () {
    TestWidgetsFlutterBinding.ensureInitialized();
    
    late Widget app;
    setUp(() {
      app = MaterialApp(
        home: className(),
      );
    });

    tearDown(() {
      ///
    });

    testWidgets("start a screen to pump widget and test", (tester) async {
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      /// TODO: implement find
      /// final titleFinder = find.text("sample");
      /// final incrementFinder = find.byKey(CounterScreen.incrementkey);
      /// await tester.pumpAndSettle();
      
      /// TODO: guester
      /// await tester.tap(incrementFinder);
      /// await tester.pumpAndSettle();
      
      /// TODO: expected
      /// expect(titleFinder, findsWidgets);
      /// expect(incrementFinder, findsOneWidget);

    });
  });
}
""";

/// `screenControllerLayout`
///
const String screenControllerTemplate =
    """import 'package:projectName/core.dart';\nimport 'package:flutter/foundation.dart';\n
/// ### `classNameController`
/// 
/// `Description`:
/// 
/// `Example`:
// TODO: Implement controller
class classNameController extends ChangeNotifier with DiagnosticableTreeMixin implements ReassembleHandler{
  
  bool isDisposed = false;

  bool get mounted => !isDisposed;

  classNameController(){
    
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    /// list all the properties of your class here.
    /// See the documentation of debugFillProperties for more information.
    /// TODO: implement add
    properties.add(StringProperty('classNameController', null));
  }

  @override
  void reassemble() {
     /// TODO: reassemble
    print('Did hot-reload classNameController');
  }

  @override
  void notifyListeners() {
    if (!isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    /// TODO: dispose
    isDisposed = true;
    super.dispose();
  }
}""";

/// `layoutTemplate`
///
const String layoutTemplate = """import 'package:projectName/core.dart';
/// ### `className`
///
/// `Description`:
///
/// `Example`:
// TODO: Implement the className
class className extends StatelessWidget {
  final Widget? child;
  const className({Key? key, this.child}) : super(key: key);

  static const Key pageKey = ValueKey("className");

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => classNameController(),
      child: AdaptivePlatformWidget(child: child ?? Scaffold(body: Center(child:Text("className")))),
    );
  }
}""";

/// `screenTemplate`
///
const String screenTemplate = """import 'package:projectName/core.dart';
/// ### `className`
///
/// `Description`:
///
/// `Example`:
// TODO: Implement the className
class className extends StatelessWidget {
  const className({Key? key}) : super(key: key);

  static const Key pageKey = ValueKey("className");

  static const String title = "className";

  @override
  Widget build(BuildContext context) {

    /// set the current browser title
    ApplicationService.setTitle(context, title);

    return ChangeNotifierProvider(
      create: (_) => classNameController(),
      child: AdaptivePlatformWidget(child: Scaffold(body: Center(child:Text("className")))),
    );
  }
}""";

const String screenNoChildTemplate = """import 'package:projectName/core.dart';
/// ### `className`
///
/// `Description`:
///
/// `Example`:
// TODO: Implement the className
class className extends StatelessWidget {
  const className({Key? key}) : super(key: key);

  static const Key pageKey = ValueKey("className");

  static const String title = "className";

  @override
  Widget build(BuildContext context) {
    /// set the current browser title
    ApplicationService.setTitle(context, title);

    return AdaptivePlatformWidget(child: Scaffold(body: Center(child:Text("className"))));
  }
}""";

const String screenNotifierNoChildTemplate =
    """import 'package:projectName/core.dart';
/// ### `className`
///
/// `Description`:
///
/// `Example`:
// TODO: Implement the className
class className extends StatelessWidget {
  const className({Key? key}) : super(key: key);

  static const Key pageKey = ValueKey("className");

  static const String title = "className";

  @override
  Widget build(BuildContext context) {
    
    /// set the current browser title
    ApplicationService.setTitle(context, title);

    return ChangeNotifierProvider(
      create: (_) => classNameController(),
      child: AdaptivePlatformWidget(child: Scaffold(body: Center(child:Text("className")))),
    );
  }
}""";

/// `screenServiceTemplate`
///
///
const String screenServiceTemplate = """
/// ### `classNameService`
///
/// `Description`:
///
/// `Example`:
// TODO: Implement the className
class classNameService {

}
""";

/// `screenCoreTemplate`
///
///
const String screenCoreTemplate = """
export 'fileName_service.dart';
export 'fileName_controller.dart';
export 'fileName.dart';
""";

/// application_controller template
///
///
const String applicationControllerTemplate = """
import 'package:flutter/foundation.dart';
import 'package:projectName/core.dart';

/// ### `ApplicationController`
///
/// `Description`: this application controller will take controll of theme, language, global configuration and other app sharedable state
///
/// `Example`:
class ApplicationController extends ChangeNotifier
    with DiagnosticableTreeMixin
    implements ReassembleHandler {
  
  /// check if current controller is dispose
  bool isDisposed = false;

  bool get mounted => !isDisposed;

  late ApplicationService service;

  /// current application locale
  late Locale locale;

  /// current application theme mode
  late ThemeMode themeMode;

  /// application title
  late String generatedTitle;

  ApplicationController([ApplicationService? applicationService]) {
    service = applicationService ?? ApplicationService();
    themeMode = service.currentTheme;
    locale = service.currentLocale;
    generatedTitle = appTitle;
  }

  /// `changeThemeMode`
  ///
  /// change the thememode in controller then update shared key to remember the choice
  changeThemeMode(String value) {
    themeMode = value.toThemeMode;
    notifyListeners();

    /// then update in shared key
    service.saveTheme(value);
  }

  /// `changeLanguage`
  ///
  /// change the language in controller then update shared key to remember the choice
  changeLocale(Locale value) {
    locale = value;

    notifyListeners();

    /// then update in shared key
    service.saveLanguage(value.toStringWithSeparator(separator: "_"));
  }

  /// `changeTitle`
  ///
  /// might not work or use application service instead of, to change browser title
  changeTitle(String value) {
    generatedTitle = value;

    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    /// list all the properties of your class here.
    /// See the documentation of debugFillProperties for more information.
    /// TODO: implement add
    properties.add(StringProperty('ApplicationController', null));
  }

  @override
  void reassemble() {
    print('Did hot-reload ApplicationController');
  }

  @override
  void notifyListeners() {
    if (!isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    /// TODO: dispose
    isDisposed = true;
    super.dispose();
  }
}
""";

/// application_service template
///
///
const String applicationServiceTemplate = """
import 'package:flutter/services.dart';
import 'package:projectName/core.dart';

/// ### `ApplicationService`
///
/// `Description`: this class will be use with other application controller to handle global service for application
///
/// `Example`:
class ApplicationService {
  /// shared preference must be initialized before use
  static SharedPreferences? preferences;

  ///
  static ensureInitialized() async {
    // ensure preference
    preferences ??= await SharedPreferences.getInstance();
  }

  /// `setTitle`
  ///
  /// allow every page or screen to change current display title
  static setTitle(BuildContext context, String title) {
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: title,
      primaryColor: Theme.of(context).primaryColor.value,
    ));
  }

  /// save then current theme into the preference key
  Future<bool> saveTheme(String value) async {
    return await preferences!.setString(themeKey, value);
  }

  /// save the current lang into the preference key
  Future<bool> saveLanguage(String value) async {
    return await preferences!.setString(localeKey, value);
  }

  ThemeMode get currentTheme => preferences!.getString(themeKey).toThemeMode;

  Locale get currentLocale => preferences!.getString(localeKey).toLocale;
}

/// private extension for application service class on string
extension ApplicationServiceStringExt on String? {
  ThemeMode get toThemeMode {
    switch (this) {
      case "light":
        return ThemeMode.light;
      case "dark":
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Locale get toLocale {
    if (this != null) {
      return Locale(this!.split("_").first, this!.split("_").last);
    }
    return fallbackLocale;
  }
}
""";

/// `authenticationControllerTemplate`
///
///
const String authenticationControllerTemplate = """
import 'package:flutter/foundation.dart';
import 'package:projectName/core.dart';

/// ### `AuthenticationController`
///
/// `Description`: this controller will handle the login/logout/register/profile state for the entire app
///
/// `Example`:
class AuthenticationController extends ChangeNotifier
    with DiagnosticableTreeMixin
    implements ReassembleHandler {
  
  /// check if current controller is dispose
  bool isDisposed = false;

  bool get mounted => !isDisposed;

  late String? _name;
  String? get name => _name;

  late String? _token;
  String? get token => _token;

  late bool _isLoggedIn;
  bool get isLoggedIn => _isLoggedIn;

  late AuthenticationService _authenticationService;

  AuthenticationController([AuthenticationService? authenticationService]) {
    _authenticationService = authenticationService ?? AuthenticationService();

    _name = _authenticationService.getName;
    _token = _authenticationService.getToken;
    _isLoggedIn = _authenticationService.getName.isNotEmpty &&
        _authenticationService.getToken.isNotEmpty;
  }

  /// `login`
  ///
  /// if user logged in correctly then update the current state,
  /// else do something to notify
  login({required String name, required String token}) async {
    /// assum if always true
    var isLoggedIn =
        await _authenticationService.login(name: name, token: token);
    if (isLoggedIn) {
      _name = name;
      _token = token;
      _isLoggedIn = true;
      notifyListeners();
    } else {
      /// TODO: do something
    }
  }

  /// `register`
  ///
  /// if user registered in correctly then update the current state,
  /// else do something to notify
  register({required String name, required String token}) async {
    /// assum if always true
    var isLoggedIn =
        await _authenticationService.register(name: name, token: token);
    if (isLoggedIn) {
      _name = name;
      _token = token;
      _isLoggedIn = true;
      notifyListeners();
    } else {
      /// TODO: do something
    }
  }

  /// `logout`
  ///
  /// if user loggout correctly then update the current state,
  /// else do something to notify
  logout() async {
    var isLoggedOut = await _authenticationService.logout();
    if (isLoggedOut) {
      _name = "";
      _token = "";
      _isLoggedIn = false;
      notifyListeners();
    } else {
      /// TODO: do something
    }
  }

  /// `profile`
  ///
  /// load the current profile for cache or server
  /// else do something
  profile() async {
    var result = await _authenticationService.profile();
    if (result != null) {
      _name = result['name'];
      _token = result['token'];
      printGreen("loadProfile name \$_name and token \$_token");
      notifyListeners();
    } else {
      /// TODO: do something
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    /// list all the properties of your class here.
    /// See the documentation of debugFillProperties for more information.
    /// TODO: implement add
    properties.add(StringProperty('name', _name));
    properties.add(StringProperty('token', _token));
  }

  @override
  void reassemble() {
    print('Did hot-reload AuthenticationController');
  }

  @override
  void notifyListeners() {
    if (!isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    /// TODO: dispose
    isDisposed = true;
    super.dispose();
  }
}

""";

/// `authenticationServiceTemplate`
///
///
const String authenticationServiceTemplate = """
import 'package:projectName/core.dart';

/// ### `AuthenticationService`
///
/// `Description`: this service class handle any authenticate method either with server api or cache
///
/// `Example`:
class AuthenticationService {
  AuthenticationService();

  Future<bool> login({required String name, required String token}) async {
    final prefs = ApplicationService.preferences!;
    await Future.delayed(const Duration(milliseconds: 300));
    await prefs.setString(userNameKey, name);
    await prefs.setString(userTokenKey, token);
    return true;
  }

  Future<bool> register({required String name, required String token}) async {
    final prefs = ApplicationService.preferences!;
    await Future.delayed(const Duration(milliseconds: 300));
    await prefs.setString(userNameKey, name);
    await prefs.setString(userTokenKey, token);
    return true;
  }

  Future<bool> logout() async {
    final prefs = ApplicationService.preferences!;
    await Future.delayed(const Duration(milliseconds: 300));
    await prefs.remove(userNameKey);
    await prefs.remove(userTokenKey);
    return true;
  }

  Future<Map<String, dynamic>?> profile() async {
    final prefs = ApplicationService.preferences!;
    await Future.delayed(const Duration(milliseconds: 300));

    var name = prefs.getString(userNameKey);
    var token = prefs.getString(userTokenKey);
    return {"name": name, "token": token};
  }

  String get getToken {
    final prefs = ApplicationService.preferences!;
    return prefs.getString(userTokenKey) ?? "";
  }

  String get getName {
    final prefs = ApplicationService.preferences!;
    return prefs.getString(userNameKey) ?? "";
  }
}
""";
