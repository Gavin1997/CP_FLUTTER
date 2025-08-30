import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/log/app_logger.dart';
import '../../../core/router/app_router.dart';
import '../../../core/storage/storage_manager.dart';

/// 登录状态
class RegisterState {
  final bool isLoading;
  final String? error;

  const RegisterState({
    this.isLoading = false,
    this.error,
  });

  RegisterState copyWith({
    bool? isLoading,
    String? error,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// 登录 ViewModel
class RegisterViewModel extends StateNotifier<RegisterState> {
  RegisterViewModel() : super(const RegisterState());

  /// 登录
  Future<void> register({
    required String username,
    required String password,
  }) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      AppLogger.info('开始登录: $username');

      // 模拟网络请求
      await Future.delayed(const Duration(seconds: 2));

      // 简单的模拟登录验证
      if (username == 'admin' && password == '123456') {
        // 登录成功，保存用户信息
        await _saveUserData(username);

        AppLogger.info('登录成功: $username');
        Fluttertoast.showToast(msg: '登录成功');

        // 跳转到主页
        AppNavigator.toHome();
      } else {
        throw Exception('用户名或密码错误');
      }

      // 实际项目中的网络请求示例：
      /*
      final response = await NetworkManager.post('/auth/Register', data: {
        'username': username,
        'password': password,
      });
      
      if (response.statusCode == 200) {
        final data = response.data;
        await _saveUserData(data['user'], data['token']);
        AppNavigator.toHome();
      }
      */
    } catch (e) {
      AppLogger.error('登录失败', error: e);
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );

      Fluttertoast.showToast(
        msg: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  /// 保存用户数据
  Future<void> _saveUserData(String username) async {
    // 保存 Token
    await StorageManager.saveToken(
        'mock_token_${DateTime.now().millisecondsSinceEpoch}');

    // 保存用户信息
    await StorageManager.saveUserInfo({
      'id': 1,
      'username': username,
      'nickname': '用户$username',
      'avatar': '',
      'email': '$username@example.com',
      'RegisterTime': DateTime.now().toIso8601String(),
    });

    state = state.copyWith(isLoading: false);
  }

  /// 清除错误
  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// 注册 ViewModel Provider
final RegisterViewModelProvider =
    StateNotifierProvider<RegisterViewModel, RegisterState>((ref) {
  return RegisterViewModel();
});
