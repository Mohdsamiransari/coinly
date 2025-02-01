import 'package:coinly/components/analytics/ui/analytics_screen.dart';
import 'package:coinly/components/expense/ui/expense_screen.dart';
import 'package:coinly/components/friends/ui/friends_screen.dart';
import 'package:coinly/components/home/ui/home_screen.dart';
import 'package:coinly/components/profile/ui/profile_screen.dart';
import 'package:coinly/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  Widget renderScreen(index) {
    switch (index) {
      case 1:
        return const FriendsScreen();
      case 2:
        return const AnalyticsScreen();
      case 3:
        return const ExpenseScreen();
      case 4:
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 80;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            renderScreen(_currentIndex),
            if (!isKeyboardOpen)
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Container(
                  width: 304,
                  decoration: BoxDecoration(
                    color: AppColors.white, // Dark background color
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: SalomonBottomBar(
                    
                    currentIndex: _currentIndex,
                    onTap: (i) => setState(() => _currentIndex = i),
                    items: [
                      /// Home
                      SalomonBottomBarItem(
                        icon: const Icon(Icons.home),
                        title: const SizedBox.shrink(), // No title text
                        selectedColor: AppColors.black, // Active color
                      ),

                      /// Group
                      SalomonBottomBarItem(
                        icon: const Icon(Icons.group),
                        title: const SizedBox.shrink(),
                        selectedColor: AppColors.black,
                      ),

                      /// Analytics
                      SalomonBottomBarItem(
                        icon: const Icon(Icons.bar_chart),
                        title: const SizedBox.shrink(),
                        selectedColor: AppColors.black,
                      ),

                      /// Calendar
                      SalomonBottomBarItem(
                        icon: const Icon(Icons.calendar_today),
                        title: const SizedBox.shrink(),
                        selectedColor: AppColors.black,
                      ),

                      /// Profile
                      SalomonBottomBarItem(
                        icon: const Icon(Icons.person),
                        title: const SizedBox.shrink(),
                        selectedColor: AppColors.black,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
