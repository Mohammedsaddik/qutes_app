import 'package:flutter/material.dart';
import 'package:qutes_app/Core/utils/app_colors.dart';
import 'package:qutes_app/Core/utils/styls.dart';
import 'package:qutes_app/features/random_quote/domain/entities/quotes.dart';

class Quotecontent extends StatelessWidget {
  final Quote quote;
  const Quotecontent({
    super.key,
    required this.quote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Text(
            quote.content,
            style: Styles.textStyle20,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
              quote.author,
              style: Styles.textStyle20,
            ),
          ),
        ],
      ),
    );
  }
}
