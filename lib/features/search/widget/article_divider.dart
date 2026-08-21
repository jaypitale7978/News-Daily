import 'package:flutter/material.dart';

class ArticleDivider extends StatelessWidget {
  const ArticleDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        vertical: 27,
      ),
      child: Divider(
        height: 1,
        thickness: 1,
        color: Color(0xFFEAECF0),
      ),
    );
  }
}