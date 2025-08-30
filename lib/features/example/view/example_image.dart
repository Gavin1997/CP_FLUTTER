/*
 * @Author: test
 * @Date: 2025-08-30 16:11:33
 * @LastEditTime: 2025-08-30 16:47:18
 * @FilePath: /flutter_starter/lib/features/example/view/example_image.dart
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:kxrcp/common/widgets/common_app_bar.dart';
import 'package:kxrcp/r.dart';


/// 图片使用方式示例
class ExampleImage extends StatelessWidget {
  const ExampleImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: '图片使用示例'),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Image.asset - 最常用的方式
            const Text('1. Image.asset (推荐)'),
            SizedBox(height: 8.h),
            Image.asset(
              R.assetsImagesLogo,
              width: 100.w,
              height: 100.h,
              fit: BoxFit.contain,
            ),
            
            SizedBox(height: 24.h),
            
            // 2. Image + AssetImage
            const Text('2. Image + AssetImage'),
            SizedBox(height: 8.h),
            Image(
              image: const AssetImage(R.assetsImagesLogo),
              width: 100.w,
              height: 100.h,
              fit: BoxFit.contain,
            ),
            
            SizedBox(height: 24.h),
            
            // 3. Container + DecorationImage + AssetImage
            const Text('3. Container 背景图片'),
            SizedBox(height: 8.h),
            Container(
              width: 100.w,
              height: 100.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(R.assetsImagesLogo),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            
            SizedBox(height: 24.h),
            
            // 4. CircleAvatar + AssetImage
            const Text('4. CircleAvatar 头像'),
            SizedBox(height: 8.h),
            CircleAvatar(
              radius: 50.r,
              backgroundImage: const AssetImage(R.assetsImagesLogo),
            ),
          ],
        ),
      ),
    );
  }
}