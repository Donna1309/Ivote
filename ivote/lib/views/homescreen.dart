import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trawell/main.dart';
import 'package:trawell/views/vote.dart';
// import 'package:trawell/views/scanScreen.dart';
// import 'package:trawell/views/speakNative.dart';
import 'package:trawell/views/candidate.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String subAdminArea = "";
  String postal = "";
  Placemark place = Placemark();

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    setState(() {
      place = placemarks[0];
    });
  }

  initialiseLocation() async {
    Position pos = await _getGeoLocationPosition();
    await GetAddressFromLatLong(pos);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initialiseLocation();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title.toString()),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body.toString())],
                  ),
                ),
              );
            });
      }
    });
  }

  void showNotification() {
    setState(() {
      _counter++;
    });
    flutterLocalNotificationsPlugin.show(
        0,
        "⚠ Warning",
        "Tourists are advised to refrain from entering waterbodies as waterlevels are increasing!",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: RichText(
            text: TextSpan(
                style: GoogleFonts.poppins(
                    fontSize: 40, fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                  text: "I ",
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).primaryColorLight)),
              TextSpan(
                  text: "VOTE",
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).primaryColor)),
            ])),
      ),
      body: SingleChildScrollView
      (
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                Position pos = await _getGeoLocationPosition();
                await GetAddressFromLatLong(pos);
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Theme.of(context).primaryColorLight,
                    child: Icon(
                      Icons.volunteer_activism,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                  Text(
                    " Lets vote and make a change",
                    style: GoogleFonts.inconsolata(fontSize: 15),
                  )
                ],
              ),
            ),
          ),
          Text(
            "Welcome to,",
            style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(
            place.subAdministrativeArea.toString(),
            style: GoogleFonts.roboto(fontSize: 35),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Date:02-07-22",
                style: GoogleFonts.inter(fontSize: 15),
              ),
              Text(
                "",
                style: GoogleFonts.inter(fontSize: 15),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                child: Container(
                  height: 40,
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "The candidates are ready      ",
                      style:
                          GoogleFonts.roboto(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),

          //SPEAK NATIVE

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                     Navigator.push(
                         context,
                        MaterialPageRoute(
                          builder: (context) => TravelCard(),
                        ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).primaryColorLight
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColorLight,
                        border: Border.all(
                            color: Theme.of(context).primaryColorLight,
                            width: 3)),
                    height: 140,
                    width: 165,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.check_box_outlined,
                          size: 50,
                          color: Colors.white,
                        ),
                        Text(
                          "Election 1",
                          style: GoogleFonts.aBeeZee(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),

                //NATIVE MARKET

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TravelCard(),
                        ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Theme.of(context).primaryColorLight,
                            Theme.of(context).primaryColor,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor,
                        border: Border.all(
                            color: Theme.of(context).primaryColorLight,
                            width: 3)),
                    height: 140,
                    width: 165,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.check_box_outlined,
                          size: 50,
                          color: Colors.white,
                        ),
                        Text(
                          "Election 2",
                          style: GoogleFonts.aBeeZee(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),

          //SCAN MONUMENT

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                       MaterialPageRoute(
                         builder: (context) => TravelCard(),
                       ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).primaryColorLight,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor,
                        border: Border.all(
                            color: Theme.of(context).primaryColorLight,
                            width: 3)),
                    height: 140,
                    width: 165,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.check_box_outlined,
                          size: 50,
                          color: Colors.white,
                        ),
                        Text(
                          "Election 3",
                          style: GoogleFonts.aBeeZee(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                /*GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TravelCard(),
                        ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Theme.of(context).primaryColorLight,
                            Theme.of(context).primaryColor,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor,
                        border: Border.all(
                            color: Theme.of(context).primaryColorLight,
                            width: 3)),
                    height: 140,
                    width: 165,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.card_membership_sharp,
                          size: 50,
                          color: Colors.white,
                        ),
                        Text(
                          "Vote poll 1",
                          style: GoogleFonts.aBeeZee(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SuggestPlan()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).primaryColorLight,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor,
                        border: Border.all(
                            color: Theme.of(context).primaryColorLight,
                            width: 3)),
                    height: 140,
                    width: 165,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.gamepad_outlined,
                          size: 50,
                          color: Colors.white,
                        ),
                        Text(
                          "Vote poll 2",
                          style: GoogleFonts.aBeeZee(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onDoubleTap: showNotification,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LocateNative()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Theme.of(context).primaryColorLight,
                            Theme.of(context).primaryColor,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColorLight,
                        border: Border.all(
                            color: Theme.of(context).primaryColorLight,
                            width: 3)),
                    height: 140,
                    width: 165,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.pin_drop,
                          size: 50,
                          color: Colors.white,
                        ),
                        Text(
                          "Vote poll 3",
                          style: GoogleFonts.aBeeZee(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
           */
              ],
          
            ),
          ),
        ],
        ),
      ),
    );
}
}