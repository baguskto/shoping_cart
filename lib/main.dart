import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config.dart';
import 'initializer.dart';
import 'presentation/navigation/navigation.dart';
import 'presentation/navigation/routes.dart';

Future<void> main() async {
  await Initializer.init();
  final initialRoute = Routes.initialRoute;
  runApp(Main(initialRoute));
}

class Main extends StatelessWidget {
  final String initialRoute;

  const Main(this.initialRoute);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: EnvironmentsBadge(
        child: GetMaterialApp(
          initialRoute: initialRoute,
          getPages: Nav.routes,
        ),
      ),
    );
  }
}

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;

  const EnvironmentsBadge({required this.child});

  @override
  Widget build(BuildContext context) {
    final env = ConfigEnvironments.getEnvironments()['env'];
    return env != Environments.PRODUCTION
        ? Banner(
      location: BannerLocation.topStart,
      message: env!,
      color: env == Environments.QAS ? Colors.blue : Colors.purple,
      child: child,
    )
        : SizedBox(child: child);
  }
}
