import 'package:myst_example/core.dart';

/// ### `SwitchLanguageButton`
///
/// `Description`:
///
/// `Example`:
// TODO: Implement the SwitchLanguageButton
class SwitchLanguageButton extends StatelessWidget {
  const SwitchLanguageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptivePlatformWidget(
      child: DropdownButton<Locale>(
        value: context.locale,
        items: supportedLocales
            .map((e) => DropdownMenuItem(
                  child: Text(e.languageCode),
                  value: e,
                ))
            .toList(),
        onChanged: (val) {
          context.setLocale(val!);
          context.read<ApplicationController>().changeLanguage(val);
        },
      ),
    );
  }
}
