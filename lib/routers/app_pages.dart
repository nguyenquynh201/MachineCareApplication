import 'package:machine_care/routers/app_routes.dart';

import '../ui/ui.dart';

class AppPages extends Routes {
  static final pages = [
    GetPage(name: Routes.navigation, page: () => NavigationScreen(), bindings: [
      NavigationBinding(),
    ]),
  ];
}
