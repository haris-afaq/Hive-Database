import 'package:flutter/material.dart';
import 'package:hive_database/constants/colors.dart';

class Bodytext extends StatelessWidget {
  String description;
  final Color? color;

  Bodytext({required this.description, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.blackColor,
      ),
    );
  }
}
