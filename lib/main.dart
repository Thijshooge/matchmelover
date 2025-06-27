import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logging/logging.dart';
import 'firebase_options.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure logging
  _setupLogging();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

void _setupLogging() {
  // Only log in debug mode to avoid printing sensitive information in production
  if (kDebugMode) {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      debugPrint(
        '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}',
      );
      if (record.error != null) {
        debugPrint('Error: ${record.error}');
      }
      if (record.stackTrace != null) {
        debugPrint('Stack trace: ${record.stackTrace}');
      }
    });
  } else {
    // In production, only log severe errors
    Logger.root.level = Level.SEVERE;
    Logger.root.onRecord.listen((record) {
      // In production, you might want to send logs to a crash reporting service
      // like Firebase Crashlytics or Sentry instead of printing
      if (record.level >= Level.SEVERE) {
        debugPrint(
          '${record.level.name}: ${record.loggerName}: ${record.message}',
        );
      }
    });
  }
}
