import 'package:coinly/components/common/common_sized_box_widget.dart';
import 'package:coinly/components/common/image_preview.dart';
import 'package:coinly/utils/app_assets.dart';
import 'package:coinly/utils/app_colors.dart';
import 'package:coinly/utils/app_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QrCodeScannerScreen extends StatefulWidget {
  const QrCodeScannerScreen({super.key});

  @override
  State<QrCodeScannerScreen> createState() => _QrCodeScannerScreenState();
}

class _QrCodeScannerScreenState extends State<QrCodeScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.white,
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Expanded(
            child: QRView(
              overlay: QrScannerOverlayShape(
                borderColor: AppColors.white,
                borderWidth: 4.r,
                overlayColor: AppColors.primaryBlue,
              ),
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Positioned(
            top: 140.h,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.white.withOpacity(0.7),
                  radius: 14.r,
                  child: ImagePreview(
                    path: AppAssets.apple,
                    width: 20.r,
                    height: 20.r,
                  ),
                ),
                CommonSizedBoxWidget.width(8.w),
                Text(
                  'Jacob Lee',
                  style: AppTextStyles.getStyle(
                    colorVariant: ColorVariant.white,
                    sizeVariant: SizeVariant.mediumLarge,
                    fontWeightVariant: FontWeightVariant.medium,
                  ).copyWith(color: Colors.white.withOpacity(0.7)),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 140.h,
            child: (result != null)
                ? Text(
                    'Barcode Type: ${describeEnum(result!.format)}\nData: ${result!.code}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  )
                : Text(
                    'Scan to become friends',
                    style: AppTextStyles.getStyle(
                      colorVariant: ColorVariant.white,
                      sizeVariant: SizeVariant.medium,
                      fontWeightVariant: FontWeightVariant.regular,
                    ).copyWith(color: Colors.white.withOpacity(0.7)),
                  ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }
}
