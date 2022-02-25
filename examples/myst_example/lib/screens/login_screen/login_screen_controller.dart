import 'package:myst_example/core.dart';

class LoginScreenController extends ChangeNotifier {
  late TextEditingController nameController;
  late TextEditingController tokenController;

  late String? name;
  late String? token;

  LoginScreenController() {
    name = "";
    token = "";
    nameController = TextEditingController(text: name);
    tokenController = TextEditingController(text: token);
  }

  onReset() {
    name = "";
    token = "";
    nameController.value = TextEditingValue.empty;
    tokenController.value = TextEditingValue.empty;
    notifyListeners();
  }

  onChangeName(String? value) {
    name = value;
    notifyListeners();
  }

  onChangeToken(String? value) {
    token = value;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    tokenController.dispose();
    super.dispose();
  }
}
