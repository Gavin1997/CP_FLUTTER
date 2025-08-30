import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/widgets/custom_bottom_nav_bar.dart';
import '../../../core/router/app_router.dart';
import '../../../features/profile/view/profile_page.dart';
import '../../../features/settings/view/settings_page.dart';
import '../view_model/home_view_model.dart';
import 'home_content_page.dart';

/// 主页
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeViewModelProvider);
    final logic = ref.read(homeViewModelProvider.notifier);

    // 根据当前选中的索引显示不同的页面内容
    Widget currentPage;
    String appBarTitle;
    List<Widget>? appBarActions;

    switch (state.navIndex) {
      case 0:
        currentPage = const HomeContentPage();
        appBarTitle = '首页';
        appBarActions = [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _showLogoutDialog,
          ),
        ];
        break;
      case 1:
        currentPage = const ProfilePage();
        appBarTitle = '我的';
        appBarActions = null;
        break;
      case 2:
        currentPage = const SettingsPage();
        appBarTitle = '设置';
        appBarActions = null;
        break;
      default:
        currentPage = const HomeContentPage();
        appBarTitle = '首页';
        appBarActions = [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _showLogoutDialog,
          ),
        ];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: appBarActions,
      ),
      body: currentPage,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: state.navIndex,
        items: state.navItems,
        onTap: logic.onTapBottom,
        blurStrength: 12.0, // 毛玻璃模糊强度
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
              AppNavigator.logout();
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}
