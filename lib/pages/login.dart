import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project/pages/home.dart';
import 'package:project/pages/mainmenu.dart';
import 'package:project/pages/register.dart';
import 'package:project/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  var _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
            child: Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: deviceHeight * 0.30,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: FittedBox(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/applogo.png'),
                    radius: 120,
                  ),
                ),
              ),
            ),
            Container(
              height: deviceHeight * 0.65,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: LayoutBuilder(builder: (ctx, constraints) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "เข้าสู่ระบบ",
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.06,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.12,
                      decoration: BoxDecoration(
                        color: Color(0xffB4B4B4).withOpacity(0.4),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: buildemail(),
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.02,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.12,
                      decoration: BoxDecoration(
                        color: Color(0xffB4B4B4).withOpacity(0.4),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Center(
                          child: buildpassword(),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: constraints.maxHeight * 0.12,
                      margin: EdgeInsets.only(
                        top: constraints.maxHeight * 0.05,
                      ),
                      child: buildlogin(),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.02,
                    ),
                    RichText(
                        text: TextSpan(
                            text: 'คุณยังไม่ได้เป็นสมาชิก? ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            children: [
                          TextSpan(
                              text: 'สมัครสมาชิก',
                              style: TextStyle(
                                color: Color(0xffF80849),
                                fontSize: 18,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterPage(),
                                    ),
                                  );
                                })
                        ]))
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    )));
  }

  ElevatedButton buildlogin() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          print("Login Success");
          print(_emailController.text);
          AuthService.loginUser(_emailController.text, _passwordController.text)
              .then((value) {
            if (value == 1) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainPage(),
                  )
                  );
            }
          });
        }
      },
      child: Text(
        'เข้าสู่ระบบ',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      style: ElevatedButton.styleFrom(
          primary: Color(0xffF80849),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          )),
    );
  }

  TextFormField buildpassword() {
    return TextFormField(
      controller: _passwordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _isVisible ? false : true,
      validator: (value) {
        if (value!.isEmpty) {
            return "กรุณากรอกรหัสผ่าน";
        }
        return null;
      },
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _isVisible = !_isVisible;
            });
          },
          icon: Icon(
            _isVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
        ),
        border: InputBorder.none,
        hintText: 'Password',
      ),
    );
  }

  TextFormField buildemail() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "กรุณากรอกอีเมล์";
        }
        return null;
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Email',
      ),
    );
  }
}
