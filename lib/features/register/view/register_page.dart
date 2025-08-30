/*
 * @Author: test
 * @Date: 2025-08-30 13:45:35
 * @LastEditTime: 2025-08-30 23:50:05
 * @FilePath: /flutter_starter/lib/features/register/view/register_page.dart
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:kxrcp/core/router/app_router.dart';
import '../../../common/widgets/app_button.dart';
import '../view_model/register_view_model.dart';

/// 登录页面
///
class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(registerViewModelProvider);
    final registerNotifier = ref.read(registerViewModelProvider.notifier);

    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(24.w),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 60.h),

              // Logo 和标题
              Center(
                child: Column(
                  children: [
                    Text(
                      '欢迎注册磕星人',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      width: 100.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 50.w,
                        height: 50.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '请注册您的账户',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 48.h),

              // 用户名输入框
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: '用户名',
                  hintText: '请输入用户名',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入用户名';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16.h),

              // 密码输入框
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: '密码',
                  hintText: '请输入密码',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入密码';
                  }
                  if (value.length < 6) {
                    return '密码长度不能少于6位';
                  }
                  return null;
                },
              ),

              SizedBox(height: 24.h),

              // 注册按钮
              AppButton.primary(
                text: '注册',
                isLoading: registerState.isLoading,
                onPressed: () => _handleRegister(registerNotifier),
              ),

              SizedBox(height: 16.h),

              const Spacer(),

              // 登录提示
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '已有账户？',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14.sp,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: 跳转到登录页面
                      AppNavigator.toLogin();
                    },
                    child: Text(
                      '立即登录',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  /// 处理注册
  void _handleRegister(RegisterViewModel registerNotifier) {
    if (_formKey.currentState?.validate() ?? false) {
      registerNotifier.register(
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );
    }
  }
}
