import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qutes_app/features/random_quote/presentation/pages/quote_screen.dart';
import 'package:qutes_app/features/splash/presentation/pages/splash_screen.dart';
import 'package:qutes_app/injection_container.dart'as di;
import '../../features/random_quote/presentation/cubit/random_quote_cubit.dart';

class Routes {
  static const String initialRoute = '/';
  static const String undefined = "/undefinedRoute";
  static const String randomQuoteRoute = '/randomQuote';
}

class AppRoutes {
  static Route? onGenerateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: (context) {
          return const SplashScreen();
        });

      case Routes.randomQuoteRoute:
        return MaterialPageRoute(builder: ((context) {
          return BlocProvider(
            create: ((context) => di.sl<RandomQuoteCubit>()),
            child: const QuotesScreen(),
          );
        }));
      default:
        return undefined();
    }
  }

  static Route<dynamic> undefined() {
    return MaterialPageRoute(
        builder: ((context) => const Scaffold(
              body: Center(child: Text('No Route Found')),
            )));
  }
}
