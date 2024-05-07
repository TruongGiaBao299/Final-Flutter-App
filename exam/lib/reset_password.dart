import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'confirm_reset.dart';

class resetPassword extends StatefulWidget {
  const resetPassword({super.key});

  @override
  State<resetPassword> createState() => _resetPasswordState();
}

class _resetPasswordState extends State<resetPassword> {
  final TextEditingController resetPass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void sentEmailReset() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      Future.delayed(Duration(seconds: 2), () async {
        String email = resetPass.text;
        try {
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => confirmReset(email: email)));
        } on FirebaseAuthException catch (e) {
          if (e.code == "user-not-found") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              'No user found for that email',
              style: TextStyle(fontSize: 20),
            )));
          }
        }
        setState(() {
          _isLoading = false;
          resetPass.clear();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 10, 4, 190),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(50),
        child: Center(
          child: Column(
            children: [
              Text(
                'Cài đặt lại mật khẩu',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                  'Hãy nhập email bạn đã dùng để đăng ký. Chúng tôi sẽ gửi cho bạn một liên kết để đăng nhập và đặt lại mật khẩu của bạn. Nếu bạn đăng ký bằng email của phụ huynh, chúng tôi sẽ gửi liên kết cho họ.'),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: resetPass,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'name@gmail.com'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Bạn chưa nhập email';
                          } else if (!value.contains('@')) {
                            return 'Không tìm thấy email';
                          }
                          return null;
                        },
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 14, 2, 241))),
                        onPressed: sentEmailReset,
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : const Text('Gửi liên kết')),
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Quay lại trang đăng nhập',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
