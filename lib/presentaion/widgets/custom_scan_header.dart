import 'package:flutter/material.dart';

class CustomScanHeader extends StatelessWidget {
  const CustomScanHeader({Key? key, this.imgIcon}) : super(key: key);
  final String? imgIcon;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: ImageIcon(
        AssetImage(imgIcon!),
        color: Colors.deepOrange,
      ),
    );
  }
}
