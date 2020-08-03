import 'package:covid_19/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrevetionCards extends StatelessWidget {
  final String title;
  final String preventImage;

  const PrevetionCards({
    Key key,
    this.title,
    this.preventImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SvgPicture.asset(preventImage),
        Text(
          title,
          style:
              Theme.of(context).textTheme.bodyText2.copyWith(color: kTextColor),
        )
      ],
    );
  }
}
