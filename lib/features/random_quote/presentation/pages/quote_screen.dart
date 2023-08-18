import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qutes_app/Config/locale/app_localizations.dart';
import 'package:qutes_app/Core/utils/app_colors.dart';
import 'package:qutes_app/features/random_quote/presentation/widgets/quote_content.dart';
import 'package:qutes_app/features/splash/presentation/cubit/splash_cubit.dart';
import '../cubit/random_quote_cubit.dart';
import 'package:qutes_app/Core/widget/error_widget.dart' as error_widget;

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({Key? key}) : super(key: key);

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  _getRandomQuote() =>
      BlocProvider.of<RandomQuoteCubit>(context).getRandomQuote();
  @override
  void initState() {
    super.initState();
    _getRandomQuote();
  }

  Widget _buildBodyContent() {
    return BlocBuilder<RandomQuoteCubit, RandomQuoteState>(
      builder: (context, state) {
        if (state is RandomQuoteLoading) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primary,
            ),
          );
        } else if (state is RandomQuoteError) {
          return error_widget.ErrorWidget(
            onPress: () => _getRandomQuote(),
          );
        } else if (state is RandomQuoteSuccess) {
          return Column(children: [
            Quotecontent(quote: state.quote),
            const SizedBox(
              height: 10.0,
            ),
            InkWell(
              onTap: () => _getRandomQuote(),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15.0),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
          ]);
        } else {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primary,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.translate_outlined,
          color: AppColors.primary,
        ),
        onPressed: () {
          if (AppLocalizations.of(context)!.isEnLocale) {
            BlocProvider.of<LocaleCubit>(context).toArabic();
          } else {
            BlocProvider.of<LocaleCubit>(context).toEnglish();
          }
        },
      ),
      title: Text(AppLocalizations.of(context)!.translate('app_name')!),
    );
    return RefreshIndicator(
      child: Scaffold(
        appBar: appBar,
        body: _buildBodyContent(),
      ),
      onRefresh: () => _getRandomQuote(),
    );
  }
}
