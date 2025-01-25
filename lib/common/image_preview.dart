import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class ImagePreview extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final Color? color;
  final dynamic fit;
  final String? fileType;
  final BoxDecoration? decoration;
  final AlignmentGeometry? alignment;
  const ImagePreview(
      {super.key,
      required this.path,
      this.width,
      this.height,
      this.color,
      this.fit,
      this.fileType,
      this.decoration,
      this.alignment});

  @override
  Widget build(BuildContext context) {
    List<dynamic> pathList;
    pathList = path.split('.');
    if (path.isNotEmpty && path != "null") {
      if (fileType != null && fileType == "file") {
        return Image.file(
          File(path),
          width: width,
          height: height,
          fit: fit,
          cacheWidth: 100,
          cacheHeight: 100,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) return child;
            if (frame == null) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: width,
                  height: height,
                  decoration: decoration,
                ),
              );
            } else {
              return child;
            }
          },
          errorBuilder: (context, error, stackTrace) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: width,
                height: height,
                decoration: decoration,
              ),
            );
          },
        );
      } else if (path.contains("https") || path.contains('http')) {
        if (pathList[pathList.length - 1] == 'svg') {
          return SvgPicture.network(
            path,
            width: width,
            height: height,
          );
        } else {
          return Image.network(
            path,
            width: width,
            height: height,
            fit: fit,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded) return child;
              if (frame == null) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: width,
                    height: height,
                    decoration: decoration,
                  ),
                );
              } else {
                return child;
              }
            },
          
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child; // The image is fully loaded.
              } else {
                return SizedBox(
                  width: double.infinity,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  ),
                );
              }
            },
            // errorBuilder:
            //     (BuildContext context, Object error, StackTrace? stackTrace) {
            //   return Image.asset(
            //     // AppImages.gifloaderimage,
            //     AppAssets.profile,
            //     width: width,
            //     height: height,
            //   );
            // },
          );
        }
      } else {
        if (pathList[pathList.length - 1] == 'svg') {
          return SvgPicture.asset(
            path,
            width: width,
            height: height,
            // ignore: deprecated_member_use
            color: color,
          );
        } else {
          return Image.asset(
            path,
            width: width,
            height: height,
            fit: fit,
          );
        }
      }
    } else {
      return const SizedBox.shrink();
    }
  }
}
