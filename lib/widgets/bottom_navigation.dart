import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../widgets/custom_icons.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.9),
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              index: 0,
              icon: CustomIcons.homeIcon(
                size: 24,
                color: currentIndex == 0 ? AppColors.primary : Colors.grey,
              ),
              label: AppStrings.home,
              isActive: currentIndex == 0,
            ),
            _buildNavItem(
              index: 1,
              icon: CustomIcons.exploreIcon(
                size: 24,
                color: currentIndex == 1 ? AppColors.primary : Colors.grey,
              ),
              label: AppStrings.explore,
              isActive: currentIndex == 1,
            ),
            _buildUploadButton(),
            _buildNavItem(
              index: 3,
              icon: CustomIcons.chatIcon(
                size: 24,
                color: currentIndex == 3 ? AppColors.primary : Colors.grey,
              ),
              label: AppStrings.chat,
              isActive: currentIndex == 3,
            ),
            _buildNavItem(
              index: 4,
              icon: CustomIcons.profileIcon(
                size: 24,
                color: currentIndex == 4 ? AppColors.primary : Colors.grey,
              ),
              label: AppStrings.profile,
              isActive: currentIndex == 4,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required Widget icon,
    required String label,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: icon,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isActive ? AppColors.primary : Colors.grey,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            if (isActive)
              Container(
                margin: const EdgeInsets.only(top: 2),
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadButton() {
    return GestureDetector(
      onTap: () => onTap(2),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: CustomIcons.uploadIcon(
          size: 24,
          color: Colors.white,
        ),
      ),
    );
  }
}