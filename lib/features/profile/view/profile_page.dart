import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 我的页面
class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  Map<String, dynamic>? userInfo;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  /// 加载用户信息
  void _loadUserInfo() {
    // TODO: 从存储中获取用户信息
    userInfo = {
      'nickname': '用户123',
      'email': 'user@example.com',
      'avatar': '',
      'loginTime': DateTime.now().toIso8601String(),
    };
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // 保持与主页面一致
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 24.h),

            // 功能选项
            Expanded(
              child: ListView(
                children: [
                  _buildListItem(
                    icon: Icons.account_circle,
                    title: '账户信息',
                    subtitle: '查看和编辑个人信息',
                    onTap: () {
                      // TODO: 跳转到账户信息页面
                    },
                  ),
                  _buildListItem(
                    icon: Icons.security,
                    title: '隐私与安全',
                    subtitle: '管理隐私设置和安全选项',
                    onTap: () {
                      // TODO: 跳转到隐私设置页面
                    },
                  ),
                  _buildListItem(
                    icon: Icons.notifications,
                    title: '通知设置',
                    subtitle: '管理通知偏好',
                    onTap: () {
                      // TODO: 跳转到通知设置页面
                    },
                  ),
                  _buildListItem(
                    icon: Icons.help,
                    title: '帮助与支持',
                    subtitle: '获取帮助和联系支持',
                    onTap: () {
                      // TODO: 跳转到帮助页面
                    },
                  ),
                  _buildListItem(
                    icon: Icons.info,
                    title: '关于',
                    subtitle: '应用版本和信息',
                    onTap: () {
                      // TODO: 显示关于对话框
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建列表项
  Widget _buildListItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 8.h),
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
        onTap: onTap,
      ),
    );
  }
}
