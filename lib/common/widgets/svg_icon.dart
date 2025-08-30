/*
 * @Author: test
 * @Date: 2025-08-30 17:15:00
 * @LastEditTime: 2025-08-30 17:15:00
 * @FilePath: /flutter_starter/lib/common/widgets/svg_icon.dart
 * @Description: SVG图标通用组件
 */
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// SVG图标组件
class SvgIcon extends StatelessWidget {
  /// SVG资源路径
  final String assetPath;
  
  /// 图标宽度
  final double? width;
  
  /// 图标高度
  final double? height;
  
  /// 图标大小（同时设置宽高）
  final double? size;
  
  /// 图标颜色
  final Color? color;
  
  /// 图标适配方式
  final BoxFit fit;
  
  /// 图标对齐方式
  final Alignment alignment;
  
  /// 语义标签（用于无障碍）
  final String? semanticsLabel;

  const SvgIcon({
    Key? key,
    required this.assetPath,
    this.width,
    this.height,
    this.size,
    this.color,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.semanticsLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 如果设置了size，则宽高都使用size
    final double? finalWidth = size ?? width;
    final double? finalHeight = size ?? height;
    
    return SvgPicture.asset(
      assetPath,
      width: finalWidth?.w,
      height: finalHeight?.w,
      colorFilter: color != null 
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
      fit: fit,
      alignment: alignment,
      semanticsLabel: semanticsLabel,
    );
  }
}

/// SVG图标按钮组件
class SvgIconButton extends StatelessWidget {
  /// SVG资源路径
  final String assetPath;
  
  /// 点击回调
  final VoidCallback? onPressed;
  
  /// 图标大小
  final double? size;
  
  /// 图标颜色
  final Color? color;
  
  /// 按钮内边距
  final EdgeInsetsGeometry? padding;
  
  /// 按钮约束
  final BoxConstraints? constraints;
  
  /// 语义标签
  final String? semanticsLabel;
  
  /// 提示信息
  final String? tooltip;

  const SvgIconButton({
    Key? key,
    required this.assetPath,
    this.onPressed,
    this.size = 24.0,
    this.color,
    this.padding,
    this.constraints,
    this.semanticsLabel,
    this.tooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconButton = IconButton(
      onPressed: onPressed,
      padding: padding ?? EdgeInsets.all(8.w),
      constraints: constraints,
      tooltip: tooltip,
      icon: SvgIcon(
        assetPath: assetPath,
        size: size,
        color: color,
        semanticsLabel: semanticsLabel,
      ),
    );
    
    return iconButton;
  }
}
