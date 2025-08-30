/*
 * @Author: test
 * @Date: 2025-08-30 17:20:00
 * @LastEditTime: 2025-08-30 17:20:00
 * @FilePath: /flutter_starter/lib/features/example/view/svg_example.dart
 * @Description: SVG使用示例页面
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kxrcp/common/widgets/common_app_bar.dart';
import 'package:kxrcp/common/widgets/svg_icon.dart';
import 'package:kxrcp/r.dart';

class SvgExamplePage extends StatelessWidget {
  const SvgExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: 'SVG图标示例',
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              '基础SVG图标',
              [
                _buildIconRow('默认大小', SvgIcon(assetPath: R.assetsIconsHeaderLeft)),
                _buildIconRow('自定义大小 (32)', SvgIcon(assetPath: R.assetsIconsHeaderLeft, size: 32.w)),
                _buildIconRow('自定义大小 (32)', SvgIcon(assetPath: R.assetsIconsHeaderLeft, size: 32)),
                _buildIconRow('自定义颜色', SvgIcon(assetPath: R.assetsIconsHeaderLeft, size: 24, color: Colors.red)),
                _buildIconRow('蓝色图标', SvgIcon(assetPath: R.assetsIconsHeaderLeft, size: 24, color: Colors.blue)),
              ],
            ),
            SizedBox(height: 30.h),
            _buildSection(
              'SVG按钮图标',
              [
                _buildIconRow('默认按钮', SvgIconButton(
                  assetPath: R.assetsIconsHeaderLeft,
                  onPressed: () => _showSnackBar(context, '点击了默认按钮'),
                )),
                _buildIconRow('大按钮', SvgIconButton(
                  assetPath: R.assetsIconsHeaderLeft,
                  size: 32,
                  color: Colors.green,
                  onPressed: () => _showSnackBar(context, '点击了大按钮'),
                )),
                _buildIconRow('紫色按钮', SvgIconButton(
                  assetPath: R.assetsIconsHeaderLeft,
                  size: 28,
                  color: Colors.purple,
                  onPressed: () => _showSnackBar(context, '点击了紫色按钮'),
                )),
              ],
            ),
            SizedBox(height: 30.h),
            _buildSection(
              '不同尺寸对比',
              [
                Row(
                  children: [
                    Text('16px: ', style: TextStyle(fontSize: 14.sp)),
                    SvgIcon(assetPath: R.assetsIconsHeaderLeft, size: 16),
                    SizedBox(width: 20.w),
                    Text('24px: ', style: TextStyle(fontSize: 14.sp)),
                    SvgIcon(assetPath: R.assetsIconsHeaderLeft, size: 24),
                    SizedBox(width: 20.w),
                    Text('32px: ', style: TextStyle(fontSize: 14.sp)),
                    SvgIcon(assetPath: R.assetsIconsHeaderLeft, size: 32),
                    SizedBox(width: 20.w),
                    Text('48px: ', style: TextStyle(fontSize: 14.sp)),
                    SvgIcon(assetPath: R.assetsIconsHeaderLeft, size: 48),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 15.h),
        ...children,
      ],
    );
  }

  Widget _buildIconRow(String label, Widget icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: Row(
        children: [
          SizedBox(
            width: 120.w,
            child: Text(
              label,
              style: TextStyle(fontSize: 14.sp),
            ),
          ),
          icon,
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
