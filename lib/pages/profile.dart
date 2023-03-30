import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance;

  Future<void> signOut() async {
    await currentUser.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: deviceHeight * 0.30,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: FittedBox(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://static.vecteezy.com/system/resources/previews/005/544/718/original/profile-icon-design-free-vector.jpg'),
                          radius: 120,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .where("email",
                            isEqualTo: currentUser.currentUser!.email)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, i) {
                            var data = snapshot.data!.docs[i];

                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "ชื่อผู้ใช้ : ${data['fullname']}",
                                  style: TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 5),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("rooms")
                        .where("bookedby",
                            isEqualTo: currentUser.currentUser!.uid)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, i) {
                            var data = snapshot.data!.docs[i];

                            return Padding(
                              padding: const EdgeInsets.only(top: 5, left: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "จองห้อง : ${data['roomnum']}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      signOut();
                    },
                    child: Text('Logout'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
