import 'dart:developer';

import 'package:coinly/components/auth/bloc/auth_bloc.dart';
import 'package:coinly/components/common/image_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class SocialLoginWidget extends StatefulWidget {
  final AuthBloc authBloc;
  const SocialLoginWidget({super.key, required this.authBloc});

  @override
  State<SocialLoginWidget> createState() => _SocialLoginWidgetState();
}

class _SocialLoginWidgetState extends State<SocialLoginWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.r),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: IconButton(
                  onPressed: () {
                    if (index == 0) {
                      log("FaceBook");
                    } else if (index == 1) {
                      log("Google");
                    } else {
                      log("Apple");
                    }
                  },
                  icon: ImagePreview(
                    path: widget.authBloc.signInIcons[index],
                    width: 24.r,
                    height: 24.r,
                    // color: Colors.black,
                  ),
                  color: Colors.white,
                  style: ButtonStyle(
                    fixedSize: WidgetStateProperty.all(Size(50.r, 50.r)),
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                    shape: WidgetStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
