import 'package:myst_example/core.dart';

/// ### `SwitchThemeButton`
///
/// `Description`:
///
/// `Example`:
// TODO: Implement the SwitchThemeButton
class SwitchThemeButton extends StatelessWidget {
  const SwitchThemeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeMode =
        context.select<ApplicationController, ThemeMode>((e) => e.themeMode);
    return AdaptivePlatformWidget(
        child: Switch(
            value: themeMode == ThemeMode.light,
            onChanged: (v) {
              var value = v ? "light" : "dartk";
              context.read<ApplicationController>().changeThemeMode(value);
            }));
  }
}
