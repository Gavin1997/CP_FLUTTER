/*
 * @Author: test
 * @Date: 2025-08-30 23:40:38
 * @LastEditTime: 2025-08-30 23:41:05
 * @FilePath: /flutter_starter/lib/common/widgets/background_widget.dart
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 应用统一的背景组件
class BackgroundWidget extends StatelessWidget {
  final Widget child;
  final BoxFit fit;
  final Alignment alignment;
  final Color? overlayColor;
  final double overlayOpacity;
  final String? backgroundImagePath;

  const BackgroundWidget({
    super.key,
    required this.child,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.overlayColor,
    this.overlayOpacity = 0.0,
    this.backgroundImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 背景图片
        Positioned.fill(
          child: Image.asset(
            backgroundImagePath ?? 'assets/images/app_bg.png',
            fit: fit,
            alignment: alignment,
            errorBuilder: (context, error, stackTrace) {
              // 如果图片加载失败，使用默认渐变背景
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.1),
                      Theme.of(context)
                          .colorScheme
                          .secondary
                          .withValues(alpha: 0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              );
            },
          ),
        ),

        // 可选的覆盖层
        if (overlayOpacity > 0.0)
          Positioned.fill(
            child: Container(
              color: (overlayColor ?? Colors.black)
                  .withValues(alpha: overlayOpacity),
            ),
          ),

        // 子组件
        child,
      ],
    );
  }
}

/// 全局背景包装器
class AppBackgroundWrapper extends StatelessWidget {
  final Widget child;
  final double overlayOpacity;

  const AppBackgroundWrapper({
    super.key,
    required this.child,
    this.overlayOpacity = 0.05, // 轻微的覆盖层，让文字更清晰
  });

  @override
  Widget build(BuildContext context) {
    // 设置状态栏为透明
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return SizedBox.expand(
      child: BackgroundWidget(
        child: child,
        overlayOpacity: overlayOpacity,
      ),
    );
  }
}

/// 页面专用背景包装器 - 可以自定义背景图片
class PageBackgroundWrapper extends StatelessWidget {
  final Widget child;
  final String? backgroundImagePath;
  final BoxFit fit;
  final double overlayOpacity;

  const PageBackgroundWrapper({
    super.key,
    required this.child,
    this.backgroundImagePath,
    this.fit = BoxFit.cover,
    this.overlayOpacity = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      backgroundImagePath: backgroundImagePath ?? 'assets/images/app_bg.png',
      fit: fit,
      child: child,
      overlayOpacity: overlayOpacity,
    );
  }
}
