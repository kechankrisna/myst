
import 'package:flutter/foundation.dart';
import 'package:myst_example/core.dart';
/// ### `PersonController`
/// 
/// `Description`:
/// 
/// `Example`:
// TODO: Implement controller
class PersonController extends ChangeNotifier with DiagnosticableTreeMixin implements ReassembleHandler{
  
  PersonController(){
    
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    /// list all the properties of your class here.
    /// See the documentation of debugFillProperties for more information.
    /// TODO: implement add
    properties.add(StringProperty('PersonController', null));
  }

  @override
  void reassemble() {
    print('Did hot-reload PersonController');
  }

  @override
  void dispose() {
    super.dispose();
  }
}
