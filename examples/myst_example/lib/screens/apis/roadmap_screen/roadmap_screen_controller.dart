import 'package:myst_example/core.dart';

class RoadMapScreenController extends ChangeNotifier {
  /// `pageController`
  late PageController pageController;

  late ScrollBehavior scrollBehavior;

  /// `service`
  late RoadMapScreenService service;

  /// `currentPage`
  late int currentPage;

  late int totalPage;

  RoadMapScreenController({int? initialPage, int? initTotalPage}) {
    service = RoadMapScreenService();
    currentPage = initialPage ?? 0;
    totalPage = initTotalPage ?? RoadMapScreenService.lessons.length;
    pageController = PageController(initialPage: currentPage, keepPage: true);
    scrollBehavior = (ScrollBehavior()
        .copyWith(scrollbars: false, physics: NeverScrollableScrollPhysics()));
  }

  goToPage(
    int page, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInToLinear,
  }) {
    currentPage = page;
    pageController.animateToPage(currentPage, duration: duration, curve: curve);
    notifyListeners();
  }

  goNextPage() {
    currentPage += 1;
    goToPage(currentPage);
  }

  goLastPage() {
    currentPage = currentPage > 0 ? currentPage - 1 : 0;
    goToPage(currentPage);
  }

  /// `canGoLast`
  bool get canGoLast => currentPage > 0;

  /// `canGoNext`
  bool get canGoNext => currentPage < (totalPage - 1);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
