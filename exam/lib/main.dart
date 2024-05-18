import 'package:exam/db_connect.dart';
import 'package:exam/question_quiz_model.dart';
import 'package:exam/typing_word_question_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import 'reset_password.dart';
import 'MainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // var db = DBconnect();
  // db.addQuestion(typeQuestion(
  //     givenTitle: 'Xin chào', titleAnswer: 'Hello', hiddenWord: 'H____'));
  // db.addQuestion(typeQuestion(
  //     givenTitle: 'Tạm biệt', titleAnswer: 'Good Bye', hiddenWord: 'G__d B_e'));
  // db.addQuestion(
  //     typeQuestion(givenTitle: 'Ăn', titleAnswer: 'Eat', hiddenWord: 'E__'));
  // db.addQuestion(typeQuestion(
  //     givenTitle: 'Uống', titleAnswer: 'Drink', hiddenWord: 'Dr___'));
  // db.addQuestion(typeQuestion(
  //     givenTitle: 'Kem', titleAnswer: 'Ice cream', hiddenWord: 'I___ c___'));
  // db.addQuestion(typeQuestion(
  //     givenTitle: 'Xà lách', titleAnswer: 'Salad', hiddenWord: 'S_l__'));
  // db.addQuestion(typeQuestion(
  //     givenTitle: 'Rau củ quả',
  //     titleAnswer: 'Vegetable',
  //     hiddenWord: 'V__t___'));
  // db.addQuestion(Questions(
  //     id: '1',
  //     title: 'What is the meaning of "Hello"',
  //     options: {
  //       'Xin chào': true,
  //       'Tạm biệt': false,
  //       'Đi ngủ': false,
  //       'Anh ấy': false
  //     }));
  // db.addQuestion(Questions(
  //     id: '2',
  //     title: 'What is the meaning of "Good Bye"',
  //     options: {
  //       'Xin chào': false,
  //       'Tạm biệt': true,
  //       'Đi ngủ': false,
  //       'Anh ấy': false
  //     }));
  // db.addQuestion(Questions(
  //     id: '3',
  //     title: 'What is the meaning of "Eat"',
  //     options: {'Uống': false, 'Ngủ': false, 'Ăn': true, 'Anh ấy': false}));
  // db.addQuestion(Questions(
  //     id: '4',
  //     title: 'What is the meaning of "Drink"',
  //     options: {'Uống': true, 'Ngủ': false, 'Ăn': false, 'Anh ấy': false}));
  // db.addQuestion(Questions(
  //     id: '5',
  //     title: 'What is the meaning of "Ice cream"',
  //     options: {
  //       'Sữa chua': false,
  //       'Kem': true,
  //       'Trái táo': false,
  //       'Thịt kho': false
  //     }));
  // db.addQuestion(Questions(
  //     id: '6',
  //     title: 'What is the meaning of "Salad"',
  //     options: {
  //       'Trái cây': false,
  //       'Ngũ cốc': false,
  //       'Xà lách': true,
  //       'Trái lê': false
  //     }));
  // db.addQuestion(Questions(
  //     id: '7',
  //     title: 'What is the meaning of "Vegetable"',
  //     options: {
  //       'Rau củ quả': true,
  //       'Tạm biệt': false,
  //       'Đi ngủ': false,
  //       'Anh ấy': false
  //     }));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  bool isLoggedIn = await checkLoginStatus();

  runApp(MaterialApp(
    routes: {'/login': (context) => MyApp()},
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: false),
    home: isLoggedIn ? MainScreen() : MyApp(),
  ));
}

Future<void> saveLoginStatus(bool isLoggedIn) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', isLoggedIn);
}

Future<bool> checkLoginStatus() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}

class MyApp extends StatefulWidget {
  MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _isLoading = false;

  void login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
        await saveLoginStatus(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
        setState(() {
          _emailController.clear();
          _passwordController.clear();
          _isLoading = false;
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          _isLoading = false;
        });
        if (e.code == 'user-not-found') {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Lỗi'),
              content: Text('Không tìm thấy người dùng cho địa chỉ email này'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Đóng'),
                ),
              ],
            ),
          );
        } else if (e.code == 'wrong-password') {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Lỗi'),
              content: Text('Mật khẩu không đúng'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Đóng'),
                ),
              ],
            ),
          );
        }
      }
    }
  }

  void showPassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void register() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const RegisterScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100, left: 15, right: 15),
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Quizlet',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Email',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
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
                  const SizedBox(
                    height: 22,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Mật khẩu',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => resetPassword()));
                        },
                        mouseCursor: SystemMouseCursors.click,
                        child: Text(
                          'Quên mật khẩu',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Nhập mật khẩu của bạn',
                        suffixIcon: IconButton(
                            onPressed: showPassword,
                            icon: _obscureText
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Không được để trống mật khẩu';
                      } else if (value.length < 6) {
                        return 'Mật khẩu quá ngắn, vui lòng thử lại';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  RichText(
                    text: const TextSpan(
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
                  const SizedBox(
                    height: 22,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 14, 2, 241)),
                      ),
                      onPressed: () {
                        login(); // Removed setState(_isLoading = true);
                      },
                      child: _isLoading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Text('Đăng nhập'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
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
