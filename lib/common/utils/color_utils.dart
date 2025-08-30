/*
 * @Author: test
 * @Date: 2025-08-30 17:29:42
 * @LastEditTime: 2025-08-30 18:03:55
 * @FilePath: /flutter_starter/lib/common/utils/color_utils.dart
 * @Description: 
 */
import 'package:flutter/material.dart';
 
class ColorUtil {
  /// 十六进制颜色
  /// hex，十六进制值，例如：0xffffff，
  /// alpha，透明度[0.0, 1.0]
  static Color hexColor(int hex, {double alpha = 1}) {
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    return Color.fromRGBO((hex & 0xFF0000) >> 16, (hex & 0x00FF00) >> 8,
        (hex & 0x0000FF) >> 0, alpha);
  }

  /// 从十六进制字符串转换为Color
  /// 支持格式：#FDD6FE, FDD6FE, 0xFDD6FE, 0xfffdd6fe
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
 
  /// 十六进制颜色
  /// colorString，字符串，例如：'0x000000'  '0xff000000' '#000000' '#000000'，
  /// alpha，透明度[0.0, 1.0]
  static Color stringColor(String colorString, {double alpha = 1}) {
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    String colorStr = colorString;
    // colorString未带0xff前缀并且长度为6
    if (!colorStr.startsWith('0xff') && colorStr.length == 6) {
      colorStr = '0xff$colorStr';
    }
    // colorString为8位，如0x000000
    if (colorStr.startsWith('0x') && colorStr.length == 8) {
      colorStr = colorStr.replaceRange(0, 2, '0xff');
    }
    // colorString为7位，如#000000
    if (colorStr.startsWith('#') && colorStr.length == 7) {
      colorStr = colorStr.replaceRange(0, 1, '0xff');
    }
    // 先分别获取色值的RGB通道
    Color color = Color(int.parse(colorStr));
    int red = (color.r * 255.0).round() & 0xff;
    int green = (color.g * 255.0).round() & 0xff;
    int blue = (color.b * 255.0).round() & 0xff;
    // 通过fromRGBO返回带透明度和RGB值的颜色
    return Color.fromRGBO(red, green, blue, alpha);
  }
}