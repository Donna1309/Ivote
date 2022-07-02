import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trawell/views/vote.dart';

class TravelCard extends StatefulWidget {
  const TravelCard({Key? key}) : super(key: key);

  @override
  State<TravelCard> createState() => _TravelCardState();
}

class _TravelCardState extends State<TravelCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: RichText(
            text: TextSpan(
                style: GoogleFonts.poppins(
                    fontSize: 30, fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                  text: "Elec",
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).primaryColorLight)),
              TextSpan(
                  text: "tion",
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).primaryColor)),
            ])),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                     Navigator.push(
                       context,
                         MaterialPageRoute(
                        builder: (context) => MarketPage(),
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
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                        Text(
                          "Candidate 1",
                          style: GoogleFonts.aBeeZee(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
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
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                        Text(
                          "Candidate 2",
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
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "",
              style: TextStyle(fontSize: 15),
            ),
          ),
          Icon(Icons.keyboard_double_arrow_down_rounded),
          SizedBox(
            height: 20,
          ),
          child(context),
        GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MarketPage(),
                        )
                        );
                  },
           child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color:
                        Theme.of(context).primaryColorLight.withOpacity(0.4))),
            child: ListTile(
              subtitle: Text(
                "",
                style: TextStyle(color: Colors.green),
              ),
              title: Text(
                "Candidate 2",
                style: TextStyle(fontSize: 20),
              ),
              trailing: Icon(Icons.check_box_outline_blank_outlined),
            ),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector child(BuildContext context) {
    return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MarketPage(),
                      )
                      );
                },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color:
                        Theme.of(context).primaryColorLight.withOpacity(0.4))),
            child: ListTile(
              subtitle: Text(
                "",
                style: TextStyle(color: Colors.green),
              ),
              title: Text(
                "Candidate 1",
                style: TextStyle(fontSize: 20),
              ),
              trailing: Icon(Icons.check_box_outline_blank_outlined),
            ),
          ),
        );
      
  }
}
