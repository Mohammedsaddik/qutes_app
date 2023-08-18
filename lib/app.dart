import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qutes_app/Config/locale/app_localizations_setup.dart';
import 'package:qutes_app/Config/routes/app_routes.dart';
import 'package:qutes_app/Config/theams/app_theam.dart';
import 'package:qutes_app/features/splash/presentation/cubit/splash_cubit.dart';
import 'injection_container.dart' as di;

class QuoteApp extends StatelessWidget {
  const QuoteApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<LocaleCubit>()..getSavedLang()),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
          buildWhen: (previousState, currentState) {
        return previousState != currentState;
      }, builder: (context, State) {
        return MaterialApp(
          locale: State.locale,
          supportedLocales: AppLocalizationsSetup.supportedLocales,
          localeResolutionCallback:
              AppLocalizationsSetup.localeResolutionCallback,
          localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
          theme: appTheme(),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoutes.onGenerateRoutes,
        );
      }),
    );
  }
}
