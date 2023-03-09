import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_arch/modules/berries/pages/berries_list_page.dart';
import 'package:modular_arch/modules/berries/pages/berry_detail_page.dart';
import 'package:modular_arch/respositories/berry_repository.dart';

class BerriesModule extends Module {
  @override
  List<Module> get imports => const [];

  @override
  List<Bind> get binds => [
    Bind((i)=> BerryRepository(i())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (_, __) => const BerriesListPage(), transition: TransitionType.fadeIn),
    ChildRoute('/detail', child: (_, args) => BerryDetailPage(berry: args.data), transition: TransitionType.downToUp),
  ];
}