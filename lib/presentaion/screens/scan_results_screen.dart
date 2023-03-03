import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_task/core/app_resources/app_images.dart';
import 'package:qr_code_task/core/app_resources/app_sizes.dart';
import 'package:qr_code_task/core/app_resources/app_strings.dart';
import 'package:qr_code_task/core/app_routes/routes.dart';
import 'package:qr_code_task/core/app_widgets/custom_circular_progress_indicator.dart';
import 'package:qr_code_task/core/app_widgets/custom_error_widget.dart';
import 'package:qr_code_task/domain/entities/scan_info.dart';
import 'package:qr_code_task/presentaion/managers/scan_cubit/scan_cubit.dart';
import 'package:qr_code_task/presentaion/widgets/custom_full_button.dart';
import 'package:qr_code_task/presentaion/widgets/custom_scan_header.dart';
import 'package:qr_code_task/presentaion/widgets/custom_scan_title_header.dart';

class ScanResultsScreen extends StatelessWidget {
  const ScanResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScanCubit.get(context).getScans();

    ///set App Height and Width to use in all app
    AppSizes.appHeight = MediaQuery.of(context).size.height;
    AppSizes.appWidth = MediaQuery.of(context).size.width;

    ///
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: _buildScanQrCodeBody(context),
    );
  }

  Widget _buildScanQrCodeBody(BuildContext context) => SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.appWidth * AppWidth.s35,
              vertical: AppSizes.appHeight * AppHeight.s31,
            ),
            child: Column(
              children: [
                const CustomScanHeader(
                  imgIcon: AppImages.myScansActionIcon,
                ),
                SizedBox(
                  height: AppSizes.appHeight * AppHeight.s57,
                ),
                const CustomScanTitleHeader(
                    title: AppStrings.scanResultsTitle,
                    subTitle: AppStrings.scanResultsSubTitle),
                SizedBox(
                  height: AppSizes.appHeight * AppHeight.s60,
                ),
                _buildScanHistoryList(),
                SizedBox(
                  height: AppSizes.appHeight * AppHeight.s41,
                ),
                CustomActionButton(
                    width: AppSizes.appWidth * AppWidth.s280,
                    verticalPadding: AppSizes.appHeight * AppHeight.s20,
                    borderColor: Colors.transparent,
                    borderRadius: 5,
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.scanQrCodeScreenRoute,
                          (route) => false);
                    },
                    textStyle: Theme.of(context).textTheme.titleMedium!,
                    fontWeight: FontWeight.w500,
                    backgroundColor: Colors.deepOrange.shade400,
                    foregroundColor: Colors.white,
                    text: AppStrings.send,
                    elevation: 2),
              ],
            ),
          ),
        ),
      );

  Widget _buildScanHistoryList() => BlocBuilder<ScanCubit, ScanState>(
        builder: (context, state) {
          if (state is GetScansLoadingState) {
            return const CustomCircularProgressIndicator();
          } else if (state is GetScansFailedState) {
            return CustomErrorWidget(
              errorText: state.message,
            );
          } else if (state is GetScansSuccessState) {
            return SizedBox(
              height: AppSizes.appHeight * AppHeight.s310,
              width: AppSizes.appWidth * AppWidth.s270,
              child: ListView.separated(
                  itemBuilder: (context, index) =>
                      _buildScanHistoryItem(state.scans![index]),
                  separatorBuilder: (context, index) => SizedBox(
                        height: AppSizes.appHeight * AppHeight.s14,
                      ),
                  itemCount: state.scans!.length),
            );
          }
          return Container();
        },
      );

  Widget _buildScanHistoryItem(ScanInfo scanInfo) => Container(
        padding: EdgeInsets.symmetric(
            horizontal: AppSizes.appWidth * AppWidth.s15,
            vertical: AppSizes.appHeight * AppHeight.s20),
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            const Flexible(
              flex: 1,
              child: ImageIcon(
                AssetImage(AppImages.scanHistoryLeadingIcon),
                color: Colors.deepOrange,
              ),
            ),
            SizedBox(width: AppSizes.appWidth * AppWidth.s25),
            Flexible(
                flex: 5,
                child: AutoSizeText(
                  scanInfo.code!,
                  overflow: TextOverflow.ellipsis,
                )),
          ],
        ),
      );
}

/*
ListTile(
leading: ImageIcon(
AssetImage(AppImages.scanHistoryLeadingIcon),
color: Colors.deepOrange,
),
title: AutoSizeText(scanInfo.code!),
tileColor: Colors.grey.shade300,
);*/
