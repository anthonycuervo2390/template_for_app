import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firestore_demo/core/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:firestore_demo/app.dart';
import 'package:firestore_demo/core/presentation/res/app_config.dart';
import 'package:firestore_demo/core/presentation/res/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runZonedGuarded<Future<void>>(() async {
    runApp(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Banner(
          location: BannerLocation.topEnd,
          message: "dev",
          textDirection: TextDirection.ltr,
          child: ProviderScope(
            child: App(),
            overrides: [
              configProvider.overrideWithProvider(Provider(
                (ref) => AppConfig(
                  appTitle: AppConstants.appNameDev,
                  buildFlavor: AppFlavor.dev,
                ),
              ))
            ],
          ),
        ),
      ),
    );
  },
      (Object error, StackTrace stackTrace) =>
          FirebaseCrashlytics.instance.recordError(error, stackTrace));
}
