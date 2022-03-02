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
  screen:
    rewrite: false
    included: [".*._core.dart"]
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
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// await ApplicationService.ensureSharedPreferences();

  var authenticationController = AuthenticationController();

  runApp(MyApp(authenticationController: authenticationController));
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
      /// final loginLocation = state.namedLocation(loginRouteName);
      /// final loggingIn = state.subloc == loginLocation;

      /// /// if user is in register screen
      /// final registerAccountLocation = state.namedLocation(registerRouteName);
      /// final registeringAccount = state.subloc == registerAccountLocation;

      /// final isLoggedIn = authenticationController.isLoggedIn;
      /// final rootLocation = state.namedLocation(rootRouteName);

      /// /// if not logged-in nor in loggin page nor in register page then go to login
      /// if (!isLoggedIn && !loggingIn && !registeringAccount) {
      ///   return loginLocation;
      /// }

      /// /// if login and but sticted in login or register page, then go to api dashboard
      /// if (isLoggedIn && (loggingIn || registeringAccount)) {
      ///   return rootLocation;
      /// }

      return null;
    },
  );
}
""";

/// `authenticationConfigTemplate`
///
/// Authentication configuration or constants\n
const String authenticationConfigTemplate =
    """/// Authentication configuration or constants\n""";

/// ### `applicationConfigTemplate`
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

/// `languageKey`
/// 
/// use this key into shared preference to save or get lang cache
const String languageKey = "lang";

/// `themeKey`
/// 
/// use this key into shared preference to save or get theme cache
const String themeKey = "theme";

/// `placeholder`
/// 
/// place holder represent the local asset image as place holder
const String placeholder = "assets/images/loading.png";
""";

/// ### `layoutConfigTemplate`
///
/// Layout screen configuration or constants
const String layoutConfigTemplate =
    """/// Layout screen configuration or constants\n
/// `kDrawerWidth`
/// 
/// will be used to set the drawer width for your layout
const kDrawerWidth = 300.0;
""";

/// `routerConfigTemplate`
///
/// Any router configuration or constants
const String routerConfigTemplate =
    """/// Any router configuration or constants\n
/// route config name and path
/// 
const String rootRouteName = "root";
const String rootRoutePath = "/";
const String loginRouteName = "login";
const String loginRoutePath = "/login";
const String registerRouteName = "register";
const String registerRoutePath = "/register";
const String adminRouteName = "admin";
const String adminRoutePath = "/admin";
const String dashboardRouteName = "dashboard";
const String dashboardRoutePath = "dashboard";""";

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
const String controllerTemplate = """
/// ### `className`
/// 
/// `Description`:
/// 
/// `Example`:
// TODO: Implement controller
class className extends ChangeNotifier with DiagnosticableTreeMixin implements ReassembleHandler{
  
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
  void dispose() {
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
const String layoutStatelessTemplate = """
/// ### `className`
/// 
/// `Description`:
/// 
/// `Example`:
// TODO: Implement the className
class className extends StatelessWidget {
  final Widget child;
  const className({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptivePlatformWidget(child: child);
  }
}
""";

/// ### `layoutStatelessNotifierTemplate`
///
/// will be used when create a new layout
/// and its test file
const String layoutStatelessNotifierTemplate = """
/// ### `className`
///
/// `Description`:
///
/// `Example`:
// TODO: Implement the className
class className extends StatelessWidget {
  final Widget child;
  const className({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => classNameState(),
      child: AdaptivePlatformWidget(child: child),
    );
  }
}

class classNameState extends ChangeNotifier {}
""";

/// ### `layoutStatefullTemplate`
///
/// will be used when create a new layout
/// and its test file
const String layoutStatefulTemplate = """
/// ### `className`
/// 
/// `Description`:
/// 
/// `Example`:
// TODO: Implement the className
class className extends StatefulWidget {
  final Widget child;
  const className({Key? key, required this.child}) : super(key: key);

  @override
  State<className> createState() => _classNameState();
}

class _classNameState extends State<className> with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {
    return AdaptivePlatformWidget(child: widget.child);
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

/// `screenControllerLayout`
///
const String screenControllerTemplate = """
/// ### `className`
/// 
/// `Description`:
/// 
/// `Example`:
// TODO: Implement controller
class classNameController extends ChangeNotifier with DiagnosticableTreeMixin implements ReassembleHandler{
  
  classNameController(){
    
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
  void dispose() {
    /// TODO: dispose
    super.dispose();
  }
}""";

/// `screenLayout`
///
const String screenTemplate = """
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

/// `screenServiceTemplate`
///
///
const String screenServiceTemplate = """
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
