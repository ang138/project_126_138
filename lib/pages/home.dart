import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomaPage extends StatefulWidget {
  const HomaPage({super.key});

  @override
  State<HomaPage> createState() => _HomaPageState();
}

class _HomaPageState extends State<HomaPage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  final controller = CarouselController();
  final List<String> imgList = [
    'https://firebasestorage.googleapis.com/v0/b/hotel-73108.appspot.com/o/images%2Fdorm1.jpg?alt=media&token=ba33a2c3-677d-461c-80a1-2e0a7b5872d7',
    'https://firebasestorage.googleapis.com/v0/b/hotel-73108.appspot.com/o/images%2Fdorm2.jpg?alt=media&token=e2991215-aa14-49db-a6de-3832c1928ca3',
    'https://firebasestorage.googleapis.com/v0/b/hotel-73108.appspot.com/o/images%2Fdorm4.jpg?alt=media&token=70abff30-95ec-483b-be99-a629c360ddce',
    'https://firebasestorage.googleapis.com/v0/b/hotel-73108.appspot.com/o/images%2Fdorm5.jpg?alt=media&token=68d99fd9-678c-4551-9a67-be28cda2e045',
    'https://firebasestorage.googleapis.com/v0/b/hotel-73108.appspot.com/o/images%2Fdorm7.jpg?alt=media&token=0a9cfb64-16ea-48b9-9bce-3b5211e2c93b',
  ];

  int currentIndex = 0;

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
                child: Text("หน้าหลัก",
                style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.bold),),
              ),
              
            ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  viewportFraction: 0.95,
                  onPageChanged: (index, carouselReason) {
                    setState(() {
                      _current = index;
                    });
                  },
                  enlargeCenterPage: true,
                ),
                items: imgList
                    .map((item) => Container(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Container(
                              margin: EdgeInsets.all(5.0),
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  child: Stack(
                                    children: <Widget>[
                                      Image.network(item,
                                          fit: BoxFit.cover, width: 1000.0),
                                      Positioned(
                                        bottom: 0.0,
                                        left: 0.0,
                                        right: 0.0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color.fromARGB(200, 0, 0, 0),
                                                Color.fromARGB(0, 0, 0, 0)
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ))
                    .toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imgList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black)
                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
              Container(
                  height: 500,
                  width: double.infinity,
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(2, 2),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "Contact",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: double.infinity,
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
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
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, top: 5),
                              child: Container(
                                margin: const EdgeInsets.only(left: 0),
                                alignment: Alignment.centerLeft,
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset('assets/images/best.jpg'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 15, left: 45),
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 6),
                                              child: Text(
                                                "ชื่อ : เบส",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            subtitle: Text(
                                              "รหัสนิสิต : 632021126",
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        width: double.infinity,
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
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
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, top: 5),
                              child: Container(
                                margin: const EdgeInsets.only(left: 0),
                                alignment: Alignment.centerLeft,
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset('assets/images/cat.jpg'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 15, left: 45),
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 6),
                                              child: Text(
                                                "ชื่อ : อัง",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            subtitle: Text(
                                              "รหัสนิสิต : 632021138",
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }
}
