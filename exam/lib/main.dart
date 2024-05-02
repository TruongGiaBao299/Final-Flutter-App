import 'package:flutter/material.dart';
import 'register.dart';
import 'MainScreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: false),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _isLoading = false;

  void login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      Future.delayed(Duration(seconds: 2), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      });
    }
  }

  void showPassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void register() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText:
                            'Nhập địa chỉ email hoặc tên người dùng của bạn'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Không được để trống tên người dùng hoặc email';
                      } else if (value.length < 6) {
                        return 'Tên người dùng quá ngắn. Xin vui lòng thử lại';
                      } else if (!value.contains('@')) {
                        return 'Email không đúng định dạng. Vui lòng thử lại';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Text(
                    'Mật khẩu',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nhập mật khẩu của bạn',
                        suffixIcon: IconButton(
                            onPressed: showPassword,
                            icon: _obscureText
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Không được để trống mật khẩu';
                      } else if (value.length < 6) {
                        return 'Mật khẩu quá ngắn, vui lòng thử lại';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Bằng cách nhấn Đăng nhập, bạn chấp nhận '),
                        TextSpan(
                            text: 'Điều khoản dịch vụ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: ' và '),
                        TextSpan(
                            text: 'Chính sách quyền riêng tư',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: ' của chúng tôi'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 14, 2, 241))),
                        onPressed: login,
                        child: _isLoading
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : const Text('Đăng nhập')),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: register,
                      child: const Text(
                        'Bạn là người mới? Đăng kí ngay',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
