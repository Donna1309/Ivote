import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:trawell/main.dart';
import 'package:trawell/models/api_post.dart';
import 'package:trawell/models/api_service.dart';
import 'package:trawell/models/market_model.dart';

class MarketPage extends StatelessWidget
{
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 7,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: RichText(
            text: TextSpan(
                style: GoogleFonts.poppins(
                    fontSize: 30, fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                  text: "Vote ",
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).primaryColorLight)),
              TextSpan(
                  text: "Recorded",
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
              onTap: () {},
              child: Row(
                children: [
                 
                  Text (" Vote recorded successfully! ",
                  textAlign: TextAlign.center,
                    style: GoogleFonts.inconsolata(fontSize: 15),
                  )
                ],
              ),
            ),
          ),
        ]
           ) )
    );
  }
}