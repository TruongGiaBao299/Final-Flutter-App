import 'package:flutter/material.dart';
import 'package:exam/main.dart';

class confirmReset extends StatefulWidget {
  String email;
  confirmReset({super.key, required this.email});

  @override
  State<confirmReset> createState() => _confirmResetState();
}

class _confirmResetState extends State<confirmReset> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 10, 4, 190),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 10, top: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Kiểm tra email của bạn!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Chúng tôi đã gửi email đến ${widget.email}'),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                        'Vui lòng kiểm tra hộp thư rác nếu bạn không thấy email trong hộp thư đến của mình.'),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyApp()));
                    },
                    mouseCursor: MaterialStateMouseCursor.clickable,
                    child: Text(
                      'Trở lại trang đăng nhập',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
