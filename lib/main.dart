import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/services/on_device_diagnostics.dart';

void main() => _launch();

@pragma('vm:entry-point')
void tvMain() => main();

void _launch() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();

      FlutterError.onError = (details) {
        FlutterError.presentError(details);
        Zone.current.handleUncaughtError(
          details.exception,
          details.stack ?? StackTrace.current,
        );
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        Zone.current.handleUncaughtError(error, stack);
        return true;
      };

      runApp(const YurichConnectApp(tvMode: true));
    },
    (error, stack) {
      unawaited(OnDeviceDiagnosticsService.recordError('uncaught'));
      debugPrint('Unhandled Yurich Connect error: $error\n$stack');
    },
  );
}
