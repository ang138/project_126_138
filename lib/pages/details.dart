import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  var snap;
  DetailPage(this.snap);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  CollectionReference bookings =
      FirebaseFirestore.instance.collection('bookings');

  CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');

  final String image = "assets/images/ablogo.png";

  @override
  Widget build(BuildContext context) {
    final elevatedButtonStyle = ElevatedButton.styleFrom(
      primary: Colors.purple,
      onPrimary: Colors.white,
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 32.0,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              foregroundDecoration: BoxDecoration(color: Colors.black26),
              height: 400,
              child: Image.network(widget.snap['img'], fit: BoxFit.cover)),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 250),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "ห้องพัก ${widget.snap['roomnum']}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(32.0),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    widget.snap['status'],
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )),
                          Column(
                            children: <Widget>[
                              Text(
                                "${widget.snap['price'].toString()} บาท/เดือน",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      SizedBox(
                        width: double.infinity,
                        child: Booking(elevatedButtonStyle),
                      ),
                      const SizedBox(height: 30.0),
                      Text(
                        "รายละเอียด".toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 30),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "มี ${widget.snap['bed']} เตียงนอน",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      Text(
                        "มี ${widget.snap['toilet']} ห้องนํ้า",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                "รายละเดียด",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget Booking(ButtonStyle elevatedButtonStyle) {
    return FutureBuilder<bool>(
      future: isUserBooked(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        bool userHasBooking = snapshot.data ?? false;
        bool roomIsAvailable = widget.snap['status'] != "ไม่ว่าง";
       bool userIsBooker = widget.snap.data()!.containsKey('bookedby') &&
                    FirebaseAuth.instance.currentUser!.uid == widget.snap['bookedby'];

        return Column(
          children: [
            ElevatedButton(
              style: elevatedButtonStyle,
              onPressed: !userHasBooking && roomIsAvailable
                  ? () {
                      AwesomeDialog(
                          context: context,
                          dialogType: DialogType.question,
                          animType: AnimType.topSlide,
                          showCloseIcon: true,
                          title: "ยืนยันการจองห้องหรือไม่",
                          desc:
                              "เมื่อคุณยืนยันโปรดติดต่อเจ้าหน้าที่หรือพนักงาน",
                          btnCancelOnPress: () {},
                          btnOkOnPress: () async {
                            final uid = FirebaseAuth.instance.currentUser!.uid;

                            await rooms
                                .doc(widget.snap.id)
                                .update({"status": "ไม่ว่าง", "bookedby": uid});
                            Navigator.pop(context);
                          }).show();
                    }
                  : null,
              child: roomIsAvailable
                  ? Text(
                      userHasBooking ? "คุณได้จองห้องแล้ว" : "จอง",
                      style: TextStyle(fontSize: 20),
                    )
                  : Text(
                      "จองไปแล้ว",
                      style: TextStyle(fontSize: 20),
                    ),
            ),
            if (!roomIsAvailable && userIsBooker) SizedBox(height: 10),
            if (!roomIsAvailable && userIsBooker)
              ElevatedButton(
                style: elevatedButtonStyle,
                onPressed: () {
                  AwesomeDialog(
                      context: context,
                      dialogType: DialogType.question,
                      animType: AnimType.topSlide,
                      showCloseIcon: true,
                      title: "ยืนยันการยกเลิกการจองหกห้องหรือไม่",
                      desc: "เมื่อคุณยืนยันการยกเลิก ห้องนี้จะกลับสู่สถานะว่าง",
                      btnCancelOnPress: () {},
                      btnOkOnPress: () async {
                        await cancelBooking();
                        Navigator.pop(context);
                      }).show();
                },
                child: Text(
                  "ยกเลิกการจอง",
                  style: TextStyle(fontSize: 20),
                ),
              ),
          ],
        );
      },
    );
  }

  Future<void> cancelBooking() async {
    await rooms
        .doc(widget.snap.id)
        .update({"status": "ว่าง", "bookedby": FieldValue.delete()});
  }

    Future<bool> isUserBooked() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final snapshot = await rooms.where('bookedby', isEqualTo: uid).get();
    return snapshot.docs.isNotEmpty;
  }

}
