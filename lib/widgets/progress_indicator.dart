import 'package:firstapp/constants/colors.dart';
import 'package:flutter/material.dart';
// import 'package:kabir/src/constants/colors.dart';

class BiteProgressIndicator extends StatelessWidget {
  const BiteProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: biteColorSecondary,
        color: biteColorPrimary,
      ),
    );
  }
}
