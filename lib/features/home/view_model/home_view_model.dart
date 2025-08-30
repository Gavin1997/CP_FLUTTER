import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/widgets/custom_bottom_nav_bar.dart';

/// 首页状态
class HomeState {
  final int navIndex;
  final List<BottomNavItem> navItems;

  const HomeState({
    this.navIndex = 0,
    this.navItems = const [],
  });

  HomeState copyWith({
    int? navIndex,
    List<BottomNavItem>? navItems,
  }) {
    return HomeState(
      navIndex: navIndex ?? this.navIndex,
      navItems: navItems ?? this.navItems,
    );
  }
}

/// 首页 ViewModel
class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel() : super(const HomeState()) {
    _initializeNavItems();
  }

  /// 初始化导航项
  void _initializeNavItems() {
    state = state.copyWith(
      navItems: [
        const BottomNavItem(
          icon: Icons.home_outlined,
          activeIcon: Icon(Icons.home),
          label: '首页',
        ),
        const BottomNavItem(
          icon: Icons.person_outline,
          activeIcon: Icon(Icons.person),
          label: '我的',
        ),
        const BottomNavItem(
          icon: Icons.settings_outlined,
          activeIcon: Icon(Icons.settings),
          label: '设置',
        ),
      ],
    );
  }

  /// 底部导航点击处理
  void onTapBottom(int index) {
    if (index == state.navIndex) return;

    // 切换到选中的页面索引
    state = state.copyWith(navIndex: index);
  }

  /// 获取当前选中的导航项
  BottomNavItem? get currentNavItem {
    if (state.navItems.isEmpty || state.navIndex >= state.navItems.length) {
      return null;
    }
    return state.navItems[state.navIndex];
  }
}

/// 首页 ViewModel Provider
final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, HomeState>((ref) {
  return HomeViewModel();
});
