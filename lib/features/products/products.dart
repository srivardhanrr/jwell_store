import 'package:core/core.dart';
import 'package:go_router/go_router.dart';

export 'data/data.dart';
export 'domain/domain.dart';
export 'presentation/presentation.dart';

class ProductsFeature extends Feature {
  @override
  List<RouteBase> get routes => [];
  @override
  Future<void> preregister() async {}
}
