import 'package:Basme/model_view_controller/data/service/lang/ar.dart';
import 'package:Basme/model_view_controller/data/service/lang/fr.dart';
import 'package:get/get.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': ar,
        'fr': fr,
      };
}
