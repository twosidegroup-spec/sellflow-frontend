import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import 'auth_controller.dart';
import 'login_screen.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _business = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _passcode = TextEditingController();
  final _confirmPasscode = TextEditingController();

  bool _obscurePasscode = true;
  bool _obscureConfirm = true;

  Color _passcodeBorderColor = AppTheme.border;
  Color _confirmPasscodeBorderColor = AppTheme.border;

  @override
  void dispose() {
    _name.dispose();
    _business.dispose();
    _email.dispose();
    _phone.dispose();
    _passcode.dispose();
    _confirmPasscode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    if (_passcode.text != _confirmPasscode.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passcodes do not match'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        ),
      );
      return;
    }

    final success = await ref.read(authControllerProvider.notifier).register(
      fullName: _name.text.trim(),
      businessName: _business.text.trim(),
      email: _email.text.trim(),
      phone: _phone.text.trim(),
      passcode: _passcode.text.trim(),
      length: 4,
    );

    if (success && mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  Widget _buildField(String label, TextEditingController c,
      {TextInputType? type, bool obscure = false, VoidCallback? onToggleObscure, Color? borderColor, void Function(String)? onChanged, String? validator}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      margin: const EdgeInsets.only(bottom: 16),
      child: FormField(
        validator: validator != null
            ? (value) {
                if (value == null || (value is String && value.isEmpty)) return '$label is required';
                return null;
              }
            : null,
        builder: (field) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.gray,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: c,
                keyboardType: type,
                obscureText: obscure,
                maxLength: type == TextInputType.number ? 4 : null,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontSize: 14,
                  color: AppTheme.primary,
                ),
                onChanged: onChanged,
                decoration: InputDecoration(
                  isDense: true,
                  counterText: '',
                  filled: true,
                  fillColor: AppTheme.lightGray,
                  errorText: field.errorText,
                  suffixIcon: onToggleObscure != null
                      ? IconButton(
                          icon: Icon(
                            obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                            size: 18,
                            color: AppTheme.gray,
                          ),
                          onPressed: onToggleObscure,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: borderColor ?? AppTheme.border, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: borderColor ?? AppTheme.border, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: borderColor ?? AppTheme.primary, width: 1.5),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppTheme.error, width: 1.5),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authControllerProvider);
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: SizedBox(
            width: screen.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create account',
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Set up your business on SellFlow',
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontSize: 14,
                    color: AppTheme.gray,
                  ),
                ),
                const SizedBox(height: 28),
                Form(
                  key: _form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildField('FULL NAME', _name, validator: 'Full name'),
                      _buildField('BUSINESS NAME', _business, validator: 'Business name'),
                      _buildField('EMAIL', _email, type: TextInputType.emailAddress, validator: 'Email'),
                      _buildField('PHONE', _phone, type: TextInputType.phone, validator: 'Phone'),
                      _buildField(
                        'PASSCODE',
                        _passcode,
                        type: TextInputType.number,
                        obscure: _obscurePasscode,
                        onToggleObscure: () => setState(() => _obscurePasscode = !_obscurePasscode),
                        borderColor: _passcodeBorderColor,
                        onChanged: (String _) {
                          if (_passcode.text.length != 4) {
                            setState(() => _passcodeBorderColor = AppTheme.border);
                          } else if (_confirmPasscode.text.isNotEmpty) {
                            setState(() {
                              _passcodeBorderColor = _passcode.text == _confirmPasscode.text
                                  ? AppTheme.success
                                  : AppTheme.error;
                            });
                          }
                        },
                      ),
                      _buildField(
                        'CONFIRM PASSCODE',
                        _confirmPasscode,
                        type: TextInputType.number,
                        obscure: _obscureConfirm,
                        onToggleObscure: () => setState(() => _obscureConfirm = !_obscureConfirm),
                        borderColor: _confirmPasscodeBorderColor,
                        onChanged: (String _) {
                          if (_confirmPasscode.text.length != 4) {
                            setState(() => _confirmPasscodeBorderColor = AppTheme.border);
                          } else if (_passcode.text.isNotEmpty) {
                            setState(() {
                              _confirmPasscodeBorderColor = _passcode.text == _confirmPasscode.text
                                  ? AppTheme.success
                                  : AppTheme.error;
                            });
                          }
                        },
                      ),
                      if (state.error != null) ...[
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppTheme.error.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.error_outline, color: AppTheme.error, size: 16),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  state.error!,
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontFamily,
                                    fontSize: 12,
                                    color: AppTheme.error,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primary,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.background,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                TextButton(
                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  ),
                  child: Text.rich(
                    TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: 13,
                        color: AppTheme.gray,
                      ),
                      children: [
                        TextSpan(
                          text: 'Log in',
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 13,
                            color: AppTheme.primary,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
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
      ),
    );
  }
}
