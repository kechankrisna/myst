import 'package:myst/myst.dart';

class ApplicationConfig {
  /// configs directory
  static DirectoryCreator get configs => DirectoryCreator(
        "configs",
        inners: [
          FileCreator("configs.dart", contents: "/// Application configuration \n\nlibrary configs;\n")
        ],
      );

  /// controllers directory
  static DirectoryCreator get controllers => DirectoryCreator(
        "controllers",
        inners: [
          FileCreator("controllers.dart",
              contents: "/// Data featching controller \n\nlibrary controllers;\n")
        ],
      );

  /// extensions directory
  static DirectoryCreator get extensions => DirectoryCreator(
        "extensions",
        inners: [
          FileCreator("extensions.dart",
              contents: "/// Extra more extesion on dart code \n\nlibrary extensions;\n")
        ],
      );

  /// interfaces directory
  static DirectoryCreator get interfaces => DirectoryCreator(
        "interfaces",
        inners: [
          FileCreator("interfaces.dart",
              contents: "/// For base class or abstraction \n\nlibrary interfaces;\n")
        ],
      );

  /// layouts directory
  static DirectoryCreator get layouts => DirectoryCreator(
        "layouts",
        inners: [
          FileCreator("layouts.dart",
              contents: "/// Application overlay or layouts \n\nlibrary layouts;\n")
        ],
      );

  /// models directory
  static DirectoryCreator get models => DirectoryCreator(
        "models",
        inners: [
          FileCreator("models.dart", contents: "/// Application data models \n\nlibrary models;\n")
        ],
      );

  /// screens directory
  static DirectoryCreator get screens => DirectoryCreator(
        "screens",
        inners: [
          FileCreator("screens.dart",
              contents: "/// Application screens or pages \n\nlibrary screens;\n")
        ],
      );

  /// services directory
  static DirectoryCreator get services => DirectoryCreator(
        "services",
        inners: [
          FileCreator("services.dart",
              contents:
                  "/// Application services for handle background or as helper \n\nlibrary services;\n")
        ],
      );

  /// utilities directory
  static DirectoryCreator get utilities => DirectoryCreator(
        "utilities",
        inners: [
          FileCreator("utilities.dart",
              contents: "/// Application utilities which mix the function \n\nlibrary utilities;\n")
        ],
      );

  /// widgets directory
  static DirectoryCreator get widgets => DirectoryCreator(
        "widgets",
        inners: [
          FileCreator("widgets.dart",
              contents: "/// Application utilities which mix the function \n\nlibrary widgets;\n")
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
      screens,
      services,
      utilities,
      widgets
    ];
  }
}
