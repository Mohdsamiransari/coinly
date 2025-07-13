import 'package:coinly/core/router/router_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_section.dart';
import '../widgets/profile_list_item.dart';
import '../widgets/logout_button.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProfileHeader(),
          Divider(height: 32.h, color: Colors.white38),
          ProfileSection(
            title: 'Account',
            children: [
              ProfileListItem(
                icon: Icons.person,
                label: 'Personal Details',
                onTap: () {},
              ),
              ProfileListItem(
                icon: Icons.lock,
                label: 'Password and security',
                onTap: () {},
              ),
            ],
          ),
          ProfileSection(
            title: 'More info and Support',
            children: [
              ProfileListItem(
                icon: Icons.notifications,
                label: 'Notification',
                onTap: () {},
              ),
            ],
          ),
          ProfileSection(
            title: 'More info and Support',
            children: [
              ProfileListItem(
                icon: Icons.help_outline,
                label: 'Help',
                onTap: () {
                  GoRouter.of(context).pushNamed(RouterConstant.helpScreen);
                },
              ),
              ProfileListItem(
                icon: Icons.info_outline,
                label: 'About',
                onTap: () {
                  GoRouter.of(context).pushNamed(RouterConstant.aboutScreen);
                },
              ),
              ProfileListItem(
                icon: Icons.description_outlined,
                label: 'Terms and Conditions',
                onTap: () {
                  GoRouter.of(context)
                      .pushNamed(RouterConstant.termsAndConditionsScreen);
                },
              ),
            ],
          ),
          const LogoutButton(),
        ],
      ),
    );
  }
}
