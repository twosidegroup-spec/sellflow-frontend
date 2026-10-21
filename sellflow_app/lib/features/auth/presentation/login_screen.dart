import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import 'auth_controller.dart';
import 'register_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String _code = '';

  void _onDigit(int digit) {
    if (_code.length < 4 && mounted) {
      setState(() => _code = _code + digit.toString());
    }
  }

  void _onBackspace() {
    if (_code.isNotEmpty && mounted) {
      setState(() => _code = _code.substring(0, _code.length - 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authControllerProvider);
    final busy = state.status == AuthStatus.working;
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: screen.width,
          height: screen.height,
          child: Column(
            children: [
              // Header section
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Welcome back!',
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'We\'re so happy to see you again! ❤️',
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 14,
                          color: AppTheme.gray,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Passcode dots and keypad section
              Expanded(
                flex: 4,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      // Passcode dots
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(4, (index) {
                          final filled = _code.length > index;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            curve: Curves.easeOut,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: filled ? AppTheme.primary : null,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: filled ? AppTheme.primary : AppTheme.border,
                                width: 1.5,
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 32),
                      // Numeric keypad
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: AppTheme.background,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Keys 1-9
                            _buildKeyRow([1, 2, 3], busy),
                            const SizedBox(height: 16),
                            _buildKeyRow([4, 5, 6], busy),
                            const SizedBox(height: 16),
                            _buildKeyRow([7, 8, 9], busy),
                            const SizedBox(height: 16),
                            // Bottom row: empty, 0, backspace
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(width: 60, height: 60),
                                GestureDetector(
                                  onTap: busy ? null : () => _onDigit(0),
                                  child: _buildCircleKey('0', busy),
                                ),
                                const SizedBox(width: 12),
                                GestureDetector(
                                  onTap: busy ? null : _onBackspace,
                                  child: _buildCircleKey(Icons.backspace_rounded, busy, isIcon: true),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Bottom action
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const RegisterScreen()),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'New to SellFlow? ',
                              style: TextStyle(
                                fontFamily: AppTheme.fontFamily,
                                fontSize: 14,
                                color: AppTheme.gray,
                              ),
                            ),
                            Text(
                              'Create account',
                              style: TextStyle(
                                fontFamily: AppTheme.fontFamily,
                                fontSize: 14,
                                color: AppTheme.primary,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircleKey(dynamic content, bool busy, {bool isIcon = false}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: busy ? AppTheme.gray.withOpacity(0.1) : AppTheme.lightGray,
        shape: BoxShape.circle,
        border: Border.all(
          color: busy ? AppTheme.border : AppTheme.border,
          width: 1,
        ),
      ),
      child: Center(
        child: isIcon
            ? Icon(content as IconData, color: busy ? AppTheme.gray : AppTheme.primary, size: 24)
            : Text(
                content as String,
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: busy ? AppTheme.gray : AppTheme.primary,
                ),
              ),
      ),
    );
  }

  Widget _buildKeyRow(List<int> numbers, bool busy) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: numbers.map((num) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GestureDetector(
            onTap: busy ? null : () => _onDigit(num),
            child: _buildCircleKey(num.toString(), busy),
          ),
        );
      }).toList(),
    );
  }
}
