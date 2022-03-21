import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app_fteam/app/modules/search/home_page_module.dart';
import 'package:uno/uno.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => Uno()),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(Modular.initialRoute, module: HomePageModule()),
      ];
}
