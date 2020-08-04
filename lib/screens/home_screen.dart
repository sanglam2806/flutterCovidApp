import 'dart:convert';

import 'package:covid_19/constants.dart';
import 'package:covid_19/screens/new_case_screen.dart';
import 'package:covid_19/widgets/infor_card.dart';
import 'package:covid_19/widgets/prevention_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import "dart:async";
import "package:http/http.dart" as http;

int newConfirmed;
int totalConfirmed;
int totalDeaths;
int totalRecovered;

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(.1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Wrap(
                runSpacing: 15,
                spacing: 15,
                children: <Widget>[
                  InforCard(
                    title: "Confirm Cases",
                    iconColor: Color(0xFFFF8C00),
                    effectNum: totalConfirmed,
                    press: () {},
                  ),
                  InforCard(
                    title: "Total Deaths",
                    iconColor: Color(0xFFFF2D55),
                    effectNum: totalDeaths,
                    press: () {},
                  ),
                  InforCard(
                    title: "Total Recovered",
                    iconColor: Color(0xFF50E3C2),
                    effectNum: totalRecovered,
                    press: () {},
                  ),
                  InforCard(
                    title: "New Cases",
                    iconColor: Color(0xFF5856D6),
                    effectNum: newConfirmed,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return NewCaseScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Preventions",
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  buildPrevetion(),
                  SizedBox(height: 30),
                  buildHelpCard(context)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildPrevetion() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        PrevetionCards(
          title: "Wash Hands",
          preventImage: "assets/icons/hand_wash.svg",
        ),
        PrevetionCards(
          title: "Clean Disinfect",
          preventImage: "assets/icons/Clean_Disinfect.svg",
        ),
        PrevetionCards(
          title: "Use Mask",
          preventImage: "assets/icons/use_mask.svg",
        ),
      ],
    );
  }

  Container buildHelpCard(Object context) {
    return Container(
      height: 150,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * .4,
              top: 20,
            ),
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF60BE93),
                  Color(0xFF1D8B59),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Dial 999 for \nmedical HELP!",
                    style: Theme.of(context).textTheme.title.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  TextSpan(
                    text: "\nIf any symtoms apprear",
                    style: TextStyle(
                      color: Colors.white.withOpacity(.4),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SvgPicture.asset("assets/icons/nurse.svg"),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: SvgPicture.asset("assets/icons/virus.svg"),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor.withOpacity(.1),
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {},
        )
      ],
    );
  }
}

Future<String> getData() async {
  http.Response response = await http.get(
      Uri.encodeFull("https://api.covid19api.com/summary"),
      headers: {"Accept": "application/json"});
  Map<String, dynamic> data = JsonDecoder().convert(response.body);
  for (var country in data["Countries"]) {
    if (country["CountryCode"] == ("VN")) {
      print(country);
      newConfirmed = int.parse(country["NewConfirmed"].toString());
      totalConfirmed = int.parse(country["TotalConfirmed"].toString());
      totalDeaths = int.parse(country["TotalDeaths"].toString());
      totalRecovered = int.parse(country["TotalRecovered"].toString());
    }
  }
  // print(data["Countries"]);
}
