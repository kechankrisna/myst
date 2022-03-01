import 'package:myst_example/core.dart';
import 'widgets/roadmap_screen_stepper.dart';

class RoadMapScreenService {
  final prefs = ApplicationService.preferences!;

  RoadMapScreenService();

  static List<RoadMapLessonModel> lessons = [
    RoadMapLessonModel(
      title: Text("Introduction"),
      content: IndividualSection(),
    ),
    RoadMapLessonModel(
      title: Text("Setup your flutter evironment"),
      content: IndividualSection(),
    ),
    RoadMapLessonModel(
      title: Text("Getting Started"),
      content: IndividualSection(),
    ),
    RoadMapLessonModel(
      title: Text("Build the app"),
      content: IndividualSection(),
    ),
    RoadMapLessonModel(
      title: Text("Unit Testing here"),
      content: IndividualSection(),
    ),
    RoadMapLessonModel(
      title: Text("Widget Testing "),
      content: IndividualSection(),
    ),
    RoadMapLessonModel(
      title: Text("Testing app UI and performance with intergration tests"),
      content: IndividualSection(),
    ),
    RoadMapLessonModel(
      title: Text("Congratulation"),
      content: IndividualSection(),
    )
  ];

  static String dummyText =
      """Next, you'll build out the app so that you can test it. The app contains the following files:

lib/main.dart - the main file where the app starts
lib/screens/home.dart - creates a list of items
lib/screens/favorites.dart - creates the layout for the favorites list
lib/models/favorites.dart - creates the model class for favorites list
Replace the contents of lib/main.dart
b2f84ff91b0e1396.pngReplace the contents of lib/main.dart with the following code:
Next, you'll build out the app so that you can test it. The app contains the following files
""";
}
