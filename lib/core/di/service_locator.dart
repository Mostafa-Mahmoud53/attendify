import 'package:get_it/get_it.dart';
import '../theme/theme_provider.dart';

final GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  if (serviceLocator.isRegistered<StartupConfig>()) {
    return;
  }

  serviceLocator.registerSingleton<StartupConfig>(
    const StartupConfig(enableDebugLogging: true),
  );

  serviceLocator.registerLazySingleton<ThemeController>(
    () => ThemeController(),
  );
}

class StartupConfig {
  const StartupConfig({required this.enableDebugLogging});

  final bool enableDebugLogging;
}
