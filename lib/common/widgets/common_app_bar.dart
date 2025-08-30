/*
 * @Author: test
 * @Date: 2025-08-30 16:19:29
 * @LastEditTime: 2025-08-30 17:16:38
 * @FilePath: /flutter_starter/lib/common/widgets/common_app_bar.dart
 * @Description: 
 */
import 'package:flutter/material.dart';

import 'package:kxrcp/r.dart';
import 'package:kxrcp/core/router/app_router.dart';
import 'package:kxrcp/common/widgets/svg_icon.dart';
// import 'package:get/get.dart';


class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? titleColor;
  final double? titleSize;
  final FontWeight? titleWeight;
  final Color? backgroundColor;
  final double? elevation;
  final bool centerTitle;
  final Widget? leading;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final VoidCallback? onBackPressed;
  final Widget? titleWidget;

  const CommonAppBar({
    Key? key,
    required this.title,
    this.titleColor = Colors.white,
    this.titleSize = 18.0,
    this.titleWeight = FontWeight.w600,
    this.backgroundColor = const Color(0xFFED99DE),
    this.elevation = 0.0,
    this.centerTitle = true,
    this.leading,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.onBackPressed,
    this.titleWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:
          titleWidget ??
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: titleSize,
              fontWeight: titleWeight,
            ),
          ),
      backgroundColor: backgroundColor,
      elevation: elevation,
      centerTitle: centerTitle,
      leading: leading ?? _buildLeading(),
      actions: actions,
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }

  Widget? _buildLeading() {
    if (!automaticallyImplyLeading) return null;

    return SvgIconButton(
      assetPath: R.assetsIconsHeaderLeft,
      size: 24,
      color: titleColor ?? Colors.white,
      onPressed: onBackPressed ?? () => AppNavigator.pop(),
      tooltip: '返回',
      semanticsLabel: '返回上一页',
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

