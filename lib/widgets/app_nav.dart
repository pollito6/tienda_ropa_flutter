import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: AppColors.primary,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 28),
            activeIcon: Icon(Icons.home, size: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border, size: 28),
            activeIcon: Icon(Icons.favorite, size: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history, size: 28),
            activeIcon: Icon(Icons.history, size: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, size: 28),
            activeIcon: Icon(Icons.person, size: 28),
            label: '',
          ),
        ],
      ),
    );
  }
}
