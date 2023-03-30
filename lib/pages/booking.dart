import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project/models/rooms.dart';
import 'package:project/pages/details.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  // List<Object> _roomList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
          toolbarHeight: 80, // default is 56
          toolbarOpacity: 0.5,
          automaticallyImplyLeading: false,
          title: Stack(
            children: [
            Padding(
              padding: const EdgeInsets.only(left: 2,top: 3),
              child: Container(
                margin: const EdgeInsets.only(left: 0),
                alignment: Alignment.centerLeft,
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset('assets/images/ablogo.png'),
              ),
              
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80,top: 10),
              child: Container(
                child: Text("จองห้อง",
                style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.bold),),
              ),
              
            ),
            ],
          ),
        ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            const Text("\ห้อง",
            style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("rooms").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  final snap = snapshot.data!.docs;
                  return ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: snap.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 75,
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(2, 2),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Padding(
                                      padding: const EdgeInsets.only(bottom: 6),
                                      child: Text("ห้องพัก ${snap[index]['roomnum']}",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    subtitle: Text(
                                      snap[index]['status'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,

                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(right: 20),
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailPage(snap[index]),
                                            ));
                                      },
                                      child: const Text("ดูรายละเอียด"),
                                      )
                                ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
