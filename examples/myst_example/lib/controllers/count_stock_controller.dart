import 'package:flutter/foundation.dart';
import 'package:myst_example/core.dart';

/// ### `CountStockController`
///
/// `Description`:
///
/// `Example`:
// TODO: Implement controller
class CountStockController extends ChangeNotifier
    with DiagnosticableTreeMixin
    implements ReassembleHandler {
  CountStockController() {}

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    /// list all the properties of your class here.
    /// See the documentation of debugFillProperties for more information.
    /// TODO: implement add
    properties.add(StringProperty('CountStockController', null));
  }

  @override
  void reassemble() {
    print('Did hot-reload CountStockController');
  }

  @override
  void dispose() {
    super.dispose();
  }
}
