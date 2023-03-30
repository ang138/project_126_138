import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project/services/auth_service.dart';



class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _tel = TextEditingController();
  final TextEditingController _type = TextEditingController();

  var _isVisible = false;

  String isRadio = "";

  CollectionReference users = FirebaseFirestore.instance.collection('users');

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
              height: deviceHeight * 0.65,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: LayoutBuilder(builder: (ctx, constraints) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "สมัครสมาชิก",
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.01,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.12,
                      decoration: BoxDecoration(
                        color: Color(0xffB4B4B4).withOpacity(0.4),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: buildEmail(),
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
                        child: buildName(),
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
                        child: buildTel(),
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
                          child: buildPassword(),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: constraints.maxHeight * 0.12,
                      margin: EdgeInsets.only(
                        top: constraints.maxHeight * 0.05,
                      ),
                      child: registerButton(),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.02,
                    ),

                  ],
                );
              }),
            ),
          ],
        ),
      ),
    )));
  }

  TextFormField buildTel() {
    return TextFormField(
      controller: _tel,
      validator: (value) {
        if (value!.isEmpty) {
          return "กรุณากรอกเบอร์โทรศัพท์";
        }
        return null;
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'เบอร์โทรศัพท์',
      ),
    );
  }

  TextFormField buildName() {
    return TextFormField(
      controller: _name,

      validator: (value) {
        if (value!.isEmpty) {
          return "กรุณากรอกชื่อผู้ใช้";
        }
        return null;
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'ชื่อ',
      ),
      
    );
  }

  ElevatedButton registerButton() {
    return ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            print("Ok");
            print(_emailController.text);
            AuthService.registerUser(
                    _emailController.text, _passwordController.text)
                .then((value) {
              if (value == 1) {
                final uid = FirebaseAuth.instance.currentUser!.uid;
                users.doc(uid).set({
                  "fullname": _name.text,
                  "email": _emailController.text,
                  "telephone": _tel.text,
                  "createOn": FieldValue.serverTimestamp()
                });
                Navigator.pop(context);
              }
            });
          }
        },
        child: Text(
        'ลงทะเบียน',
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
  TextFormField buildPassword() {
    return TextFormField(
      controller: _passwordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _isVisible ? false : true,
      validator: (value) {
        if (value!.isEmpty) {
          return "กรุณากรอกรหัสผ่่าน";
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
        hintText: 'รหัสผ่่าน',
      ),
    );
    
  }

  TextFormField buildEmail() {
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
        hintText: 'อีเมล์',
      ),
    );
  }

}