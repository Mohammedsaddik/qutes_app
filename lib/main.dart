import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:qutes_app/app.dart';
import 'Core/utils/block_observable.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  BlocOverrides.runZoned(
    () {
      runApp(QuoteApp());
    },
    blocObserver: AppBlocObserver(),
  );
}
