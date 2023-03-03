import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_task/core/app_resources/app_sizes.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({Key? key, this.errorText}) : super(key: key);
  final String? errorText;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          color: Colors.deepOrange.shade500,
          size: AppSizes.appWidth * AppWidth.s40,
        ),
        SizedBox(
          height: AppSizes.appHeight * AppHeight.s20,
        ),
        AutoSizeText(
          errorText!,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.black54, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}
