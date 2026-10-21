import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SellFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light(
          primary: Colors.blue,
          secondary: Colors.blueAccent,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _code = '';
  bool _isLoading = false;
  bool _isCorrect = false;
  bool _isWrong = false;

  final String _correctCode = '1234';

  void _onDigit(int digit) {
    if (_code.length < 4 && !_isLoading) {
      setState(() => _code = _code + digit.toString());
    }
  }

  void _onBackspace() {
    if (_code.isNotEmpty && !_isLoading) {
      setState(() => _code = _code.substring(0, _code.length - 1));
    }
  }

  Future<void> _submit() async {
    if (_code.length != 4) return;

    setState(() {
      _isLoading = true;
      _isWrong = false;
      _isCorrect = false;
    });

    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _isLoading = false;
      if (_code == _correctCode) {
        _isCorrect = true;
      } else {
        _isWrong = true;
      }
    });

    Future.delayed(Duration(milliseconds: 2000), () {
      if (mounted) {
        setState(() {
          _code = '';
          _isCorrect = false;
          _isWrong = false;
        });
      }
    });
  }

  Color getDotColor(int index) {
    if (_isCorrect) return Colors.green;
    if (_isWrong) return Colors.red;
    return index < _code.length ? Colors.blue : Colors.grey.shade300;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Enter your passcode to continue',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade600,
                  ),
                ),

                SizedBox(height: 40),

                // Passcode dots
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade300, width: 2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: getDotColor(index),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: getDotColor(index),
                            width: 2,
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                SizedBox(height: 30),

                // Feedback message
                if (_isCorrect)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, color: Colors.green, size: 20),
                        SizedBox(width: 8),
                        Text('Success!', style: TextStyle(color: Colors.green.shade700, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  )
                else if (_isWrong)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, color: Colors.red, size: 20),
                        SizedBox(width: 8),
                        Text('Wrong code', style: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  )
                else if (_code.length < 4)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.info, color: Colors.blue, size: 20),
                        SizedBox(width: 8),
                        Text('Enter 4 digits', style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  )
                else
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.lock, color: Colors.grey.shade600, size: 18),
                        SizedBox(width: 8),
                        Text('Enter passcode', style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),

                SizedBox(height: 30),

                // Keypad
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildKeyRow([1, 2, 3]),
                      SizedBox(height: 16),
                      _buildKeyRow([4, 5, 6]),
                      SizedBox(height: 16),
                      _buildKeyRow([7, 8, 9]),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 55),
                          _buildKey('0'),
                          SizedBox(width: 12),
                          _buildKey(Icons.backspace_outlined, isIcon: true),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                // Footer
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('New to SellFlow? '),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Create account',
                        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildKey(dynamic content, {bool isIcon = false}) {
    return GestureDetector(
      onTap: () {
        if (isIcon) {
          _onBackspace();
        } else {
          _onDigit(content as int);
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          color: _isLoading ? Colors.grey.shade200 : Colors.blue.shade50,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: isIcon
              ? Icon(content as IconData, color: Colors.blue, size: 22)
              : Text(
                  content as String,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildKeyRow(List<int> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: numbers.map((num) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: _buildKey(num),
        );
      }).toList(),
    );
  }
}
