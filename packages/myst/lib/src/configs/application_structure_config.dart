import 'package:myst/myst.dart';

class ApplicationStructorConfig {
  /// router.dart handler
  static FileCreator get router =>
      FileCreator("router.dart", contents: routerTemplate);

  /// main.dart handler
  static FileCreator get main =>
      FileCreator("main.dart", contents: mainTemplate);

  /// app.dart handler
  static FileCreator get app => FileCreator("app.dart", contents: appTemplate);

  /// application core
  static FileCreator get core =>
      FileCreator("core.dart", contents: """/// Application core file \n
export 'router.dart';
export 'app.dart';
export 'configs/configs.dart';
export 'controllers/controllers.dart';
export 'extensions/extensions.dart';
export 'interfaces/interfaces.dart';
export 'layouts/layouts.dart';
export 'models/models.dart';
export 'providers/providers.dart';
export 'screens/screens.dart';
export 'services/services.dart';
export 'utilities/utilities.dart';
export 'widgets/widgets.dart';\n""");

  /// configs directory
  static DirectoryCreator get configs => DirectoryCreator(
        "configs",
        inners: [
          FileCreator(
            "application_config.dart",
            contents: applicationConfigTemplate,
          ),
          FileCreator(
            "layout_config.dart",
            contents: layoutConfigTemplate,
          ),
          FileCreator(
            "authentication_config.dart",
            contents: authenticationConfigTemplate,
          ),
          FileCreator(
            "router_config.dart",
            contents: routerConfigTemplate,
          ),
          FileCreator(
            "configs.dart",
            contents: configTemplate,
          ),
        ],
      );

  /// controllers directory
  static DirectoryCreator get controllers => DirectoryCreator(
        "controllers",
        inners: [
          FileCreator("controllers.dart",
              contents:
                  "/// Data featching controller\n\n/// library controllers;\n")
        ],
      );

  /// extensions directory
  static DirectoryCreator get extensions => DirectoryCreator(
        "extensions",
        inners: [
          FileCreator("extensions.dart",
              contents:
                  "/// Extra more extesion on dart code\n\n/// library extensions;\n")
        ],
      );

  /// interfaces directory
  static DirectoryCreator get interfaces => DirectoryCreator(
        "interfaces",
        inners: [
          FileCreator("interfaces.dart",
              contents:
                  "/// For base class or abstraction\n\n/// library interfaces;\n")
        ],
      );

  /// layouts directory
  static DirectoryCreator get layouts => DirectoryCreator(
        "layouts",
        inners: [
          FileCreator("layouts.dart",
              contents:
                  "/// Application overlay or layouts\n\n/// library layouts;\n")
        ],
      );

  /// models directory
  static DirectoryCreator get models => DirectoryCreator(
        "models",
        inners: [
          FileCreator("models.dart",
              contents: "/// Application data models\n\n/// library models;\n")
        ],
      );

  /// providers directory
  static DirectoryCreator get providers => DirectoryCreator(
        "providers",
        inners: [
          FileCreator("providers.dart",
              contents:
                  "/// Application state management\n\n/// library providers;\n")
        ],
      );

  /// screens directory
  static DirectoryCreator get screens => DirectoryCreator(
        "screens",
        inners: [
          FileCreator("screens.dart",
              contents:
                  "/// Application screens or pages\n\n/// library screens;\n")
        ],
      );

  /// services directory
  static DirectoryCreator get services => DirectoryCreator(
        "services",
        inners: [
          FileCreator("services.dart",
              contents:
                  "/// Application services for handle background or as helper\n\n/// library services;\n")
        ],
      );

  /// utilities directory
  static DirectoryCreator get utilities => DirectoryCreator(
        "utilities",
        inners: [
          FileCreator("utilities.dart",
              contents:
                  "/// Application utilities which mix the function\n\n/// library utilities;\n")
        ],
      );

  /// widgets directory
  static DirectoryCreator get widgets => DirectoryCreator(
        "widgets",
        inners: [
          FileCreator("widgets.dart",
              contents:
                  "/// Application utilities which mix the function\n\n/// library widgets;\n")
        ],
      );

  /// flutter skeleton
  static List<DirectoryCreator> get skeleton {
    return [
      configs,
      controllers,
      extensions,
      interfaces,
      layouts,
      models,
      providers,
      screens,
      services,
      utilities,
    ];
  }

  /// main directory refer to the directory where file shoud be stay in
  static List<String> get keyDirectories =>
      [...skeleton.map((e) => e.path).toList(), widgets.path, providers.path];

  static List<String> get keyPaths =>
      [...keyDirectories.map((e) => "$e/$e.dart").toList()];
}
