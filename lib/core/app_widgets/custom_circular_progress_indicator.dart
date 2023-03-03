import 'package:flutter/material.dart';
import 'package:qr_code_task/core/app_resources/app_sizes.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: AppSizes.appWidth * AppWidth.s20,
        height: AppSizes.appWidth * AppWidth.s20,
        child: CircularProgressIndicator(
          color: Colors.deepOrange.shade500,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
