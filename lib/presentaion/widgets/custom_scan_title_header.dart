import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_task/core/app_resources/app_sizes.dart';

class CustomScanTitleHeader extends StatelessWidget {
  const CustomScanTitleHeader({Key? key, this.title, this.subTitle})
      : super(key: key);
  final String? title;
  final String? subTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AutoSizeText(
          title!,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: AppSizes.appHeight * AppHeight.s31,
        ),
        AutoSizeText(
          subTitle!,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Colors.grey.shade500, height: 1.3),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
