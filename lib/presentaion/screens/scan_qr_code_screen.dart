import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_task/core/app_functions/show_snackbar.dart';
import 'package:qr_code_task/core/app_resources/app_images.dart';
import 'package:qr_code_task/core/app_resources/app_sizes.dart';
import 'package:qr_code_task/core/app_resources/app_strings.dart';
import 'package:qr_code_task/core/app_routes/routes.dart';
import 'package:qr_code_task/presentaion/managers/scan_cubit/scan_cubit.dart';
import 'package:qr_code_task/presentaion/widgets/custom_full_button.dart';
import 'package:qr_code_task/presentaion/widgets/custom_scan_header.dart';
import 'package:qr_code_task/presentaion/widgets/custom_scan_title_header.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanQrCodeScreen extends StatelessWidget {
  const ScanQrCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: _buildScanQrCodeBody(context),
    );
  }

  Widget _buildScanQrCodeBody(BuildContext context) => SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.appWidth * AppWidth.s18,
              vertical: AppSizes.appHeight * AppHeight.s31,
            ),
            child: Column(
              children: [
                const CustomScanHeader(
                  imgIcon: AppImages.scanActionIcon,
                ),
                SizedBox(
                  height: AppSizes.appHeight * AppHeight.s57,
                ),
                const CustomScanTitleHeader(
                    title: AppStrings.scanQrCodeTitle,
                    subTitle: AppStrings.scanQrCodeSubTitle),
                SizedBox(
                  height: AppSizes.appHeight * AppHeight.s75,
                ),
                _buildQrCode(context),
                SizedBox(
                  height: AppSizes.appHeight * AppHeight.s43,
                ),
                _buildScanOptions(),
                SizedBox(
                  height: AppSizes.appHeight * AppHeight.s25,
                ),
                BlocConsumer<ScanCubit, ScanState>(
                  listener: (context, state) {
                    if (state is ScanFailedState) {
                      showTextSnackBar(
                          context: context, message: state.message!);
                    } else if (state is ScanSuccessState) {
                      Navigator.pushNamed(
                          context, AppRoutes.scanResultsScreenRoute);
                    }
                  },
                  builder: (context, state) => CustomActionButton(
                      width: AppSizes.appWidth * AppWidth.s280,
                      verticalPadding: AppSizes.appHeight * AppHeight.s20,
                      borderColor: Colors.transparent,
                      borderRadius: 5,
                      onPressed: state is ScanLoadingState
                          ? null
                          : () async {
                              await openQrScannerScreen().then((codeValue) {
                                if (codeValue != '-1') {
                                  ScanCubit.get(context).scan(code: codeValue);
                                }
                              });
                            },
                      textStyle: Theme.of(context).textTheme.titleMedium!,
                      fontWeight: FontWeight.w500,
                      backgroundColor: Colors.deepOrange.shade400,
                      foregroundColor: Colors.white,
                      text: AppStrings.placeCameraCode,
                      elevation: 2),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildQrCode(context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppImages.scanQrCodeLogo),
          SizedBox(
            height: AppSizes.appHeight * AppHeight.s17,
          ),
          BlocBuilder<ScanCubit, ScanState>(
            builder: (context, state) => state is ScanLoadingState
                ? AutoSizeText(
                    AppStrings.scanLoadingText,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  )
                : Container(),
          ),
        ],
      );

  Widget _buildScanOptions() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ImageIcon(AssetImage(AppImages.galleryScanIcon)),
          SizedBox(
            width: AppSizes.appWidth * AppWidth.s31,
          ),
          const ImageIcon(AssetImage(AppImages.keyboardScanIcon)),
          SizedBox(
            width: AppSizes.appWidth * AppWidth.s31,
          ),
          const ImageIcon(AssetImage(AppImages.instantScanIcon))
        ],
      );

  Future<String?> openQrScannerScreen() async {
    await Permission.camera.request();
    try {
      return await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', AppStrings.cancel, true, ScanMode.QR);
    } on PlatformException {
      return null;
    }
  }
}
