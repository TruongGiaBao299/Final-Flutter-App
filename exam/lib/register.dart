import 'package:exam/MainScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;
  bool _isChecked = false;
  bool _showError = false;

  void showPassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void checkTickBox() {
    setState(() {
      if (!_isChecked) {
        _showError = true;
        _isLoading = false;
      } else {
        _showError = false;
        _isLoading = true;
      }
    });
  }

  void register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _showError ? _isLoading = false : _isLoading = true;
      });
      _isLoading
          ? Future.delayed(Duration(seconds: 2), () async {
              if (_passwordController.text != "" &&
                  _emailController.text != "" &&
                  _usernameController.text != "") {
                try {
                  await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    'Register Successfully',
                    style: TextStyle(fontSize: 20),
                  )));
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.orangeAccent,
                        content: Text(
                          'Provided Password is too weak',
                          style: TextStyle(fontSize: 20),
                        )));
                  } else if (e.code == 'email-already-in-use') {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.orangeAccent,
                        content: Text(
                          'Account already exists',
                          style: TextStyle(fontSize: 20),
                        )));
                  }
                }
              }
            })
          : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 60, left: 10, right: 10),
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
                      border: OutlineInputBorder(), hintText: 'tên@gmail.com'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Không được để trống email';
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
                  'Tên người dùng',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'andrew123'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Không được để trống tên người dùng';
                    } else if (value.length < 6) {
                      return 'Tên người dùng quá ngắn';
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
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value!;
                          _showError = !_isChecked;
                        });
                      },
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(text: 'Tôi chấp nhận '),
                            TextSpan(
                                text: 'Điều khoản dịch vụ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: ' và '),
                            TextSpan(
                                text: 'Chính sách quyền riêng tư',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: ' của bạn'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                if (_showError)
                  Padding(
                    padding: const EdgeInsets.only(left: 31.0),
                    child: Text(
                      "Vui lòng chấp nhận điều khoản dịch vụ và chính sách quyền riêng tư của chúng tôi để tiếp tục",
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                SizedBox(
                  height: 22,
                ),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 14, 2, 241))),
                        onPressed: () {
                          checkTickBox();
                          register();
                        },
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
                            : const Text('Đăng ký')),
                        // child: Text('Đăng kí')),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Quay lại trang đăng nhập',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
