import 'package:coffee_maker/app/app.dart';
import 'package:coffee_maker/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App(), AppFlavor.development);
}
