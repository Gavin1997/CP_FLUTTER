/*
 * @Author: test
 * @Date: 2025-08-30 23:20:27
 * @LastEditTime: 2025-08-30 23:38:16
 * @FilePath: /flutter_starter/lib/common/widgets/custom_bottom_nav_bar.dart
 * @Description: 
 */
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 底部导航栏项
class BottomNavItem {
  final IconData icon;
  final String label;
  final Widget? activeIcon;

  const BottomNavItem({
    required this.icon,
    required this.label,
    this.activeIcon,
  });
}

/// 自定义底部导航栏
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final List<BottomNavItem> items;
  final ValueChanged<int> onTap;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double? height;
  final double blurStrength;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.height,
    this.blurStrength = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.r),
        topRight: Radius.circular(16.r),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurStrength, sigmaY: blurStrength),
        child: Container(
          decoration: BoxDecoration(
            color: (backgroundColor ?? theme.colorScheme.surface)
                .withValues(alpha: 0.8),
            border: Border(
              top: BorderSide(
                color: theme.dividerColor.withValues(alpha: 0.3),
                width: 0,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTap,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent, // 设置为透明，让毛玻璃效果更明显
            selectedItemColor: selectedItemColor ?? theme.colorScheme.primary,
            unselectedItemColor: unselectedItemColor ??
                theme.colorScheme.onSurface.withValues(alpha: 0.7),
            selectedFontSize: 12.sp,
            unselectedFontSize: 12.sp,
            elevation: 0, // 移除默认阴影，因为我们已经添加了自定义阴影
            items: items.map((item) {
              return BottomNavigationBarItem(
                icon: Icon(item.icon),
                activeIcon: item.activeIcon ?? Icon(item.icon),
                label: item.label,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
