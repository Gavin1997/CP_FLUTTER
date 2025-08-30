import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 设置页面
class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool _notificationEnabled = true;
  bool _darkModeEnabled = false;
  String _language = 'zh';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          // 账户设置
          _buildSectionTitle('账户设置'),
          _buildListItem(
            icon: Icons.account_circle,
            title: '账户信息',
            subtitle: '修改个人信息',
            onTap: () {
              // TODO: 跳转到账户信息页面
            },
          ),
          _buildListItem(
            icon: Icons.lock,
            title: '修改密码',
            subtitle: '更改账户密码',
            onTap: () {
              // TODO: 跳转到修改密码页面
            },
          ),

          SizedBox(height: 24.h),

          // 通知设置
          _buildSectionTitle('通知设置'),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('推送通知'),
                  subtitle: const Text('接收应用推送通知'),
                  value: _notificationEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationEnabled = value;
                    });
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text('通知声音'),
                  subtitle: const Text('设置通知提示音'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
                  onTap: () {
                    // TODO: 跳转到通知声音设置
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          // 外观设置
          _buildSectionTitle('外观设置'),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('深色模式'),
                  subtitle: const Text('切换深色/浅色主题'),
                  value: _darkModeEnabled,
                  onChanged: (value) {
                    setState(() {
                      _darkModeEnabled = value;
                    });
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text('语言'),
                  subtitle: Text(_getLanguageName(_language)),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
                  onTap: _showLanguageDialog,
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          // 其他设置
          _buildSectionTitle('其他'),
          _buildListItem(
            icon: Icons.help,
            title: '帮助中心',
            subtitle: '常见问题和使用指南',
            onTap: () {
              // TODO: 跳转到帮助页面
            },
          ),
          _buildListItem(
            icon: Icons.info,
            title: '关于应用',
            subtitle: '版本信息和开发者',
            onTap: _showAboutDialog,
          ),
          _buildListItem(
            icon: Icons.feedback,
            title: '意见反馈',
            subtitle: '告诉我们您的建议',
            onTap: () {
              // TODO: 跳转到反馈页面
            },
          ),

          SizedBox(height: 24.h),

          // 危险操作
          _buildSectionTitle('账户操作'),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: Text(
                '退出登录',
                style: TextStyle(color: Colors.red),
              ),
              subtitle: const Text('将会清除本地数据'),
              onTap: _showLogoutDialog,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建章节标题
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
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

  /// 获取语言名称
  String _getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'zh':
        return '中文';
      case 'en':
        return 'English';
      default:
        return '中文';
    }
  }

  /// 显示语言选择对话框
  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('选择语言'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('中文'),
              value: 'zh',
              groupValue: _language,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _language = value;
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
            RadioListTile<String>(
              title: const Text('English'),
              value: 'en',
              groupValue: _language,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _language = value;
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
        ],
      ),
    );
  }

  /// 显示关于对话框
  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('关于'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Flutter Rapid Framework'),
            SizedBox(height: 8),
            Text('版本: 1.0.0'),
            Text('开发者: Flutter Team'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  /// 显示退出登录对话框
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('退出登录'),
        content: const Text('确定要退出登录吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: 实现退出登录逻辑
            },
            child: const Text('确定'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
